#' Function that performs a birth step
#'
#' @param k : int
#' @param k_new : int
#' @param a vec
#' @param sig2 : number
#' @param x :vector
#' @param X : matrix
#' @param kmax :int
#' @param maxT :int
#'
#' @return a list with updated a and k values
#'
#' @examples
#' x = c(4.8407828, 3.1495432, 1.0391882, -0.5670270, -1.2837761, -0.4528256,
#'  -1.1621543, -1.8725529, -2.7431505, -3.6796526)
#' k = 3
#' k_new = 4 
#' kmax = 8       
#' sig2 = 1
#' a = c(0,0,0,0,0,0,0,0,0,0)
#' X = matrix(data = c(1.7612631, 2.402950, 1.037612, 2.258141, 0.7919269,
#'  -0.4510330, -0.1845782, -0.9725866, 0.1359826, 1.761263, 2.402950,
#'   1.037612, 2.2581412,  0.7919269, -0.4510330, -0.1845782),
#'    nrow = 2, ncol = 8,byrow = TRUE)
birth_fun = function(k,k_new,a,sig2,x, X, kmax, maxT){
  nu = stats::rnorm(1, mean = 0, sd = 0.3)
  a_prop = a
  a_prop[k_new] = nu
  L_birth = loglike_fun(kmax = kmax, k = k_new, sig2 = sig2, a = a_prop, x=x, X=X, maxT = maxT)
  L_death = loglike_fun(kmax = kmax, k = k, sig2 = sig2, a = a, x=x, X=X, maxT = maxT)
  # priors:
  p_birth = dnorm(a_prop[k_new], mean = 0, sd = 1, log = TRUE)
  # r
  r_birth = log(get_r_fun(k_int = k, k_prop = k_new, kmax = kmax))
  r_death = log(get_r_fun(k_int = k_new, k_prop = k, kmax = kmax))
  # get pnu: proposal density
  pnu = stats::dnorm(nu,mean = 0, sd = 0.3, log = TRUE)
  A = exp(L_birth + p_birth + r_death - (L_death + r_birth + pnu)) 
  U = stats::runif(1)
  if(U > A){
    # reject proposal
    return(list("a" = a, "k" = k))
  } else{
    # accept proposal
    return(list("a" = a_prop, "k" = k_new))
  }
  
}