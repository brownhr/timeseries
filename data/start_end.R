library(tidyverse)
library(zoo)
library(lubridate)

ftse <- read_rds("data/ftse.Rds") %>% as.zoo()


ftse_length <- length(ftse)
ftse_first_half <- head(ftse, ftse_length / 2)
ftse_second_half <- tail(ftse, (ftse_length / 2) + 1)


ftse_first_half[which(time(ftse_first_half) %in% time(ftse_second_half))]


