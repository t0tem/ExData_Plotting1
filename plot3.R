## this script follows Programming assignment of Week 1 of 'Exploratory data analysis' from JHU on Coursera
## and creates Plot 3

# function to download and unzip the data file to R working directory
get_file <- function () {
    url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    download.file(url, "household_power_consumption.zip")
    unzip("household_power_consumption.zip")
}

file1 <- "household_power_consumption.txt"

# getting file if it doesn't exist in working directory
if (!file.exists(file1)) {
    get_file()
}

# installing (if necessary) and loading 'sqldf' package
if(!("sqldf" %in% rownames(installed.packages()))) {install.packages("sqldf")}
library(sqldf)

# reading from data file only the records of 2007-02-01 and 2007-02-02
df <- read.csv.sql(file1, sep = ";", 
                   sql = "select * from file where (Date = '1/2/2007' or  Date = '2/2/2007')")

# adding a new Date-Time column of class POSIXlt
df$DateTime <- strptime(paste(df[,1], df[,2]), format="%d/%m/%Y %H:%M:%S")

# creating a png file with graph
png(file="plot3.png")
par(bg="transparent") #adding transparent background

#plotting
with(df, plot(DateTime, Sub_metering_1,
              ann=FALSE,
              type="l",
              col = "black"))
with(df, lines(DateTime, Sub_metering_2, col = "red"))
with(df, lines(DateTime, Sub_metering_3, col = "blue"))
legend("topright", lty = 1,
       col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
title(ylab="Energy sub metering")

dev.off() #not forgetting to close device :)



















