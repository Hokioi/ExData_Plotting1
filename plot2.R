# Electric power consumption dataset download
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", 
              destfile = "household_power_consumption.zip")
DateDownloaded <- date()
DateDownloaded ### "Fri Oct 21 14:51:46 2016"
list.files()


# Read the table into R

data <- read.table(unz("household_power_consumption.zip", "household_power_consumption.txt"), header = TRUE, sep = ";")

str(data)
head(data)


# Merge Date and Time  variables into a new column, DateTime

data$DateTime <- paste(data$Date,data$Time)
str(data)
head(data)


#Convert DateTime to POSIXlt to allow easier subsetting

data$DateTime <-strptime(data$DateTime, "%e/%m/%Y %H:%M:%S")
class(data$DateTime)
str(data)


# Subset the data for 1/2/2007 and 2/2/2007

dataFeb1and2 <- subset(data, DateTime >= "2007-2-1 00:00:00" & DateTime <= "2007-2-2 23:59:59")


## Convert factor variables to numeric

dataFeb1and2$Global_active_power <- as.numeric(as.character(dataFeb1and2$Global_active_power))
dataFeb1and2$Sub_metering_1 <- as.numeric(as.character(dataFeb1and2$Sub_metering_1))
dataFeb1and2$Sub_metering_2 <- as.numeric(as.character(dataFeb1and2$Sub_metering_2))
dataFeb1and2$Sub_metering_3 <- as.numeric(as.character(dataFeb1and2$Sub_metering_3))
dataFeb1and2$Voltage <- as.numeric(as.character(dataFeb1and2$Voltage))
dataFeb1and2$Global_reactive_power <- as.numeric(as.character(dataFeb1and2$Global_reactive_power))
str(dataFeb1and2)
head(dataFeb1and2)


# Plot 2 - Global Active Power by day

## set background colour to white

par(bg = "white")

## Plot line chart

plot(dataFeb1and2$DateTime, dataFeb1and2$Global_active_power, xlab = "", ylab = "", type = "n", cex.axis = 0.75)
title(ylab = "Global Active Power (kilowatts)", cex.lab = 0.75)
lines(dataFeb1and2$DateTime, dataFeb1and2$Global_active_power, type = "l")

## Save as plot2.png, 480 x 480 pixels

dev.copy(png, file = "plot2.png", width = 480, height = 480, units = "px")
dev.off()
