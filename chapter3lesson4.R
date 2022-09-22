library(tidyverse)
library(xts)

maunaloa_missing <-
  read_rds("data/maunaloa_missing.Rds") %>%
  as.zoo() %>%
  `[`(200:1600)

autoplot(maunaloa_missing) +
  theme_light() +
  coord_cartesian(xlim = c(1980, 1990), ylim = c(330, 360)) +
  labs(
    x = "Index",
    y = "CO2 Concentration",
    title = "Missing Data Points"
  )

maunaloa_approx <- na.approx(maunaloa_missing)

autoplot(maunaloa_approx) +
  theme_light() +
  coord_cartesian(xlim = c(1980, 1990), ylim = c(330, 360)) +
  labs(
    x = "Index",
    y = "CO2 Concentration",
    title = "Approximated Data Points"
  )
i