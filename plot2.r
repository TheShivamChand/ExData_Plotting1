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
datas$datetime <- as.POSIXct(datetime)
plot(datas$Global_active_power~datas$datetime,type='l', ylab="Global Active Power (kilowatts)", xlab="")
dev.copy(png,"plot2.png",height=480,width=480)
dev.off()