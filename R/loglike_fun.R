loglike_fun = function(kmax,k,sig2,a,x,X){
  # calculate mean vector:
  m = X[,1:k,drop = FALSE]%*%a[1:k]
  L = dnorm(x[(kmax+1):maxT], mean = m, sd = sqrt(sig2), log = TRUE)
  return(sum(L))
  
}