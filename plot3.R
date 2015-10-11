#  The purpose of this code is to explore the house hold power usage 
#  over the 2 day period from 2/1/2007 -2/2/2007

#  read and prepare the data
library(lubridate)
library(datasets)

data <- data.frame(read.delim("./data/household_power_consumption.txt", sep = ";", na.strings = "?"))
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")
data$datetime <- paste(data$Date, data$Time)
data$Time <- strptime(data$datetime, format = "%Y-%m-%d %H:%M:%S")
data$weekday <- wday(data$Time, label = TRUE)
names(data) <- gsub("_",".",names(data))
names(data) <- tolower(names(data))
#  subset data to desired time period
subinterval <- new_interval(ymd("2007-02-01"),ymd("2007-02-02"))
subdata <- subset(data, (ymd(data$date) %within% subinterval))


## Create plot in PNG file
png(file = "plot3.png", height = 480, width = 480) 
with(subdata, plot(time, sub.metering.1, type = "n", xlab = "", ylab = "Energy sub metering"))
        with(subdata, points(time, sub.metering.1, type = "l"))
        with(subdata, points(time, sub.metering.2, type = "l", col = "Red"))
        with(subdata, points(time, sub.metering.3, type = "l", col = "Blue"))
        legend("topright", lty=c(1,1,1), col = c("black", "red", "blue"), 
               legend = c("sub_metering_1","sub_metering_2","sub_metering_3"))

dev.off()
