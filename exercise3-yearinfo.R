library(tidyverse)
library(zoo)
library(lubridate)

m_sales <- read_rds("data/monthly_sales.Rds")
monthly_data <- coredata(m_sales)
date_index_month <- seq.Date(from = as_date('1990-01-01'),
                             to = as_date('1999-12-01'),
                             by = 'month')
date_index_quarter <-
  date_index_month[seq(1, length(date_index_month), 3)]


month_index <- month(date_index_month)

# autoplot(zoo(monthly_data, month_index))

yearmon_index <- as.yearmon(date_index_month)

yearmon_zoo <- zoo(monthly_data, order.by = yearmon_index)

