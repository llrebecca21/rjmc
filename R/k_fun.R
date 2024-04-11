#' Determines a proposal for new k
#'
#' @param k :int
#' @param kmax :int
#'
#' @return an integer that is the proposal k
#'
#' @examples
#' ## will add soon
k_fun = function(k,kmax){
  # Determine if birth can occur
  can_birth = as.numeric(k < kmax)
  # Determine if death can occur
  can_death = as.numeric(k > 1)
  # probability of birth
  prob_birth = can_birth/(can_birth + can_death)
  # probability of death
  prob_death = 1 - prob_birth
  # choice for birth or death
  new_k = k + sample(c(1,-1),1, prob = c(prob_birth,prob_death))
  return(new_k)
}