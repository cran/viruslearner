#' Fit and Evaluate Stacked Ensemble Model for CD4 Cell Count or Viral Load Outcome
#'
#' This function builds a stacked ensemble model using various preprocessing and modeling workflows.
#'
#' @param outcome The name of the outcome variable.
#' @param traindata The training dataset used for building the ensemble.
#' @param viralvars A vector of variable names representing viral variables.
#' @param logbase The base for the logarithmic transformation in preprocessing.
#' @param seed Seed for reproducibility.
#' @param repetitions Number of repetitions for cross-validation.
#' @param gridsize Number of grid points for hyperparameter tuning.
#' @param testdata The test dataset for evaluating the ensemble.
#' @param predicted Column name of the predicted variable in a regression tidy format.
#'
#' @return A tibble containing the root mean squared error (RMSE) and coefficient of determination (R2) metrics.
#'
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
#' data("cd_test", package = "viruslearner")
#' outcome <- "cd_2023"
#' traindata <- cd_train
#' viralvars <- c("vl_2019", "vl_2021", "vl_2022", "vl_2023")
#' logbase <- 10
#' seed <- 1501
#' repetitions <- 2
#' gridsize <- 1
#' testdata <- cd_test
#' predicted <- ".pred"
#' cd_fit(outcome, traindata, viralvars, logbase, seed, repetitions, gridsize, testdata, predicted)
#' }
cd_fit <- function(outcome, traindata, viralvars, logbase, seed, repetitions, gridsize, testdata, predicted) {
  set.seed(seed)
  stacks::stacks() |>
    stacks::add_candidates(
      dplyr::bind_rows(
        workflowsets::workflow_set(
          preproc = list(simple = workflows::workflow_variables(outcomes = tidyselect::all_of(outcome), predictors = tidyselect::everything())),
          models = list(rf_spec <- parsnip::rand_forest(mtry = hardhat::tune(), min_n = hardhat::tune(), trees = hardhat::tune()) |> 
                          parsnip::set_engine("ranger") |> 
                          parsnip::set_mode("regression"),
                        CART_bagged_cd = parsnip::bag_tree() |>
                          parsnip::set_engine("rpart", times = 50L) |>
                          parsnip::set_mode("regression"),
                        Cubist_cd = parsnip::cubist_rules(committees = hardhat::tune(), neighbors = hardhat::tune()) |>
                          parsnip::set_engine("Cubist")
          )
        ),
        workflowsets::workflow_set(
          preproc = list(normalized = recipes::recipe(stats::as.formula(paste(outcome, "~ .")), data = traindata) |>
                           recipes::step_log(tidyselect::all_of(viralvars), base = logbase) |>
                           recipes::step_normalize(recipes::all_predictors())),
          models = list(SVM_radial_cd = parsnip::svm_rbf(cost = hardhat::tune(), rbf_sigma = hardhat::tune()) |>
                          parsnip::set_engine("kernlab") |>
                          parsnip::set_mode("regression"),
                        SVM_poly_cd = parsnip::svm_poly(cost = hardhat::tune(), degree = hardhat::tune()) |>
                          parsnip::set_engine("kernlab") |>
                          parsnip::set_mode("regression"),
                        KNN_cd = parsnip::nearest_neighbor(neighbors = hardhat::tune(), dist_power = hardhat::tune(), weight_func = hardhat::tune()) |>
                          parsnip::set_engine("kknn") |>
                          parsnip::set_mode("regression"),
                        neural_network_cd = parsnip::mlp(hidden_units = hardhat::tune(), penalty = hardhat::tune(), epochs = hardhat::tune()) |>
                          parsnip::set_engine("nnet", MaxNWts = 2600) |>
                          parsnip::set_mode("regression")
          )
        ) |>
          workflowsets::option_add(param_info = parsnip::mlp(hidden_units = hardhat::tune(), penalty = hardhat::tune(), epochs = hardhat::tune()) |>
                                     parsnip::set_engine("nnet", MaxNWts = 2600) |>
                                     parsnip::set_mode("regression") |>
                                     tune::extract_parameter_set_dials() |>
                                     recipes::update(hidden_units = dials::hidden_units(c(1, 27))),
                                   id = "normalized_neural_network_cd"),
        workflowsets::workflow_set(
          preproc = list(full_quad = recipes::recipe(stats::as.formula(paste(outcome, "~ .")), data = traindata) |>
                           recipes::step_log(tidyselect::all_of(viralvars), base = logbase) |>
                           recipes::step_normalize(recipes::all_predictors())  |>
                           recipes::step_poly(recipes::all_predictors()) |>
                           recipes::step_interact(~ recipes::all_predictors():recipes::all_predictors())
          ),
          models = list(linear_reg_cd = parsnip::linear_reg(penalty = hardhat::tune(), mixture = hardhat::tune()) |>
                          parsnip::set_engine("glmnet"),
                        KNN_cd = parsnip::nearest_neighbor(neighbors = hardhat::tune(), dist_power = hardhat::tune(), weight_func = hardhat::tune()) |>
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
    stacks::blend_predictions(penalty = 10^seq(-2, -0.5, length = 20)) |>
    stacks::fit_members() |>
    stacks::predict.model_stack(testdata) |>
    dplyr::bind_cols(testdata) |>
    yardstick::metric_set(yardstick::rmse, yardstick::rsq)(tidyselect::all_of(outcome), tidyselect::all_of(predicted))
}