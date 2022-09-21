library(tidyverse)
library(zoo)
library(lubridate)

ftse <- read_rds("data/ftse.Rds") %>% as.zoo()


ftse_length <- length(ftse)
ftse_first_half <- head(ftse, ftse_length / 2)
ftse_second_half <- tail(ftse, (ftse_length / 2) + 6)



first_index <- index(ftse_first_half)
second_index <- index(ftse_second_half)

ftse_cut <- ftse_first_half[!(first_index %in% second_index)]

ftse_combined <- c(ftse_cut, ftse_second_half)
