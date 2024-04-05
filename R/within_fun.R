#' function to perform a within model move
#'
#' @param k : int
#' @param x :vec
#' @param X : matrix
#' @param sig2 : num
#' @param kmax :int
#'
#' @return updated ar coefficients a
#'
#' @examples
#' ## will add soon
within_fun = function(k, x, X, sig2, kmax){
  maxT = length(x)
  # Gibbs Sampler
  V = solve(diag(k) + 1/sig2 * crossprod(X[,1:k,drop = FALSE]))
  M = V %*% crossprod(X[,1:k,drop = FALSE], x[(kmax+1):maxT] / sig2)
  # sample from multivariate normal distribution
  return(c(mvtnorm::rmvnorm(1, mean = M, sigma = V)))
}