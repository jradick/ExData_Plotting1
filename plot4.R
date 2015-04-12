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
# plot4.R
# R program to reproduce the fourth plot:
# An array of 4 sub-plots:
# - upper left is the same as plot2
# - bottom left is the same as plot3
# - upper right is Voltage against date/time
# - bottom right is Global_reactive_power against date/time
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
# - It would be easy to include the plot2 and plot3 images
#   just by executing the code for those plots, but since they
#   each read and parse the input file, that would be really slow.
#   So, instead we read and convert the data once, then
#   generate the 4 plots we need in-line.
#

plot4 <- function() {
      f <- "household_power_consumption.txt"
      df <- read.table(f, sep = ";", header = TRUE, stringsAsFactors = FALSE)
      df[, "Date"] <- as.Date(df[, "Date"], format="%d/%m/%Y")
      df.subset <- df[df$Date == "2007-02-01" | df$Date == "2007-02-02", ]

      # date conversion, need for x-axis of all 4 sub-plots
      dtstr <- paste(df.subset$Date, df.subset$Time)
      dt <- strptime(dtstr, format= "%Y-%m-%d %H:%M:%S")

      # data conversion needed for the upper left plot (plot2 info)
      df.subset[, "Global_active_power"] <-
      		as.numeric(df.subset[, "Global_active_power"])
      
      # data conversions needed for the bottom left (plot3 info)
      df.subset[, "Sub_metering_1"] <-
      		as.numeric(df.subset[, "Sub_metering_1"])
      df.subset[, "Sub_metering_2"] <-
      		as.numeric(df.subset[, "Sub_metering_2"])
      df.subset[, "Sub_metering_3"] <-
      		as.numeric(df.subset[, "Sub_metering_3"])

      # data conversion needed for the upper right plot
      df.subset[, "Voltage"] <-
      		as.numeric(df.subset[, "Voltage"])

      # data conversion needed for the bottom right plot
      df.subset[, "Global_reactive_power"] <-
      		as.numeric(df.subset[, "Global_reactive_power"])

      ####################
      # now make the plots
      # - common set-up
      png(file = "plot4.png", width = 480, height = 480)
      par(mfcol=c(2,2)) # 2 x 2

      # 1: top left, "plot2" but slightly different y-axis label
      plot(dt, df.subset$Global_active_power, type="l",
      		xlab="", ylab="Global Active Power")

      # 2: bottom left, "plot3"
      plot(dt, df.subset$Sub_metering_1, type="l",
      		xlab="", ylab="Energy sub metering")
      lines(dt, df.subset$Sub_metering_2, type="l", col=2)
      lines(dt, df.subset$Sub_metering_3, type="l", col=4)

      #   stuff for the legend, differs from plot3.R, no box around legend
      lnames <- c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
      lcolors <- c(1, 2, 4) # black, red, blue
      lwidths <- c(2, 2, 2)
      legend("topright", legend=lnames, col=lcolors, lwd=lwidths, bty="n")

      # 3: top right, similar to top left but with Voltage
      plot(dt, df.subset$Voltage, type="l",
      		xlab="datetime", ylab="Voltage")

      # 4: bottom right, similar to top left but with Global_reactive_power
      plot(dt, df.subset$Global_reactive_power, type="l",
      		xlab="datetime", ylab="Global_rective_power")

      dev.off()
}
