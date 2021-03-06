# The dataset has 2,075,259 rows and 9 columns.
# First calculate a rough estimate of how much memory the dataset
# will require in memory before reading into R.
# Make sure your computer has enough memory
# (most modern computers should be fine).

nrow <- 2075259
ncol <- 9
mem <- nrow * ncol * 8 / 1e+006
cat("Required memory is: ", mem, " MB\n", sep = "")
cat('R is using', memory.size(), 'MB out of limit', memory.limit(), 'MB')

################################################################################

file = "household_power_consumption.txt"
header <- read.table(file, header = FALSE, sep = ";", na.strings = "?", 
                     nrows = 1, stringsAsFactors = FALSE)
# We will only be using data from the dates 2007-02-01 and 2007-02-02.
data <- read.table(file, header = FALSE, sep = ";", na.strings = "?",
                   skip = 66637, nrows = 2880)
colnames(data) <- unlist(header)

################################################################################

png(filename = "plot3.png", width = 480, height = 480, units = "px")
par(mfrow = c(1, 1))
data$Datetime <- strptime(paste(data$Date, data$Time), "%d/%m/%Y %H:%M:%S")
plot(data$Datetime, data$Sub_metering_1, type = "n",
     xlab = "",
     ylab = "Energy sub metering")
lines(data$Datetime, data$Sub_metering_1, col = "black")
lines(data$Datetime, data$Sub_metering_2, col = "red")
lines(data$Datetime, data$Sub_metering_3, col = "blue")
legend("topright", pch = NA, lty = 1, bty = "n", 
       col = c("black", "red", "blue"),
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()