if (!file.exists("hpc.zip")){
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile="hpc.zip")
  unzip("hpc.zip", exdir=".")
}
datas<-read.table("household_power_consumption.txt",header=TRUE,sep=";",colClasses = c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric'),na.strings = "?")
datas$Date<-as.Date(datas$Date,"%d/%m/%Y")
datas<-subset(datas,Date>=as.Date("2007-2-1")&Date<=as.Date("2007-2-2"))
datas<-datas[complete.cases(datas),]
datetime<- paste(datas$Date,datas$Time)
datetime<-setNames(datetime,"datetime")
datas<-cbind(datetime,datas)
datas$datetime<-as.POSIXct(datetime)
par(mfrow=c(2,2))
with(datas,{plot(Global_active_power~datetime,type="l",xlab="",ylab="Global Active Power (kilowatts)")
  plot(Voltage~datetime,type="l",ylab="Voltage (volt)",xlab="")
  plot(Sub_metering_1~datetime, type="l", ylab="Global Active Power (kilowatts)", xlab="")
  lines(Sub_metering_2~datetime,col='Red')
  lines(Sub_metering_3~datetime,col='Blue')
  legend("topright", col=c("black", "red", "blue"),
         legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  plot(Global_reactive_power~datetime, type="l", 
       ylab="Global Rective Power (kilowatts)",xlab="")
})
dev.copy(png,"plot4.png",height=480,width=480)
dev.off()
