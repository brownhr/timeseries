library(XML)
library(RCurl)
dataftp <- "ftp://ftp.ncei.noaa.gov/pub/data/uscrn/products/hourly02"

con <- getURL(dataftp, verbose = TRUE, ftp.use.epsv=TRUE, dirlistonly=TRUE)

getHTMLLinks(con)
