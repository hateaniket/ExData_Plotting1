# Download and unzip the dataset if it doesn't exist
if (!file.exists("household_power_consumption.txt")) {
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", 
                destfile = "dataset.zip", method = "curl")
  unzip("dataset.zip")
}

# Read data into R
data_full <- read.table("household_power_consumption.txt", header=TRUE, na.strings="?", sep=";")

# Subset data for the required dates: 2007-02-01 and 2007-02-02
data <- data_full[(data_full$Date=="1/2/2007" | data_full$Date=="2/2/2007" ), ]

# Convert Date and Time variables to POSIXct
data$Datetime <- strptime(paste(data$Date, data$Time), "%d/%m/%Y %H:%M:%S")
data$Datetime <- as.POSIXct(data$Datetime)
Sys.setlocale("LC_TIME", "English")

# Create Plot 2
png("plot2.png", width=480, height=480)
plot(data$Datetime, data$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")
dev.off()
