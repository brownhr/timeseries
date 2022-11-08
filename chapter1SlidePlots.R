library(tidyverse)
library(zoo)

# AirPassengers plot
{autoplot(as.zoo(AirPassengers)) +
  theme_light() +
  labs(
    x = "Date",
    y = "Passengers (Thous.)",
    title = "Monthly International Airline Passengers"
  )} %>%
  ggsave(
    plot = .,
    filename = "fig/slides/chapter-1/AirPassengersDemoVector.svg",
    device = "svg",
    width = 450,
    height = 350,
    units = "px"
  )

# FTSE

ftse <- readr::read_rds("data/ftse.rds")

autoplot(ftse) + 
  theme_light() + 
  # coord_cartesian(xlim = c(1991, 2000)) +
  labs(
    x = "Date",
    y = "Price ($USD)",
    title = "Financial Times Stock Exchange Closing Prices"
  )


maunaloa <- readr::read_rds("data/maunaloa.Rds")

{autoplot(as.zoo(maunaloa)) + 
    # theme_light() + 
    labs(
      x = "Date",
      y = "CO2 Concentration (PPM)",
      title = "Mauna Loa Carbon Dioxide"
    )
  }
