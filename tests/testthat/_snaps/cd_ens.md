# `cd_ens()` works as expected

    Code
      print(cd_ens(outcome, traindata, viralvars, logbase, seed, repetitions,
        gridsize))
    Message
      i Creating pre-processing data to finalize unknown parameter: mtry
      -- A stacked ensemble model -------------------------------------
      
      Out of 9 possible candidate members, the ensemble retained 2.
      Penalty: 0.0738619982207936.
      Mixture: 1.
      
      The 2 highest weighted members are:
    Output
      # A tibble: 2 x 3
        member                    type         weight
        <chr>                     <chr>         <dbl>
      1 simple_Cubist_cd_1_1      cubist_rules 0.844 
      2 simple_CART_bagged_cd_1_1 bag_tree     0.0908
    Message
      
      Members have not yet been fitted with `fit_members()`.

