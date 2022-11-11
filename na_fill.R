library(tidyverse)
library(xts)
set.seed(1234)


obs <- rpois(128, 2)
obs[obs == 0] <- NA_integer_

index <- seq.Date(from = as.Date("2017-01-01"), by = "day", along.with = obs)


observations <- zoo(obs, index)
autoplot(observations) + 
  theme_light() + 
  labs(y = "Daily observations",
       title = "Observations, Missing Data Points") + 
  coord_cartesian(ylim = c(0, 6))
vprint(head(observations))
table(observations, useNA = 'ifany')

observations_fill <- na.fill(observations,
                             fill = 0)
autoplot(observations_fill) + 
  theme_light() + 
  labs(y = "Daily observations",
       title = "Daily Observations, Filled") + 
  coord_cartesian(ylim = c(0, 6))
