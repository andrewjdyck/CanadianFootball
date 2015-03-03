# Canadian Football R Package #

This package is designed as a programming interface to the CFLStats.ca API. The following methods are available:

- get_team_season_games(team, season):
  - Retrieves games played by a given team in a given season
- get_all_season_games(season):
  - Retrieves all games played in a given season
  
## Installation ##
```r
library(devtools)
install_github('andrewjdyck/CanadianFootball)
```

## Usage ##
```r
# Get all games played by Calgary in the 2014 season
CGY_2014 <- get_team_season_games('CGY', 2014)
head(CGY_2014)
  GameId Year WeekNumber HomeTeam AwayTeam           StartTime HomeScore AwayScore    Type
1 2014011 2014          1      CGY      MTL 2014-06-28T15:00:00        29         8 Regular
2 2014020 2014          3      TOR      CGY 2014-07-12T18:30:00        15        34 Regular
3 2014024 2014          4      CGY      HAM 2014-07-18T22:00:00        10         7 Regular
4 2014026 2014          5      EDM      CGY 2014-07-24T21:00:00        22        26 Regular
5 2014032 2014          6      CGY       BC 2014-08-01T22:00:00        24        25 Regular
6 2014037 2014          7      CGY      ORB 2014-08-09T19:30:00        38        17 Regular
```


```r
# Get all games played in the 2014 season
games2014 <- get_all_season_games(2014)

# Calculate the Pythagorean Expectation for 2014 by team
season_py_exp <- do.call(
  'rbind', 
  lapply(
    unique(games2014$HomeTeam), 
    function(x) single_team_py_exp(games2014[games2014$Type=='Regular',], x)
  )
)
```

```r
# Plot the Pythagorean Expectation throughout the 2014 season
library(ggplot2)
ggplot(season_py_exp, aes(WeekNumber, PyExp, colour=Team)) +
  geom_line() +
  geom_point()
```

![Pythagorean Expectation 2014](https://raw.githubusercontent.com/andrewjdyck/CanadianFootball/master/PyExp2014.png)

