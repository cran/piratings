## ---- include = FALSE----------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  fig.path = "man/figures/README-",
  out.width = "100%",
  error = TRUE
)

## ----setup, include = FALSE----------------------------------------------
library(piratings)
library(ggplot2)
knitr::opts_chunk$set(echo = T,
                      results = "hide")

## ----echo = T, results = "markup"----------------------------------------

## example data from the European Soccer Dataset
## for the English Premier League during the seasons
## 2008/2009 to 2015/2016

data("EPL2008_2015")
head(EPL2008_2015)

## ----echo = T, results = "hide", message = F-----------------------------
## prepare the function arguments:
teams <- as.matrix(EPL2008_2015[, c("home_team", "away_team")])
outcomes <- as.matrix(EPL2008_2015[, c("home_goals", "away_goals")])

grid <- optimize_pi_ratings(teams, outcomes, seq(0.04, 0.08, 0.005), seq(0.3, 0.7, 0.05))

## ----echo = T, results = "markup", warning = F---------------------------
## we plot this grid using the ggplot2 library
library(ggplot2)

ggplot(data = grid, aes(x = lambda, y = gamma, fill = mean.squared.error)) + 
  geom_tile() + scale_fill_gradient2(low = "blue", mid = "white", high = "red", midpoint = 2.668) + 
  labs(x = "lambda", y = "gamma", title = "grid optimization", fill = "Mean \nsquared \nerror") + 
  theme(plot.title = element_text(hjust = 0.5))

## we find the optimal parameter settings to be
## lambda = 0.06 and gamma = 0.6

piratings <- calculate_pi_ratings(teams, outcomes, 0.06, 0.6)
tail(piratings)

