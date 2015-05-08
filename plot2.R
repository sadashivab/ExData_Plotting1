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

## Draw the line chart with title and labels
plot(DF2[,"MTS"], DF2[,"Global_active_power"], type="l", ylab="Global Active Power (kilowatts)", xlab="")

## Set the margins
par(mar=c(4,4,3,4))

## Copy chart to a PNG file and release the device
dev.copy(png, file = "plot2.png")
dev.off()
