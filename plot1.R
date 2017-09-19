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
#convert Date field from characters strings to Date
pdata$Date <- as.Date(pdata$Date, format = "%d/%m/%Y")
#dplyr filter() is used to select the rows for the two dates.
#Extract the column needed using select()
plot1_data <- select(filter(pdata, Date == startDate | Date == endDate),
                     Global_active_power)
#convert to numeric after removing any rows with "?"
plot1_data <- as.numeric(plot1_data[plot1_data$Global_active_power != "?",][[1]])
#remove the big dataset
rm(pdata)
#plot the histogram for plot1
hist(plot1_data, col = "red", 
     main = "Global Active Power", ylab = "Frequency", 
     xlab = "Global Active Power (kilowatts)")
dev.copy(png, file = "plot1.PNG", height = 480, width = 480)
dev.off()
