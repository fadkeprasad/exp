if(!file.exists("exdata-data-household_power_consumption.zip")) {
        temp <- tempfile()
        download.file("http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
        file <- unzip(temp)
        unlink(temp)
}
power <- read.table(file, header=T, sep=";")
power$Date <- as.Date(power$Date, format="%d/%m/%Y")
x <- power[(power$Date=="2007-02-01") | (power$Date=="2007-02-02"),]
x$Global_active_power <- as.numeric(as.character(x$Global_active_power))
x$Global_reactive_power <- as.numeric(as.character(x$Global_reactive_power))
x$Voltage <- as.numeric(as.character(x$Voltage))
x <- transform(x, timestamp=as.POSIXct(paste(Date, Time)), "%d/%m/%Y %H:%M:%S")
x$Sub_metering_1 <- as.numeric(as.character(x$Sub_metering_1))
x$Sub_metering_2 <- as.numeric(as.character(x$Sub_metering_2))
x$Sub_metering_3 <- as.numeric(as.character(x$Sub_metering_3))

plot4 <- function() {
        par(mfrow=c(2,2))
        
        
        plot(x$timestamp,x$Global_active_power, type="l", xlab="", ylab="Global Active Power")
        
        plot(x$timestamp,x$Voltage, type="l", xlab="datetime", ylab="Voltage")
        
        
        plot(x$timestamp,x$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
        lines(x$timestamp,x$Sub_metering_2,col="red")
        lines(x$timestamp,x$Sub_metering_3,col="blue")
        legend("topright", col=c("black","red","blue"), c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  "),lty=c(1,1), bty="n", cex=.5) #bty removes the box, cex shrinks the text, spacing added after labels so it renders correctly
        
        
        plot(x$timestamp,x$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")
        
        
        dev.copy(png, file="plot4.png", width=480, height=480)
        dev.off()
        cat("plot4.png has been saved in", getwd())
}
plot4()