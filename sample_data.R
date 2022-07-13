library(tidyverse)
library(zoo)
library(lubridate)
library(anytime)
library(forecast)
library(astsa)
library(tseries)

# files <- list.files(path = "data", full.names = TRUE)
# 
# data <- map(
#   files, read_csv, show_col_types = FALSE
# )
#   
# data <- data %>% 
#   map_dfr(bind_rows)
# 
# library(furrr)
# plan(multisession)
# 
# dates <- data$`Order Date` %>% 
#   anytime()
# 
# data$date <- dates
# write_rds(data, "data/sample_data.Rds")


data <- read_rds("data/sample_data.Rds")

sales_data <- data %>% 
  filter(
    Product != "Product"
  ) %>% 
  mutate(
    # date = parse_date_time(`Order Date`, orders = c("mdy HM", "mdY HM")),
    Product = as.factor(Product),
    TotSale = as.numeric(`Quantity Ordered`) * as.numeric(`Price Each`),
    # day = zoo::as.Date(date)
  ) %>% 
  select(
    `Order Date`, TotSale
  )
  
