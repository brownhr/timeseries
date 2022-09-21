set.seed(1234)

sample_dates <-
  seq(as_date("2022-01-20"), by = "day", length.out = 2000)
sample_values <- 
  (cos(1:2000 * (1/24)) * 4) + 
  (runif(1:2000, min = -1, max = 1)) + 
  (sqrt(1:2000))

sample_values <- round(sample_values, digits = 3)


my_zoo <- zoo(x = sample_values, order.by = sample_dates)

z_mean <- rollmean(my_zoo, k = 4, align = "center")

zoo_mean <- c(head(my_zoo, 1),
              z_mean,
              tail(my_zoo, 2))

coredata(zoo_mean) <- round(coredata(zoo_mean), 3)

head(index(zoo_mean))

head(coredata(zoo_mean))


sample_dates <- index(zoo_mean)
sample_values <- coredata(zoo_mean)


# new_index <- sort(index(my_zoo) %m-% years(12) %m+% months(3) %m+% days(12))
# index(my_zoo) <- new_index

coredata(my_zoo)[1] <- 30

head(my_zoo)