# Check if you already have the data; if not download and unzip
if (!file.exists("./data")) { dir.create("./data") }
sourceDat <- "./data/household_power_consumption.txt"
if (!file.exists(sourceDat)) {
    destFile <- "./data/household_power_consumption.zip"
    fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    download.file(fileURL, destfile = destFile, method = "curl")
    unzip(destFile, exdir = "./data")
}

# Read the data in from the file
df <- read.table(sourceDat, sep = ";", header = TRUE)

# Create a new DateTime column in POSIXlt format from the Date and Time columns
df$DateTime <- strptime(paste(df$Date, df$Time), "%d/%m/%Y %H:%M:%S")

# Not subset this dataframe between the two required dates 2007-02-01 and 2007-02-02
dfSub <- subset(df, (as.Date(df$DateTime) == as.Date("2007-02-01")) | (as.Date(df$DateTime) == as.Date("2007-02-02")))

# Prepare the output file
png("./data/plot2.png")

# 2nd plot
with(dfSub, plot(DateTime, as.numeric(as.character(Global_active_power)), xlab = "", ylab = "Global Active Power (kilowatts)", type = "n"))
with(dfSub, lines(DateTime, as.numeric(as.character(Global_active_power))))

# Close the output file
dev.off()
