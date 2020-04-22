## Exploratory Data Analysis
## Project 1
## Plot4
## 
## Generates plot1.png

suppressPackageStartupMessages({
  library(data.table)
})

url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url, destfile = "project1data.zip")
unzip("project1data.zip")

# Extract column names from the file
colnamesDT <- unlist(strsplit(readLines("household_power_consumption.txt", 1),split = ";"))

# Read in a subset of complete dataset that has dates 1-2-2007 and 2-2-2007
powerConsumpFebDT <- fread(cmd = paste("grep", "^[1,2]\\/2\\/2007", "household_power_consumption.txt"), 
                           col.names = colnamesDT,
                           sep = ";",
                           header = F,
                           na.strings = "?",
                           stringsAsFactors=FALSE)

# Format Date column to Date
powerConsumpFebDT[,"Date"] <- as.Date(powerConsumpFebDT$Date, "%d/%m/%Y")

# Concatenate Date and Time columns to POSIXct format
powerConsumpFebDT[,"DateTime"] <- as.POSIXct(paste(powerConsumpFebDT$Date, powerConsumpFebDT$Time))

#Generate plot4
par(mfcol = c(2,2))
#plot1-1
with(powerConsumpFebDT, plot(DateTime, Global_active_power, 
                             type = "l",
                             ylab = "Global Active Power (kilowatts)"))

#plot2-1
with(powerConsumpFebDT, plot(DateTime, Sub_metering_1, 
                             type = "l",
                             ylab = "Energy sub metering"))
lines(powerConsumpFebDT$DateTime, powerConsumpFebDT$Sub_metering_2, col = "red")
lines(powerConsumpFebDT$DateTime, powerConsumpFebDT$Sub_metering_3, col = "blue")
legend("topright"
       , col=c("black","red","blue")
       , c("Sub_metering_1","Sub_metering_2", "Sub_metering_3")
       ,lty=c(1,1), lwd=c(1,1), cex = 0.6, bty = "n", inset = c(0, -0.05))

#plot1-2
with(powerConsumpFebDT, plot(DateTime, Voltage, 
                             type = "l",
                             ylab = "Voltage"))

#plot2-2
with(powerConsumpFebDT, plot(DateTime, Global_reactive_power, 
                             type = "l"))
dev.copy(device = png, file = "plot4.png", width = 480, height = 480, unit = "px")
dev.off()
