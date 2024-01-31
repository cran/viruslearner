test_that("`cd_stack()` plots as expected", {
  local_edition(3)
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
  library(vdiffr)
  library(workflows)
  library(workflowsets)
  data("cd_train", package = "viruslearner")
  outcome <- "cd_2023"
  traindata <- cd_train
  viralvars <- c("vl_2019", "vl_2021", "vl_2022", "vl_2023")
  logbase <- 10
  seed <- 1501
  repetitions <- 2
  gridsize <- 1
  expect_doppelganger(
    title = "cd stack",
    fig = cd_stack(outcome, traindata, viralvars, logbase, seed, repetitions, gridsize),
  )
}
)