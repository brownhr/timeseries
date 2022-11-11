library(tidyverse)
library(xts)
library(lubridate)
set.seed(4567)

scores <-
  c((round(100 * runif(
    n = 24, min = 0.75, max = .85
  ), 2) + seq(
    from = 0,
    to = 15,
    length.out = 24
  )),
  rep(NA, 12)
  )

index <- seq.Date(from = as_date('2005-01-01'), by = 'month', along.with = scores)

monthly_scores <- zoo(scores, index)

write_rds(monthly_scores, 'data/monthly_scores.rds')

autoplot(monthly_scores) + 
  theme_light() +
  labs(y = "Score",
       title = "Monthly Test Scores")

scores_locf <- na.locf(monthly_scores)

autoplot(scores_locf) + 
  theme_light() +
  labs(y = "Score",
       title = "Monthly Test Scores (LOCF)")
