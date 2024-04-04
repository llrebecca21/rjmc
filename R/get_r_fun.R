#' Function that calculates the r_(i,j) probability in the acceptance ratio
#'
#' @param k_int : integer in [0,kmax], current k value
#' @param k_prop : integer in [0,kmax], either k_int - 1 or k_int + 1, proposed k value
#' @param kmax : integer greater than 0, max ar(k) process that can be checked
#'
#' @return
#' @export
#'
#' @examples
get_r_fun = function(k_int,k_prop,kmax){
  # returns the probability birth or death
  can_birth = as.numeric(k_int < kmax)
  can_death = as.numeric(k_int > 0)
  # probability of birth
  prob_birth = can_birth/(can_birth + can_death)
  prob_death = 1 - prob_birth
  
  if(k_prop > k_int){
    return(prob_birth)
  } else{
    return(prob_death)
  }
}