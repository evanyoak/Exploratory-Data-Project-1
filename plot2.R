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
finaldata$Global_active_power <- as.numeric(as.character(finaldata$Global_active_power))

#Plotting and saving to PNG
png(file="plot2.png",width=480,height=480)
par(mfrow = c(1,1))
plot(finaldata$Global_active_power, type = "l", ylab = "Global Active Power (kilowatts)", xaxt = "n", xlab = "")
axis(1, at = c(0, 1500, 2880), labels=c("Thu", "Fri", "Sat"))
dev.off()
