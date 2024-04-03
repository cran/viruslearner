test_that("`cd_fit()` works as expected", {
  library(baguette)
  library(dials)
  library(dplyr)
  library(hardhat)
  library(kernlab)
  library(kknn)
  library(parsnip)
  library(ranger)
  library(recipes)
  library(rsample)
  library(rules)
  library(stacks)
  library(stats)
  library(tidyselect)
  library(tune)
  library(workflows)
  library(workflowsets)
  library(yardstick)
  data("cd_train", package = "viruslearner")
  data("cd_test", package = "viruslearner")
  outcome <- "cd_2023"
  traindata <- cd_train
  viralvars <- c("vl_2019", "vl_2021", "vl_2022", "vl_2023")
  logbase <- 10
  seed <- 1501
  repetitions <- 2
  gridsize <- 1
  testdata <- cd_test
  predicted <- ".pred"
  expect_snapshot(
    print(
      cd_fit(outcome, traindata, viralvars, logbase, seed, repetitions, gridsize, testdata, predicted)
    )
  )
})
