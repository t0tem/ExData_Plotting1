## this script follows Programming assignment of Week 1 of 'Exploratory data analysis' from JHU on Coursera

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

# installing and loading 'sqldf' package
if(!("sqldf" %in% rownames(installed.packages()))) {install.packages("sqldf")}
library(sqldf)

# reading from data file only the records of 2007-02-01 and 2007-02-02
df <- read.csv.sql(file1, sep = ";", 
                   sql = "select * from file where (Date = '1/2/2007' or  Date = '2/2/2007')")

# creating a png file with graph
png(file="plot1.png")
par(bg="transparent")
hist(df[,3] , 
     main = "Global Active Power", 
     xlab="Global Active Power (kilowatts)", 
     ylab="Frequency",
     col="red")
dev.off()
