## Project Week 1 Coursera 

## 0.1 Check if all libraries are installed
x <- c("zip" )
new<- x[!(x %in% installed.packages()[,"Package"])]
if(length(new)) install.packages(new)
rm(x,new)

## 0.2 Read libraries
library(zip)

## 0.3 Check if data set is already downloaded in the current working directory and download it if is not available.

if (file.exists("household_power_consumption.txt")){print("Already exists")
} else {
      file1 <- "https://d396qusza40orc.cloudfront.net/exdata/data/household_power_consumption.zip"
      download.file(file1, destfile = "x.zip", method = "curl")
      unzip("x.zip") 
}
hhold<- read.table("household_power_consumption.txt", sep = ";", header = TRUE, na.strings = "?")

## 0.4 Extract information (only 2007-02-01 & 2007-02-02)
hhold_filter<- subset(hhold, Date %in% c("1/2/2007","2/2/2007"))
hhold_filter$dt <- strptime(paste(hhold_filter$Date, hhold_filter$Time), "%d/%m/%Y %H:%M:%S")



## 1.0 Create histogram plot

hist(hhold_filter$Global_active_power, col = "red", xlab = "Global Active Power (kilowatts)", ylab = "Frequency", main = "Global Active Power", breaks = 13, ylim = c(0,1200))
dev.copy(png, file = "plot1.png", width=480, height=480)
dev.off()

## 2.0 Create XY graph

plot(hhold_filter$dt, hhold_filter$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (Kilowatts)")
dev.copy(png, file = "plot2.png", width=480, height=480)
dev.off()


## 3.0 Create 3 lines (sub_metering) graph

plot(hhold_filter$dt, hhold_filter$Sub_metering_1, type = "l", xlab = "", ylab = "Energy Sub Metering")
points(hhold_filter$dt, hhold_filter$Sub_metering_2, type = "l", col = "red")
points(hhold_filter$dt, hhold_filter$Sub_metering_3, type = "l", col = "blue")
legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), cex = .4)
dev.copy(png, file = "plot3.png", width=480, height=480)
dev.off()


## 4.0 Create mosaic graph

par(mfrow=c(2,2))
par(mar=c(4,4,4,4))
plot(hhold_filter$dt, hhold_filter$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power")
plot(hhold_filter$dt, hhold_filter$Voltage, type = "l", xlab = "Datetime", ylab = "Voltage")
plot(hhold_filter$dt, hhold_filter$Sub_metering_1, type = "l", xlab = " ", ylab = "Energy Sub Metering")
points(hhold_filter$dt, hhold_filter$Sub_metering_2, type = "l", col = "red")
points(hhold_filter$dt, hhold_filter$Sub_metering_3, type = "l", col = "blue")
legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), bty = "n", cex = 0.8)
plot(hhold_filter$dt, hhold_filter$Global_reactive_power, type = "l", xlab = "Datetime", ylab = "Global_reactive_power")
dev.copy(png, file = "plot4.png", width=480, height=480)
dev.off()

## End Script