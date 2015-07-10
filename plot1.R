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

data$Date <- as.Date(data$Date, "%d/%m/%Y") # factor need to change to date

class(data$Date)

subdata <- data[(data$Date <= '2007-02-02' & data$Date >= '2007-02-01'),]

subdata$Global_active_power <- as.numeric(as.character(subdata$Global_active_power)) # factor need to change to numeric
class(subdata$Global_active_power)

png(filename = "plot1.png", width = 480, height = 480)  # Create .png file with 480*480 

hist(subdata$Global_active_power,
     xlab = 'Global Active Power (kilowatts)', # asix X title
     ylab = 'Frequency',                       # asix Y title
     main = 'Global Active Power',             # Picture title
     col = 'Red')

dev.off() ## Don't forget to close the PNG device!