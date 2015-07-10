##  The dataset has 2,075,259 rows and 9 columns. First calculate a rough estimate of how 
##  much memory the dataset will require in memory before reading into R. Make sure your 
##  computer has enough memory (most modern computers should be fine).

##  We will only be using data from the dates 2007-02-01 and 2007-02-02. One alternative 
##  is to read the data from just those dates rather than reading in the entire dataset 
##  and subsetting to those dates.

##  You may find it useful to convert the Date and Time variables to Date/Time classes 
##  in R using the strptime() and as.Date() functions.

##  Note that in this dataset missing values are coded as ?.

data <- read.table('./data/household_power_consumption.txt', header = T, sep = ';')

library(lubridate)

data$Date <- as.Date(data$Date, "%d/%m/%Y") # factor need to change to date
data$Time <- as.character(data$Time) # factor need to change to date

class(data$Date)
class(data$Time)

subdata <- data[(data$Date <= '2007-02-02' & data$Date >= '2007-02-01'),]

subdata$Global_active_power <- as.numeric(as.character(subdata$Global_active_power)) # factor need to change to numeric
class(subdata$Global_active_power)

subdata$Sub_metering_1 <- as.numeric(as.character(subdata$Sub_metering_1)) # factor need to change to numeric
subdata$Sub_metering_2 <- as.numeric(as.character(subdata$Sub_metering_2)) # factor need to change to numeric
subdata$Sub_metering_3 <- as.numeric(as.character(subdata$Sub_metering_3)) # factor need to change to numeric

class(subdata$Sub_metering_1)
class(subdata$Sub_metering_2)
class(subdata$Sub_metering_3)

datetime <- strptime(paste(subdata$Date, subdata$Time, sep=" "), "%Y-%m-%d %H:%M:%S") 
subdata <- data.frame(subdata, 'datetime' = datetime)

png(filename = "plot3.png", width = 480, height = 480)  # Create .png file with 480*480 

plot(subdata$datetime, 
     subdata$Sub_metering_1,
     type = 'l', 
     xlab = "",
     ylab = 'Energy sub metering') # asix Y title

lines(subdata$datetime, subdata$Sub_metering_2, type="l", col="Red")
lines(subdata$datetime, subdata$Sub_metering_3, type="l", col="Blue")

legend("topright", 
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lty = 1, 
       col = c("black", "red", "blue"))

dev.off() ## Don't forget to close the PNG device!
