#load packages
library(lubridate)

#read in data to directory the data is located
setwd("C:/Users/Erica/Documents/Coursera/Exploratory Data Analysis/Week1/")

powerData <- read.table("household_power_consumption.txt", sep=";", header=T,stringsAsFactors=F)

#create new dateTime column, change format of column from character to POSIXlt
powerData$dateTime <- paste(powerData$Date, powerData$Time)
powerData$dateTime <- strptime(powerData$dateTime,format = "%d/%m/%Y %H:%M:%S", tz="CET")

#subset to use only the two dates selected for the assignment
subdate1 <- powerData[as.Date(powerData$dateTime) == as.Date("2007-02-01"), ]
subdate2 <- powerData[as.Date(powerData$dateTime) == as.Date("2007-02-02"), ]
powerDates <- rbind(subdate1, subdate2)

#change non-date/time column to numeric 
powerDates$Global_active_power <- as.numeric(powerDates$Global_active_power)

#plot and export to png
png("plot1.png", width=480, height=480)
hist(powerDates$Global_active_power, xlab= "Global Active Power (kilowatts)",ylab="Frequency", col="red", main="Global Active Power")
dev.off()
