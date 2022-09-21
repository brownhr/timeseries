library(tidyverse)
library(zoo)
library(lubridate)

m_sales <- read_rds("data/monthly_sales.Rds")
monthly_data <- coredata(m_sales)
date_index <- seq.Date(from = as_date('1990-01-01'), to = as_date('1999-12-01'), by = 'month')

month_index <- month(date_index)

autoplot(zoo(monthly_data, month_index))
