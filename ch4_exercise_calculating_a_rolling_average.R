library(tidyverse)
library(lubridate)
library(xts)

files =  list('data/temperature/2021/CRNH0203-2021-AK_Denali_27_N.csv',
              'data/temperature/2021/CRNH0203-2021-AR_Batesville_8_WNW.csv',
              'data/temperature/2021/CRNH0203-2021-AZ_Tucson_11_W.csv')

parse_noaa <- function(file, temp_name){
  df = read_csv(file) %>% 
    select(
      WBANNO,
      UTC_DATE,
      UTC_TIME,
      T_HR_AVG
    ) %>% 
    mutate(
      UTC_TIME = str_pad(as.character(UTC_TIME), 4, pad = '0'),
      Index = parse_date_time(paste0(UTC_DATE, UTC_TIME), orders=c('%Y%m%d%H%M')),
      T_HR_AVG = ifelse(T_HR_AVG < -1000, NA, T_HR_AVG)
    )
  df[temp_name] = df$T_HR_AVG
  return(head(df[,c('Index', temp_name)], -1))
}

names = c('Alaska', 'Arkansas', 'Arizona')

df_multi = map2(files, names, parse_noaa)

df_m <- reduce(df_multi, full_join,by = 'Index')
m = as.matrix(subset(df_m, select = -c(Index)))
z = zoo(m, order.by=df_m$Index) %>% na.spline()
autoplot(z)
write_rds(z, 'data/us_temperatures.rds')
us_temperatures <- read_rds("https://assets.datacamp.com/production/repositories/6083/datasets/1966dc1c1d851cafe350fc02a5deb2856a1ad6e8/us_temperatures.rds")
