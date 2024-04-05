#' Function that performs a death step
#'
#' @param k :int
#' @param k_new :int
#' @param a : vec
#' @param sig2 :num
#' @param x :vec
#' @param X :matrix
#' @param kmax :int
#'
#' @return list with updated a and k values
#'
#' @examples
#' ## Will add soon
death_fun = function(k,k_new,a,sig2,x, X, kmax){
  a_prop = a
  L_birth = loglike_fun(kmax = kmax, k = k, sig2 = sig2, a = a, x=x, X=X)
  L_death = loglike_fun(kmax = kmax, k = k_new, sig2 = sig2, a = a_prop, x=x, X=X)
  # priors:
  p_birth = stats::dnorm(a[k], mean = 0, sd = 1, log = TRUE)
  # r
  r_death = log(get_r_fun(k_int = k, k_prop = k_new, kmax = kmax))
  r_birth = log(get_r_fun(k_int = k_new, k_prop = k, kmax = kmax))
  # get pnu: proposal density
  pnu = stats::dnorm(a[k],mean = 0, sd = 0.3, log = TRUE)
  A = exp(L_death + r_birth + pnu - (L_birth + r_death + p_birth)) 
  U = stats::runif(1)
  if(U > A){
    # reject proposal
    return(list("a" = a, "k" = k))
  } else{
    # accept proposal
    return(list("a" = a_prop, "k" = k_new))
  }
  
}