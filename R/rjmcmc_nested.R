#' A Reversible Jump Markov Chain Monte Carlo (RJMCMC) for Nested AR Processes
#' 
#' @description 
#' `rjmcmc()` performs a nested RJMCMC algorithm on a given time series.
#' 
#' 
#' @param iter A numeric value for the number of iterations for a single simulation.
#' @param k An integer for the initial value for the k parameter.
#' @param sig2 The numeric initial value for the `sig2` parameter.
#' @param x A vector `(Tmax` \eqn{\times} `1)` of data from the time series.
#' @param kmax An integer value > 1: max value of k can potentially move to. 
#' @param alpha_p The float shape parameter for inverse gamma prior on `sig2`.
#' @param beta_p The float scale parameter for inverse gamma prior on `sig2`.
#' 
#' @references 
#' \insertRef{brooks_efficient_2003}{rjmc}
#' 
#' \insertRef{green_reversible_1995}{rjmc}
#' 
#' \insertRef{robert_monte_2004}{rjmc}
#' 
#' @return A matrix with parameters `a`, `k`, and `sig2`.
#' @export
#'
#' @examples
#' ## will add soon
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
    # update sig2 with a Gibbs step
    sig2 = 1/rgamma(n = 1, shape = 0.5* (maxT - kmax) + alpha_p, rate = beta_p + 0.5 * crossprod(x[(kmax+1):maxT] - X[,1:k,drop = FALSE]%*%a[1:k]))
    
    # perform within model move
    a[1:k] = within_fun(k = k, x = x, X = X, sig2 = sig2, kmax = kmax)
    # Update sig2 again
    sig2 = 1/rgamma(n = 1, shape = 0.5* (maxT - kmax) + alpha_p, rate = beta_p + 0.5 * crossprod(x[(kmax+1):maxT] - X[,1:k,drop = FALSE]%*%a[1:k]))
    
    # update ith row of rj_mat
    rj_mat[i,] = c(a,sig2,k)
  }
  
  # Create Labels for the data frame output of the function
  label_ex = rep(NA,kmax+2)
  for(i in 1:(kmax+2)){
    if(i %in% 1:kmax){
      label_ex[i] = paste("\U03D5(",i,")", sep = "")
    }else if(i == (kmax + 1)){
      label_ex[i] = paste("sig2", sep = "")
    }else{
      label_ex[i] = paste("k", sep = "")
    }
  }
  
  # Save the rj_mat as a data frame for ease of plotting
  # rj_mat = as.data.frame(rj_mat)
  # set column names to the new labels above
  colnames(rj_mat) = label_ex
  return(rj_mat)
}

