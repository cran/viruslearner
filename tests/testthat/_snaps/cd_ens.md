# `cd_ens()` works as expected

    Code
      print(cd_ens(outcome, traindata, viralvars, logbase, seed, repetitions,
        gridsize, mode = TRUE, type = TRUE))
    Message
      i Creating pre-processing data to finalize unknown parameter: mtry
      -- A stacked ensemble model -------------------------------------
      
      Out of 9 possible candidate members, the ensemble retained 3.
      Penalty: 0.0356969884682606.
      Mixture: 1.
      
      The 3 highest weighted members are:
    Output
      # A tibble: 3 x 3
        member                        type         weight
        <chr>                         <chr>         <dbl>
      1 simple_Cubist_1_1             cubist_rules 0.727 
      2 simple_CART_bagged_1_1        bag_tree     0.233 
      3 normalized_neural_network_1_1 mlp          0.0307
    Message
      
      Members have not yet been fitted with `fit_members()`.

