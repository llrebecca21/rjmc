#' Calculates the log-likelihood
#'
#' @param kmax :int
#' @param k :int
#' @param sig2 :num
#' @param a : vec
#' @param x :vec
#' @param X :matrix
#'
#' @return the log likelihood
#'
#' @examples
#' ## will add soon
loglike_fun = function(kmax,k,sig2,a,x,X){
  maxT = length(x)
  # calculate mean vector:
  m = X[,1:k,drop = FALSE]%*%a[1:k]
  L = stats::dnorm(x[(kmax+1):maxT], mean = m, sd = sqrt(sig2), log = TRUE)
  return(sum(L))
  
}