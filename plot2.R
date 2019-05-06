#Reading file, subsetting dataset and field converting

ds <- read.table("./data/household_power_consumption.txt",
                 sep=";",header = T,stringsAsFactors = F)

ds <- subset(ds,Date %in% c("1/2/2007","2/2/2007"))

ds$datetime <- paste(ds$Date,ds$Time)
ds$datetime <- as.POSIXct(ds$datetime,format="%d/%m/%Y %H:%M:%S")

for (i in 3:9) { ds[,i] <- as.numeric(ds[,i]) }

#Setting frame 1x1
par(mfrow=c(1,1),mar=c(3,4,2,2))

#Plot making
plot(ds$datetime, ds$Global_active_power, type="l",
     ylab="Global Active Power (kilowatts)", xlab="")

#Exporting to .png
dev.copy(png,"plot2.png",width=480,height=480)
dev.off()
