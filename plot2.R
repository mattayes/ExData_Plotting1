## Preliminary
if(!file.exists("./epc")){dir.create("./epc")}
setwd("./epc")
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, destfile = "./epc.zip", method = "curl")
rm(fileUrl)
unzip("./epc.zip")
file.rename(from = "./household_power_consumption.txt", to = "./epc.txt")

## Read in subset of file (I figured this out using math + trial and error)
epc <- read.table("./epc.txt", sep = ";", skip = 66637, nrows = 2880,
                  stringsAsFactors = FALSE,  na.strings = "?",
                  col.names = c("Date", "Time", "Global_active_power", 
                                "Global_reactive_power", "Voltage", 
                                "Global_intensity", "Sub_metering_1", 
                                "Sub_metering_2", "sub_metering_3"))

## Create new dateTime variable and remove date/time
library(lubridate)
epc$dateTime <- with(epc, paste(Date, Time))
epc$dateTime <- dmy_hms(epc$dateTime)
epc$Date <- NULL
epc$Time <- NULL
epc <- epc[, c(8, 1:7)]

## Plot 2
png("plot2.png")
plot(epc$dateTime, epc$Global_active_power, type = "l", xlab = "",
     ylab = "Global Active Power (kilowatts)")
dev.off()
