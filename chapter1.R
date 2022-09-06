library(tidyverse)
library(lubridate)
library(zoo)


airpass <- read_rds("data/airpassengers.Rds") %>% as.zoo()

ftse <- EuStockMarkets[,"FTSE"] %>% as.zoo()

maunaloa <- read_rds("data/maunaloa.Rds") %>% as.zoo()


# Figure width for 3-column layout = 450 x 348


# Airpassengers
ggplot(airpass, aes(x = Index, y = airpass)) + 
  geom_line() + 
  theme_light() +
  labs(
    x = "Date",
    y = "Passengers (Thous.)",
    title = "Monthly International Passengers, Thousands"
  )

# FTSE
ggplot(ftse, aes(x = Index, y = ftse)) + 
  geom_line() + 
  theme_light() +
  coord_cartesian(xlim = c(1992, 1998)) +
  labs(
    x = "Date",
    y = "Price",
    title = "Financial Times Stock Exchange Closing Prices"
  )

# Mauna Loa
ggplot(maunaloa, aes(x = Index, y = maunaloa)) + 
  geom_line() + 
  # theme_light() +
  labs(
    x = "Date",
    y = "Concentration (ppm)",
    title = "Mauna Loa CO2 Concentration"
  )

autoplot(maunaloa) +
  labs(x = "Date",
       y = "Concentration (ppm)",
       title = "Mauna Loa CO2 Concentration") + 
  theme_light()

