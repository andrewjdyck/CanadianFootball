#' Team Pythagorean Expectation
#'
#' Calculates pythagorean expectation for one team over one season
#' @param data A dataset output from the get_all_season_games() function
#' @param team A team name abbreviation
#' @return data.frame
#' @keywords canadian football, CFL, cflstats
#' @export

single_team_py_exp <- function(data, team) {
  temp <- data[data$HomeTeam == team | data$AwayTeam == team,]
  temp$Team <- team
  temp[, c('PointsFor', 'PointsAgainst')] <- temp[, c('HomeScore', 'HomeScore')]
  temp$PointsFor[temp$AwayTeam==team] <- temp[temp$AwayTeam==team, 'AwayScore']
  temp$PointsAgainst[temp$HomeTeam==team] <- temp[temp$HomeTeam==team, 'AwayScore']
  temp <- temp[, c('GameId', 'WeekNumber', 'Team', 'PointsFor', 'PointsAgainst')]
  temp$CumPointsFor <- cumsum(temp$PointsFor)
  temp$CumPointsAgainst <- cumsum(temp$PointsAgainst)
  temp$PyExp <- pythagorean_expectation(temp$CumPointsFor, temp$CumPointsAgainst)
  return(temp)
}




