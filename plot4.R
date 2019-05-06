#Reading file, subsetting dataset and field converting

ds <- read.table("./data/household_power_consumption.txt",
                 sep=";",header = T,stringsAsFactors = F)

ds <- subset(ds,Date %in% c("1/2/2007","2/2/2007"))

ds$datetime <- paste(ds$Date,ds$Time)
ds$datetime <- as.POSIXct(ds$datetime,format="%d/%m/%Y %H:%M:%S")

for (i in 3:9) { ds[,i] <- as.numeric(ds[,i]) }

#Setting frame 2x2
par(mfrow=c(2,2),mar=c(3,4,2,2))

names(par())

#Making Plot 1
plot.ts(ds$datetime,ds$Global_active_power,
        ylab="Global Active Power",xlab="",type="l",xaxt="n")

times <- ds$datetime
ticks <- seq(times[1], times[length(times)], by = "days")
axis(1, at = ticks, labels = format(ticks,"%a"))

#Making Plot 2
plot.ts(ds$datetime,ds$Voltage,
        ylab="Voltage",xlab="datetime",type="l",xaxt="n")

times <- ds$datetime
ticks <- seq(times[1], times[length(times)], by = "days")
axis(1, at = ticks, labels = format(ticks,"%a"))

#Making Plot 3
plot.ts(ds$datetime,ds$Sub_metering_1,
        ylab="Energy sub metering",xlab="",type="l",xaxt="n", col="black")
points(ds$datetime,ds$Sub_metering_2, type="l", col="red")
points(ds$datetime,ds$Sub_metering_3, type="l", col="blue")

times <- ds$datetime
ticks <- seq(times[1], times[length(times)], by = "days")
axis(1, at = ticks, labels = format(ticks,"%a"))

legend("topright",legend=paste0("Sub_metering_",c(1:3)),
       col=c("black","red","blue"),lwd=0.1)

#Making Plot 4
plot.ts(ds$datetime,ds$Global_reactive_power,
        ylab="Global_reactive_power",xlab="datetime",type="l",xaxt="n")

times <- ds$datetime
ticks <- seq(times[1], times[length(times)], by = "days")
axis(1, at = ticks, labels = format(ticks,"%a"))


#Exporting to .png
dev.copy(png,"plot4.png",width=480,height=480)
dev.off()
