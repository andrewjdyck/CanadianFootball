#' Pythagorean Expectation in the Canadian Football League
#'
#' Returns the Pythagorean Expectation for a team
#' @param PointsFor Points scored by a given team
#' @param PointsAgainst Points scored against a given team
#' @return numeric
#' @keywords canadian football, CFL, cflstats
#' @export

cfl_py_exp <- function(PointsFor, PointsAgainst, exponent=2.37) {
  py_exp <- PointsFor^exponent/(PointsFor^exponent + PointsAgainst^exponent)
  return(py_exp)
}

#' Pythagorean Expectation exponent
#'
#' calculates the exponent parameter to be used in Pythagorean Expectation
#' @param sd_PtsFor Standard Deviation of the points scored by all teams
#' @param mean_PtsFor Mean of the points scored by all teams
#' @return numeric
#' @keywords canadian football, CFL, cflstats
#' @export
 
pythagorean_exponent <- function(sd_PtsFor, mean_PtsFor) {
  sigma <- sd_PtsFor/mean_PtsFor
  exponent <- 2/(sqrt(pi)*sigma)
  return(exponent)
}
