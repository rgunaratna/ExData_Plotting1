## Exploratory Data Analysis
## Project 1
## Plot1
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

#Generate plot1-histogram of Global Active Power
hist(powerConsumpFebDT$Global_active_power, 
     xlab = "Global Active Power (kilowatts)",
     ylab = "Frequency",
     main = "Global Active Power",
     col = "red")
dev.copy(device = png, file = "plot1.png", width = 480, height = 480, unit = "px")
dev.off()
