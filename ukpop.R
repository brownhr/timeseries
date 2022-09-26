library(readr)
library(ggplot2)
library(dplyr)
library(zoo)
library(lubridate)

ukpop <- read_csv("data/series-260922.csv")

ukpop <- zoo(ukpop$Population,
             ukpop$year,
             frequency = 1)
ukpop %>% write_rds("data/ukpop.rds")
