#Reading data - assumes you have the "household_power_consumption.txt" file in your working directory
household <- read.table("household_power_consumption.txt", header = TRUE, nrows = 2075270, stringsAsFactors = FALSE, sep = ";")

#Converting strings to dates and subsetting the data to the finaldata dataframe with just two dates
library(lubridate)
household$Date <- dmy(household$Date)
newdata <- subset(household, Date == ymd("2007-02-01"))
newdata2 <- subset(household, Date == ymd("2007-02-02"))
finaldata <- rbind(newdata, newdata2)

#Converting the other relevant variables to time or numeric as appropriate
finaldata$Time <- hms(finaldata$Time)
finaldata$Sub_metering_1 <- as.numeric(as.character(finaldata$Sub_metering_1))
finaldata$Sub_metering_2 <- as.numeric(as.character(finaldata$Sub_metering_2))
finaldata$Sub_metering_3 <- as.numeric(as.character(finaldata$Sub_metering_3))

#Plotting and saving to PNG
png(file="plot3.png",width=480,height=480)
plot(finaldata$Sub_metering_1, type = "l", xaxt = "n", xlab = "", ylab = "Energy sub metering")
lines(finaldata$Sub_metering_2, col = "red")
lines(finaldata$Sub_metering_3, col = "blue")
axis(1, at = c(0, 1500, 2880), labels=c("Thu", "Fri", "Sat"))
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lwd = 1, col = c("black", "red", "blue"))
dev.off()

#Saving PNG
#dev.copy(png, file = "plot3.png")
#dev.off()