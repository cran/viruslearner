#' CD4 Cell Count or Viral Load Ensemble Learning Through Stacking of Models.
#'
#' Stacking ensemble approach to combine predictions from various models, 
#' allowing for grid search of tuning hyperparameters. 
#'
#' @param outcome The name of the outcome variable.
#' @param traindata The training dataset.
#' @param viralvars Vector of variable names related to viral data.
#' @param logbase The base for logarithmic transformations.
#' @param seed Seed for reproducibility.
#' @param repetitions Number of repetitions for cross-validation.
#' @param gridsize Size of the grid for hyperparameter tuning.
#' @param mode Is the mode of the model regression? "regression" (TRUE) or "classification" (FALSE).
#' @param type Is the type of modeling ensemble? "ensemble" (TRUE) or "individual" (FALSE).
#'
#' @return A stacked ensemble model or individual models based on the specified type.
#' @export
#'
#' @examples
#' \donttest{
#' library(baguette)
#' library(kernlab)
#' library(kknn)
#' library(ranger)
#' library(rules)
#' data("cd_train", package = "viruslearner")
#' outcome <- "cd_2023"
#' traindata <- cd_train
#' viralvars <- c("vl_2019", "vl_2021", "vl_2022", "vl_2023")
#' logbase <- 10
#' seed <- 1501
#' repetitions <- 2
#' gridsize <- 1
#' set.seed(123)
#' cd_ens(outcome, traindata, viralvars, logbase, seed, repetitions, gridsize, TRUE, TRUE)
#' }
cd_ens <-  function(outcome, traindata, viralvars, logbase, seed, repetitions, gridsize, mode = TRUE, type = TRUE) {
  if (type == FALSE) {
    if (mode == TRUE) {
      return(
        dplyr::bind_rows(
          workflowsets::workflow_set(
            preproc = list(simple = workflows::workflow_variables(outcomes = tidyselect::all_of(outcome), predictors = tidyselect::everything())),
            models = list(rf = parsnip::rand_forest(mtry = hardhat::tune(), min_n = hardhat::tune(), trees = hardhat::tune()) |> 
                            parsnip::set_engine("ranger") |> 
                            parsnip::set_mode("regression"),
                          CART_bagged = parsnip::bag_tree() |>
                            parsnip::set_engine("rpart", times = 50L) |>
                            parsnip::set_mode("regression"),
                          Cubist = parsnip::cubist_rules(committees = hardhat::tune(), neighbors = hardhat::tune()) |>
                            parsnip::set_engine("Cubist")
            )
          ),
          workflowsets::workflow_set(
            preproc = list(normalized = recipes::recipe(stats::as.formula(paste(outcome, "~ .")), data = traindata) |>
                             recipes::step_log(tidyselect::all_of(viralvars), base = logbase) |>
                             recipes::step_normalize(recipes::all_predictors())),
            models = list(SVM_radial = parsnip::svm_rbf(cost = hardhat::tune(), rbf_sigma = hardhat::tune()) |>
                            parsnip::set_engine("kernlab") |>
                            parsnip::set_mode("regression"),
                          SVM_poly = parsnip::svm_poly(cost = hardhat::tune(), degree = hardhat::tune()) |>
                            parsnip::set_engine("kernlab") |>
                            parsnip::set_mode("regression"),
                          KNN = parsnip::nearest_neighbor(neighbors = hardhat::tune(), dist_power = hardhat::tune(), weight_func = hardhat::tune()) |>
                            parsnip::set_engine("kknn") |>
                            parsnip::set_mode("regression"),
                          neural_network = parsnip::mlp(hidden_units = hardhat::tune(), penalty = hardhat::tune(), epochs = hardhat::tune()) |>
                            parsnip::set_engine("nnet", MaxNWts = 2600) |>
                            parsnip::set_mode("regression")
            )
          ) |>
            workflowsets::option_add(param_info = parsnip::mlp(hidden_units = hardhat::tune(), penalty = hardhat::tune(), epochs = hardhat::tune()) |>
                                       parsnip::set_engine("nnet", MaxNWts = 2600) |>
                                       parsnip::set_mode("regression") |>
                                       tune::extract_parameter_set_dials() |>
                                       recipes::update(hidden_units = dials::hidden_units(c(1, 27))),
                                     id = "normalized_neural_network"),
          workflowsets::workflow_set(
            preproc = list(full_quad = recipes::recipe(stats::as.formula(paste(outcome, "~ .")), data = traindata) |>
                             recipes::step_log(tidyselect::all_of(viralvars), base = logbase) |>
                             recipes::step_normalize(recipes::all_predictors())  |>
                             recipes::step_poly(recipes::all_predictors()) |>
                             recipes::step_interact(~ recipes::all_predictors():recipes::all_predictors())
            ),
            models = list(linear_reg = parsnip::linear_reg(penalty = hardhat::tune(), mixture = hardhat::tune()) |>
                            parsnip::set_engine("glmnet"),
                          KNN = parsnip::nearest_neighbor(neighbors = hardhat::tune(), dist_power = hardhat::tune(), weight_func = hardhat::tune()) |>
                            parsnip::set_engine("kknn") |>
                            parsnip::set_mode("regression")
            )
          )
        ) |>
          workflowsets::workflow_map(
            seed = seed,
            resamples = rsample::vfold_cv(traindata, repeats = repetitions),
            grid = gridsize,
            control = tune::control_grid(
              save_pred = TRUE,
              parallel_over = "everything",
              save_workflow = TRUE
            )
          ) |>
          workflowsets::rank_results() |>
          as.data.frame() |>
          dplyr::mutate_if(is.numeric, round, digits = 2)
      )
    } else if (mode == FALSE) {
      return(
        dplyr::bind_rows(
          workflowsets::workflow_set(
            preproc = list(
              cate = recipes::recipe(stats::as.formula(paste(outcome, "~ .")), data = traindata) |>
                recipes::step_zv(recipes::all_nominal_predictors()) |>
                recipes::step_dummy(recipes::all_nominal_predictors(), -recipes::all_outcomes(), one_hot = TRUE) |>
                recipes::step_center(recipes::all_numeric_predictors(), -recipes::all_outcomes()) |>
                recipes::step_scale(recipes::all_numeric_predictors(), -recipes::all_outcomes())
            ),
            models = list(
              SVM_radial = parsnip::svm_rbf(cost = hardhat::tune(), rbf_sigma = hardhat::tune()) |>
                parsnip::set_engine("kernlab") |>
                parsnip::set_mode("classification"),
              SVM_poly = parsnip::svm_poly(cost = hardhat::tune(), degree = hardhat::tune()) |>
                parsnip::set_engine("kernlab") |>
                parsnip::set_mode("classification"),
              KNN = parsnip::nearest_neighbor(neighbors = hardhat::tune(), dist_power = hardhat::tune(), weight_func = hardhat::tune()) |>
                parsnip::set_engine("kknn") |>
                parsnip::set_mode("classification"),
              neural_network = parsnip::mlp(hidden_units = hardhat::tune(), penalty = hardhat::tune(), epochs = hardhat::tune()) |>
                parsnip::set_engine("nnet", MaxNWts = 2600) |>
                parsnip::set_mode("classification") 
            )
          ) 
        ) |>
          workflowsets::workflow_map(
            seed = seed,
            resamples = rsample::vfold_cv(traindata, repeats = repetitions),
            grid = gridsize,
            control = tune::control_grid(
              save_pred = TRUE,
              parallel_over = "everything",
              save_workflow = TRUE
            )
          ) |>
          workflowsets::rank_results() |>
          as.data.frame() |>
          dplyr::mutate_if(is.numeric, round, digits = 2)
      )
    } else {
      stop("Invalid mode. Please choose 'regression' (TRUE) or 'classification' (FALSE).")
    }
  } else if (type == TRUE) {
    if (mode == TRUE) {
      return(
        stacks::stacks() |>
          stacks::add_candidates(
            dplyr::bind_rows(
              workflowsets::workflow_set(
                preproc = list(simple = workflows::workflow_variables(outcomes = tidyselect::all_of(outcome), predictors = tidyselect::everything())),
                models = list(rf = parsnip::rand_forest(mtry = hardhat::tune(), min_n = hardhat::tune(), trees = hardhat::tune()) |> 
                                parsnip::set_engine("ranger") |> 
                                parsnip::set_mode("regression"),
                              CART_bagged = parsnip::bag_tree() |>
                                parsnip::set_engine("rpart", times = 50L) |>
                                parsnip::set_mode("regression"),
                              Cubist = parsnip::cubist_rules(committees = hardhat::tune(), neighbors = hardhat::tune()) |>
                                parsnip::set_engine("Cubist")
                )
              ),
              workflowsets::workflow_set(
                preproc = list(normalized = recipes::recipe(stats::as.formula(paste(outcome, "~ .")), data = traindata) |>
                                 recipes::step_log(tidyselect::all_of(viralvars), base = logbase) |>
                                 recipes::step_normalize(recipes::all_predictors())),
                models = list(SVM_radial = parsnip::svm_rbf(cost = hardhat::tune(), rbf_sigma = hardhat::tune()) |>
                                parsnip::set_engine("kernlab") |>
                                parsnip::set_mode("regression"),
                              SVM_poly = parsnip::svm_poly(cost = hardhat::tune(), degree = hardhat::tune()) |>
                                parsnip::set_engine("kernlab") |>
                                parsnip::set_mode("regression"),
                              KNN = parsnip::nearest_neighbor(neighbors = hardhat::tune(), dist_power = hardhat::tune(), weight_func = hardhat::tune()) |>
                                parsnip::set_engine("kknn") |>
                                parsnip::set_mode("regression"),
                              neural_network = parsnip::mlp(hidden_units = hardhat::tune(), penalty = hardhat::tune(), epochs = hardhat::tune()) |>
                                parsnip::set_engine("nnet", MaxNWts = 2600) |>
                                parsnip::set_mode("regression")
                )
              ) |>
                workflowsets::option_add(param_info = parsnip::mlp(hidden_units = hardhat::tune(), penalty = hardhat::tune(), epochs = hardhat::tune()) |>
                                           parsnip::set_engine("nnet", MaxNWts = 2600) |>
                                           parsnip::set_mode("regression") |>
                                           tune::extract_parameter_set_dials() |>
                                           recipes::update(hidden_units = dials::hidden_units(c(1, 27))),
                                         id = "normalized_neural_network"),
              workflowsets::workflow_set(
                preproc = list(full_quad = recipes::recipe(stats::as.formula(paste(outcome, "~ .")), data = traindata) |>
                                 recipes::step_log(tidyselect::all_of(viralvars), base = logbase) |>
                                 recipes::step_normalize(recipes::all_predictors())  |>
                                 recipes::step_poly(recipes::all_predictors()) |>
                                 recipes::step_interact(~ recipes::all_predictors():recipes::all_predictors())
                ),
                models = list(linear_reg = parsnip::linear_reg(penalty = hardhat::tune(), mixture = hardhat::tune()) |>
                                parsnip::set_engine("glmnet"),
                              KNN = parsnip::nearest_neighbor(neighbors = hardhat::tune(), dist_power = hardhat::tune(), weight_func = hardhat::tune()) |>
                                parsnip::set_engine("kknn") |>
                                parsnip::set_mode("regression")
                )
              )
            ) |>
              workflowsets::workflow_map(
                seed = seed,
                resamples = rsample::vfold_cv(traindata, repeats = repetitions),
                grid = gridsize,
                control = tune::control_grid(
                  save_pred = TRUE,
                  parallel_over = "everything",
                  save_workflow = TRUE
                )
              )
          ) |>
          stacks::blend_predictions(penalty = 10^seq(-2, -0.5, length = 20))
      )
    } else if (mode == FALSE) {
      return(
        stacks::stacks() |>
          stacks::add_candidates(
            dplyr::bind_rows(
              workflowsets::workflow_set(
                preproc = list(
                  cate = recipes::recipe(stats::as.formula(paste(outcome, "~ .")), data = traindata) |>
                    recipes::step_zv(recipes::all_nominal_predictors()) |>
                    recipes::step_dummy(recipes::all_nominal_predictors(), -recipes::all_outcomes(), one_hot = TRUE) |>
                    recipes::step_center(recipes::all_numeric_predictors(), -recipes::all_outcomes()) |>
                    recipes::step_scale(recipes::all_numeric_predictors(), -recipes::all_outcomes())
                ),
                models = list(
                  SVM_radial = parsnip::svm_rbf(cost = hardhat::tune(), rbf_sigma = hardhat::tune()) |>
                    parsnip::set_engine("kernlab") |>
                    parsnip::set_mode("classification"),
                  SVM_poly = parsnip::svm_poly(cost = hardhat::tune(), degree = hardhat::tune()) |>
                    parsnip::set_engine("kernlab") |>
                    parsnip::set_mode("classification"),
                  KNN = parsnip::nearest_neighbor(neighbors = hardhat::tune(), dist_power = hardhat::tune(), weight_func = hardhat::tune()) |>
                    parsnip::set_engine("kknn") |>
                    parsnip::set_mode("classification"),
                  neural_network = parsnip::mlp(hidden_units = hardhat::tune(), penalty = hardhat::tune(), epochs = hardhat::tune()) |>
                    parsnip::set_engine("nnet", MaxNWts = 2600) |>
                    parsnip::set_mode("classification") 
                )
              ) 
            ) |>
              workflowsets::workflow_map(
                seed = seed,
                resamples = rsample::vfold_cv(traindata, repeats = repetitions),
                grid = gridsize,
                control = tune::control_grid(
                  save_pred = TRUE,
                  parallel_over = "everything",
                  save_workflow = TRUE
                )
              ) 
          ) |>
          stacks::blend_predictions(penalty = 10^seq(-2, -0.5, length = 20))
      )
    } else {
      stop("Invalid mode. Please choose 'regression' (TRUE) or 'classification' (FALSE).")
    }
  } else {
    stop("Invalid type. Please choose 'ensemble' (TRUE) or 'individual' (FALSE).")
  }
}