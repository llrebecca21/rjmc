birth_fun = function(k,k_new,a,sig2,x, X, kmax){
  nu = rnorm(1, mean = 0, sd = 0.3)
  a_prop = a
  a_prop[k_new] = nu
  L_birth = loglike_fun(kmax = kmax, k = k_new, sig2 = sig2, a = a_prop, x=x, X=X)
  L_death = loglike_fun(kmax = kmax, k = k, sig2 = sig2, a = a, x=x, X=X)
  # priors:
  p_birth = dnorm(a_prop[k_new], mean = 0, sd = 1, log = TRUE)
  # r
  r_birth = log(get_r_fun(k_int = k, k_prop = k_new, kmax = kmax))
  r_death = log(get_r_fun(k_int = k_new, k_prop = k, kmax = kmax))
  # get pnu: proposal density
  pnu = dnorm(nu,mean = 0, sd = 0.3, log = TRUE)
  A = exp(L_birth + p_birth + r_death - (L_death + r_birth + pnu)) 
  U = runif(1)
  if(U > A){
    # reject proposal
    return(list("a" = a, "k" = k))
  } else{
    # accept proposal
    return(list("a" = a_prop, "k" = k_new))
  }
  
}