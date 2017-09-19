#Source data file path, should be changed to the right path for running 
#the script. 
data_file <- "./data/household_power_consumption.txt"
#packages used
library(dplyr)
#read data file and convert to tibble for use with dplyr
pdata <- tbl_df(read.table(data_file, header = TRUE, sep = ";",
                           stringsAsFactors = FALSE))
#We need to only account for two dates
startDate <- as.Date("2007-02-01")
endDate <- as.Date("2007-02-02")
#add a new column for converted dates that will be used for filtering
#down to the needed dates.
pdata$ConvertedDate <- as.Date(pdata$Date, format = "%d/%m/%Y")
#dplyr filter() is used to select the rows for the two dates.
pdata_reduced <- filter(pdata,
                        ConvertedDate == startDate | ConvertedDate == endDate)
#remove the big dataset
rm(pdata)
#create date/time field
pdata_reduced$DateTime <- as.POSIXct(paste(pdata_reduced$Date, pdata_reduced$Time),
                                     format = "%d/%m/%Y %H:%M:%S")
#convert relevant data columns
pdata_reduced$Sub_metering_1 <- as.numeric(pdata_reduced$Sub_metering_1)
pdata_reduced$Sub_metering_2 <- as.numeric(pdata_reduced$Sub_metering_2)
pdata_reduced$Sub_metering_3 <- as.numeric(pdata_reduced$Sub_metering_3)
# Plot 3 
#open the 'png' device
png(filename = "plot3.PNG", width = 480, height = 480)
#plot 
with(pdata_reduced, {
  plot(DateTime, Sub_metering_1, type="l",
       ylab="Energy sub metering", xlab="")
  lines(DateTime, Sub_metering_2, col="red")
  lines(DateTime, Sub_metering_3, col="blue")
})
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col=c("black", "red", "blue"), lty=1)
#close the png device
dev.off()
