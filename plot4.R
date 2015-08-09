#load packages
library(lubridate)

#read in data to directory the data is located
setwd("C:/Users/Erica/Documents/Coursera/Exploratory Data Analysis/Week1/")

powerData <- read.table("household_power_consumption.txt", sep=";", header=T,stringsAsFactors=F)

#create new dateTime column, change format of column from character to POSIXlt
powerData$dateTime <- paste(powerData$Date, powerData$Time)
powerData <- cbind(dateTime=0, powerData)
powerData$dateTime <- strptime(powerData$dateTime,format = "%d/%m/%Y %H:%M:%S", tz="CET")

#subset to use only the two dates selected for the assignment
subdate1 <- powerData[as.Date(powerData$dateTime) == as.Date("2007-02-01"), ]
subdate2 <- powerData[as.Date(powerData$dateTime) == as.Date("2007-02-02"), ]
powerDates <- rbind(subdate1, subdate2)

#change non-date/time columns to numeric 
powerDates$Global_active_power <- as.numeric(powerDates$Global_active_power)
powerDates$Global_reactive_power <- as.numeric(powerDates$Global_reactive_power)
powerDates$Voltage <- as.numeric(powerDates$Voltage)
powerDates$Global_intensity <- as.numeric(powerDates$Global_intensity)
powerDates$Sub_metering_1 <- as.numeric(powerDates$Sub_metering_1)
powerDates$Sub_metering_2 <- as.numeric(powerDates$Sub_metering_2)
powerDates$Sub_metering_3 <- as.numeric(powerDates$Sub_metering_3)


#make an image of 4 combined plots
png("plot4.png",width=480, height=480)
par(mfcol=c(2,2), mar=c(5,4,4,2))
with(powerDates, {
  plot(powerDates$dateTime,powerDates$Global_active_power, ylab="Global Active Power", xlab="", type="l")
  plot(powerDates$dateTime, powerDates$Sub_metering_1, type="l", col="black", xlab="", ylab="Energy sub metering")
  par(new=F)
  lines(powerDates$dateTime, powerDates$Sub_metering_2, type="l", col="red")
  lines(powerDates$dateTime, powerDates$Sub_metering_3, type="l", col="blue")
  legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, col=c("black", "red", "blue"), bty="n") 
  plot(powerDates$dateTime, powerDates$Voltage, type="l", col="black", xlab="datetime", ylab="Voltage")
  plot(powerDates$dateTime, powerDates$Global_reactive_power, type="l", col="black", xlab="datetime", ylab="Global_reactive_power")
})
dev.off()
