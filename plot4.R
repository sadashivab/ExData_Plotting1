## setwd("F:/coursera/4.Exploratory_Data_Analysis/pa1")

## Load the data
library(sqldf)
DF1 <- read.csv.sql("household_power_consumption.txt", sql = 'select * from file', sep=';', header=TRUE)

## add a timestamp variable named MTS to the dataframe
DF1 <- transform(DF1,MTS=strptime(paste( DF1[,"Date"], DF1[,"Time"]), "%d/%m/%Y %H:%M:%S" ))
DF1[,"Date"] <- as.Date(DF1[,"Date"], "%d/%m/%Y")

## Subset the requisite rows
DF2 <- DF1[DF1$Date == as.Date("2007/02/01", "%Y/%m/%d") | DF1$Date == as.Date("2007/02/02", "%Y/%m/%d"), ]

## Initialise the PNG device 
png(filename = "plot4.png", width = 640, height = 640, units = "px", pointsize = 12, bg = "white")

## Set the number of rows and columns - 4 charts in a 2 by 2 style	
par(mfrow=c(2,2), bg="white")

## Plot 1
plot(DF2[,"MTS"], DF2[,"Global_active_power"], type="l", ylab="Global Active Power", xlab="")

## Plot 2
plot(DF2[,"MTS"], DF2[,"Voltage"], type="l", ylab="Voltage", xlab="datetime", ylim=c(234,246))

## Plot 3 - with multiple lines
plot(DF2[,"MTS"], DF2[,"Sub_metering_1"], type="l", ylab="Energy sub metering", xlab="", col="black")
lines(DF2[,"MTS"], DF2[,"Sub_metering_2"], type="l", col="red")
lines(DF2[,"MTS"], DF2[,"Sub_metering_3"], type="l", col="blue")
legend("topright", col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=c(1,1), bty="n", cex=0.75)

## Plot 4
plot(DF2[,"MTS"], DF2[,"Global_reactive_power"], type="l", xlab="datetime", ylab="Global_reactive_power", ylim=c(0.0,0.5))

## close the PNG file
dev.off()
