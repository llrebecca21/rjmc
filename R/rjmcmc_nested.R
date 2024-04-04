rjmcmc_nested = function(iter, k, sig2, x, kmax, alpha_p = 2, beta_p = 1){
  # Get the length of the time series x, which is maxT
  maxT = length(x)
  # Create the X matrix 
  # (lagged x matrix for likelihood calculation in acceptance ratios)
  X = X_matrix_creation(x = x, maxT = maxT, kmax = kmax)
  # initialize a (stores ar coefficients)
  a = rep(0, kmax)
  # initialize storage for rj_mat, that will store at each iteration the updated
  # parameters a, sig2, and k
  rj_mat = matrix(NA, nrow = iter, ncol = length(a)+2)
  # Initialize first row of rj_mat
  rj_mat[1,] = c(a,sig2,k)
  for(i in 2:iter){
    # birth or death move
    k_new = k_fun(k=k,kmax=kmax)
    if(k_new > k){# if k_new > k perform birth move
      # run birth move
      output = birth_fun(k = k, k_new = k_new, a = a, sig2 = sig2, x = x, X = X, kmax = kmax)
      a = output$a
      k = output$k
    }else{ # if k_new < k perform death move
      # run death move
      output = death_fun(k = k, k_new = k_new, a = a, sig2 = sig2, x = x, X = X, kmax = kmax)
      a = output$a
      k = output$k
    }
    # perform within model move
    a[1:k] = within_fun(k = k, x = x, X = X, sig2 = sig2)
    # update ith row of rj_mat
    rj_mat[i,] = c(a,sig2,k)
  }
  return(rj_mat)
}
