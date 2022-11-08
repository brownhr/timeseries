library(tidyverse)
library(zoo)
library(lubridate)
maunaloa <- read_rds("data/maunaloa.rds")

prices <- window(maunaloa, start = 1989, end = 1990)

prices
