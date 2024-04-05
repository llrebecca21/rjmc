#' Function creates lagged x matrix
#'
#' @param x : time series: column vector (Tmax x 1)
#' @param maxT : integer value > 0: length of time series x
#' @param kmax : integer value > 1: max value of k in an AR(k) can potentially move to 
#'
#' @return matrix of lagged x time series
#'
#' @examples
#' x = c(4.8407828, 3.1495432, 1.0391882, -0.5670270, -1.2837761, -0.4528256,
#'  -1.1621543, -1.8725529, -2.7431505, -3.6796526)        
#' maxT = 10        
#' kmax = 30         
#'         
#'         
X_matrix_creation = function(x, maxT, kmax){
  # Create matrix to store lagged x's
  X = matrix(data = NA, nrow = maxT - kmax, ncol = kmax)
  for(p in 1:nrow(X)){
    X[p,] = x[(p + kmax - 1):p]
  }
  return(X)
}