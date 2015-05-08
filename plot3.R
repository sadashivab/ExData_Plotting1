## setwd("F:/coursera/4.Exploratory_Data_Analysis/pa1")

## Load the data
library(sqldf)
DF1 <- read.csv.sql("household_power_consumption.txt", sql = 'select * from file', sep=';', header=TRUE)

## add a timestamp variable named MTS to the dataframe
DF1 <- transform(DF1,MTS=strptime(paste( DF1[,"Date"], DF1[,"Time"]), "%d/%m/%Y %H:%M:%S" ))
DF1[,"Date"] <- as.Date(DF1[,"Date"], "%d/%m/%Y")

## Subset the requisite rows
DF2 <- DF1[DF1$Date == as.Date("2007/02/01", "%Y/%m/%d") | DF1$Date == as.Date("2007/02/02", "%Y/%m/%d"), ]

## Set background
par(bg="white")

## Intially draw the plot with first line.
plot(DF2[,"MTS"], DF2[,"Sub_metering_1"], type="l", ylab="Energy sub metering", xlab="", col="black")

## Add second line to the same plot
lines(DF2[,"MTS"], DF2[,"Sub_metering_2"], type="l", col="red")

## Add thirs line to the same plot
lines(DF2[,"MTS"], DF2[,"Sub_metering_3"], type="l", col="blue")

## Add legend and adjust margins
legend("topright", col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=c(1,1), cex=.60)
par(mar=c(4,4,3,4))

## Copy chart to a PNG file and release the device
dev.copy(png, file = "plot3.png")
dev.off()
