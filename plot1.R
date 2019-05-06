#Reading file, subsetting dataset and field converting

ds <- read.table("./data/household_power_consumption.txt",
                 sep=";",header = T,stringsAsFactors = F)

ds <- subset(ds,Date %in% c("1/2/2007","2/2/2007"))

ds$Date <- as.Date(ds$Date,"%d/%m/%Y")
ds$Time <- strptime(ds$Time,"%H:%M:%S")

for (i in 3:9) { ds[,i] <- as.numeric(ds[,i]) }

#Plot making
hist(ds$Global_active_power,col="red",main="Global Active Power",
     xlab="Global Active Power (kilowatts)", ylab="Frecuency")

#Exporting to .png
dev.copy(png,"plot1.png",width=480,height=480)
dev.off()