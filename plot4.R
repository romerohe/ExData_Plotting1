#Reading file, subsetting dataset and field converting

ds <- read.table("./data/household_power_consumption.txt",
                 sep=";",header = T,stringsAsFactors = F)

ds <- subset(ds,Date %in% c("1/2/2007","2/2/2007"))

ds$datetime <- paste(ds$Date,ds$Time)
ds$datetime <- as.POSIXct(ds$datetime,format="%d/%m/%Y %H:%M:%S")

for (i in 3:9) { ds[,i] <- as.numeric(ds[,i]) }

#Setting frame 2x2
par(mfrow=c(2,2),mar=c(3,4,2,2))

#Making Plot 1
plot(ds$datetime, ds$Global_active_power, type="l",
     ylab="Global Active Power", xlab="")

#Making Plot 2
plot(ds$datetime, ds$Voltage, type="l",
     ylab="Voltage", xlab="datetime")

#Making Plot 3
plot(ds$datetime, ds$Sub_metering_1, type="l",
     ylab="Energy sub metering", xlab="", col="black")
lines(ds$datetime,ds$Sub_metering_2, col="red")
lines(ds$datetime,ds$Sub_metering_3, col="blue")

legend("topright",legend=paste0("Sub_metering_",c(1:3)),
       col=c("black","red","blue"),lwd=0.1)

#Making Plot 4
plot(ds$datetime, ds$Voltage, type="l",
     ylab="Global_reactive_power", xlab="datetime")


#Exporting to .png
dev.copy(png,"plot4.png",width=480,height=480)
dev.off()
