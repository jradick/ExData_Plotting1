#
# Coursera Course
# Exploratory Data Analysis
# Course exdata-013 (April 2015)
# Data Science Specialization
#
# Jeffrey Radick, student
#
# Course Project 1
# Due April 12, 2015
#
# plot1.R
# R program to reproduce the first plot:
# a histogram of the values in the Global_active_power column
# on dates of interest (2007-02-01 and 2007-02-02).
#
# Details:
# - read the file (must be previously downloaded and unzipped)
#   https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
#   (file must be unzipped to produce input file "household_power_consumption.txt")
# - convert the "Date" column for ease of subsetting
# - extract the data from the desired dates
# - convert the Global_active_power column to numeric
# - create the histogram plot with a nice title and x-axis label
# - save the plot in a PNG file with 480x480 pixel resolution
#   (480x480 is default but specified explicitly for clarity's sake)
#
# Notes:
# - It would probably be good to include the file download an unzip as well.
# - As indicated in the instructions for the assignment, there's probably
#   a way to read just the desired subset from the file rather than
#   reading the whole file, but I didn't figure out how to do that,
#   and the whole file fits in my computer's memory anyway.
#

plot1 <- function() {
      f <- "household_power_consumption.txt"
      df <- read.table(f, sep = ";", header = TRUE, stringsAsFactors = FALSE)
      df[, "Date"] <- as.Date(df[, "Date"], format="%d/%m/%Y")
      df.subset <- df[df$Date == "2007-02-01" | df$Date == "2007-02-02", ]
      df.subset[, "Global_active_power"] <-
      		as.numeric(df.subset[, "Global_active_power"])
      png(file = "plot1.png", width = 480, height = 480)
      with(df.subset,
	hist(Global_active_power,
		main="Global Active Power",
		xlab="Global Active Power (kilowatts)",
		col=2))
      dev.off()
}
