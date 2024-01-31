# cd_fit()` works as expected

    Code
      print(cd_fit(outcome, traindata, viralvars, logbase, seed, repetitions,
        gridsize, testdata, predicted))
    Message
      i Creating pre-processing data to finalize unknown parameter: mtry
    Output
      # A tibble: 2 x 3
        .metric .estimator .estimate
        <chr>   <chr>          <dbl>
      1 rmse    standard       0.191
      2 rsq     standard       0.965

