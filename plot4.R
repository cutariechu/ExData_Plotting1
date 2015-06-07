#load library useful for fast reading heavy tables
library(data.table)
#load data 
a<-fread("household_power_consumption.txt",sep=";",na.strings="?")

#subset rows of interest by date and put it in variable "b"
b<-a[a$Date=="1/2/2007" | a$Date=="2/2/2007",]

#Create new columns with converted Date and Time columns to "date"&"time" format
b[,Dat2:=as.Date(strptime(Date,"%d/%m/%Y"))]
b$Time2<-paste(b$Dat2," ",b$Time)
b$Time2<-as.POSIXct(b$Time2)

#assign short names to variables to plot
colpower<-as.numeric(b$Global_active_power)
colpower2<-as.numeric(b$Global_reactive_power)
colvoltage<-as.numeric(b$Voltage)
colsub1<-as.numeric(b$Sub_metering_1)
colsub2<-as.numeric(b$Sub_metering_2)
colsub3<-as.numeric(b$Sub_metering_3)
coltime<-b$Time2

#plot graphics and save them on PNG in working directory
#NOTE: week days are displayed in spanish
png("plot4.png",width=480,height=480,units="px")

#create column layout
par(mfcol=c(2,2))

#plot top left
plot(colpower~coltime,type="l",xlab="",
     ylab="Global active power")
#plot bottom left
plot(col4,colsub1,type="l",xlab="",
     ylab="Energy sub metering")
lines(coltime,colsub2,col="red")
lines(coltime,colsub3,col="blue")
legend("topright",col=c("black","red","blue"),
       legend=names(b)[7:9],bty="n",lty=c(1,1,1))
#plot top right
plot(colvoltage~coltime,type="l",xlab="datetime",
     ylab="Voltage")
#plot bottom right
plot(colpower2~coltime,type="l",xlab="datetime",
     ylab="Global_reactive_power")
dev.off()