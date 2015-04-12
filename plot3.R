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
# plot3.R
# R program to reproduce the third plot:
# Overlayed line plots of 3 values in different colors:
# - Sub_metering_1 (black)
# - Sub_metering_2 (red)
# - Sub_metering_3 (blue)
# Also including a legend.
#
# Details:
# - read the file (must be previously downloaded and unzipped)
#   https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
#   (file must be unzipped to produce input file "household_power_consumption.txt")
# - convert the "Date" column for ease of subsetting
# - extract the data from the desired dates
# - convert the Date & Time column to internal form for plotting
# - convert the Sub_metering_<n> columns to numeric
# - create the plot with a nice title and x-axis label
#   The style of plot here is type="l" so points are connected by lines.
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

plot3 <- function() {
      f <- "household_power_consumption.txt"
      df <- read.table(f, sep = ";", header = TRUE, stringsAsFactors = FALSE)
      df[, "Date"] <- as.Date(df[, "Date"], format="%d/%m/%Y")
      df.subset <- df[df$Date == "2007-02-01" | df$Date == "2007-02-02", ]
      df.subset[, "Sub_metering_1"] <-
      		as.numeric(df.subset[, "Sub_metering_1"])
      df.subset[, "Sub_metering_2"] <-
      		as.numeric(df.subset[, "Sub_metering_2"])
      df.subset[, "Sub_metering_3"] <-
      		as.numeric(df.subset[, "Sub_metering_3"])
      dtstr <- paste(df.subset$Date, df.subset$Time)
      dt <- strptime(dtstr, format= "%Y-%m-%d %H:%M:%S")
      png(file = "plot3.png", width = 480, height = 480)
      plot(dt, df.subset$Sub_metering_1, type="l",
      		xlab="", ylab="Energy sub metering")
      lines(dt, df.subset$Sub_metering_2, type="l", col=2)
      lines(dt, df.subset$Sub_metering_3, type="l", col=4)

      # stuff for the legend
      lnames <- c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
      lcolors <- c(1, 2, 4) # black, red, blue
      lwidths <- c(2, 2, 2)
      legend("topright", legend=lnames, col=lcolors, lwd=lwidths)

      dev.off()
}
