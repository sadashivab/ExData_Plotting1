## setwd("F:/coursera/4.Exploratory_Data_Analysis/pa1")

## Load the data
library(sqldf)
DF1 <- read.csv.sql("household_power_consumption.txt", sql = 'select * from file', sep=';', header=TRUE)

## Convert date variable into date datatype
DF1[,"Date"] <- as.Date(DF1[,"Date"], "%d/%M/%Y")

## Subset the requisite rows
DF2 <- DF1[DF1$Date == as.Date("2007/02/01", "%Y/%M/%d") | DF1$Date == as.Date("2007/02/02", "%Y/%M/%d"), ]

## Set background
par(bg="white")

## Draw the histogram with title and labels
hist(DF2$Global_active_power, breaks=18, col="red", main="Global Active Power", xlim=c(0,7), xlab="Global Active Power (kilowatts)", axes=FALSE)

## Set the margins
par(mar=c(4,4,3,8))

## Set axis tick marks and tick labels
axis(side=1, at=seq(0,6, 2), labels=seq(0,6,2))
axis(side=2, at=seq(0,12000, 2000), labels=seq(0,1200,200))

## Copy chart to a PNG file and release the device
dev.copy(png, file = "plot1.png")
dev.off()
