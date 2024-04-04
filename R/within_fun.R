within_fun = function(k, x, X, sig2){
  # Gibbs Sampler
  V = solve(diag(k) + 1/sig2 * crossprod(X[,1:k,drop = FALSE]))
  M = V %*% crossprod(X[,1:k,drop = FALSE], x[(kmax+1):maxT] / sig2)
  # sample from multivariate normal distribution
  return(c(mvtnorm::rmvnorm(1, mean = M, sigma = V)))
}