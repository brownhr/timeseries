library(testwhat)
solutionCode <- "# Save the start point of maunaloa: maunaloa_start
maunaloa_start <- start(maunaloa)

# Assign the formatted date to start_iso
start_iso <- date_decimal(maunaloa_start)

# Convert to Date class
as_date(start_iso)"