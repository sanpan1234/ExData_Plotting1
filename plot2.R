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
#plot 2
plot(pdata_reduced$Global_active_power~pdata_reduced$DateTime, type="l",
     ylab="Global Active Power (kilowatts)", xlab="")
dev.copy(png, file = "plot2.PNG", height = 480, width = 480)
dev.off()
