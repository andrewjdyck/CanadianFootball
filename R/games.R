#' Returns games played by a CFL team in one season
#'
#' These functions return games played in the CFL at a high level
#' @param team Abbreviated team name
#' @param season The season of play
#' @return data.frame
#' @import jsonlite
#' @keywords canadian football, CFL, cflstats
#' @export
#' @examples \dontrun{
#' # Games played by Saskatchewan in 2014
#' get_team_season_games('SSK', 2014)
#' }

get_team_season_games <- function(team, season) {
  validTeams <- c('BC', "SSK", "CGY", "EDM", "WPG", "HAM", 'TOR', 'MTL', 'ORB')
  validSeasons <- 2009:2015
  if (is.element(team, validTeams)==FALSE) {
    stop('Incorrect team name')
  }
  if (is.element(season, validSeasons)==FALSE) {
    stop('Season data not available')
  }
  url <- paste('http://cflstats.ca/team', '/', team, '/', season, '.json', sep='')                                        
  url_return <- tryCatch({
    fromJSON(url)$Games
  }, error = function(err) {
    print(paste('CFLSTATS ERROR: ', err))
    return(NULL)
  })
  return(url_return)
}


#' Returns games played by a CFL team in one season
#'
#' @param team Abbreviated team name
#' @param season The season of play
#' @return data.frame
#' @import jsonlite
#' @keywords canadian football, CFL, cflstats
#' @export
#' @examples \dontrun{
#' # All games played in 2014
#' get_all_season_games(2014)
#' }

get_all_season_games <- function(season) {
  # Check that the seasons are valid
  validSeasons <- 2009:2015
  if (is.element(season, validSeasons)==FALSE) {
    stop('Invalid season')
  }
  validTeams <- c('BC', "SSK", "CGY", "EDM", "WPG", "HAM", 'TOR', 'MTL')
  validTeams <- if (season < 2014) {
    validTeams
  } else {
    c(validTeams, 'ORB')
  }
  output <- tryCatch({
    unique(
      do.call(
        'rbind', 
        lapply(
          validTeams, 
          function(x) get_team_season_games(x, season)
        )
      )
    )
  }, error = function(err) {
    print('CFLSTATS ERROR: ', err)
    return(NULL)
  })
  return(output[order(output$GameId),])
}
