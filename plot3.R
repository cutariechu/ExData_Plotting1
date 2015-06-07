#load library useful for fast reading heavy tables
library(data.table)
#fast-load data 
a<-fread("household_power_consumption.txt",sep=";",na.strings="?")
#subset rows of interest by date and put them in variable "b"
b<-a[a$Date=="1/2/2007" | a$Date=="2/2/2007",]
#Create new columns with converted Date and Time columns to "date"&"time" format
b[,Dat2:=as.Date(strptime(Date,"%d/%m/%Y"))]
b$Time2<-paste(b$Dat2," ",b$Time)
b$Time2<-as.POSIXct(b$Time2)
#assign short names to variables to plot
colsub1<-as.numeric(b$Sub_metering_1)
colsub2<-as.numeric(b$Sub_metering_2)
colsub3<-as.numeric(b$Sub_metering_3)
coltime<-b$Time2
#plot graphic and save it on PNG in working directory
#(NOTE: week days are displayed in spanish)
png("plot3.png",width=480,height=480,units="px")
plot(coltime,colsub1,type="l",xlab="",
     ylab="Global active power (kilowatts)")
lines(b$Time2,colsub2,col="red")
lines(b$Time2,colsub3,col="blue")
legend("topright",col=c("black","red","blue"),legend=names(b)[7:9],lty=c(1,1,1))
dev.off()