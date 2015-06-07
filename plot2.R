#load library useful for fast reading heavy tables
library(data.table)
#load data 
a<-fread("household_power_consumption.txt",sep=";",na.strings="?")
#subset rows of interest by date
b<-a[a$Date=="1/2/2007" | a$Date=="2/2/2007",]
#Create new columns with converted Date and Time columns to "date"&"time" format
b[,Dat2:=as.Date(strptime(Date,"%d/%m/%Y"))]
b$Time2<-paste(b$Dat2," ",b$Time)
b$Time2<-as.POSIXct(b$Time2)
#assign short names to variables to plot
colpower<-as.numeric(b$Global_active_power)
coltime<-b$Time2
#plot graphic and save it on PNG in working directory
#NOTE: week days are displayed in spanish
png("plot2.png",width=480,height=480,units="px")
plot(colpower~coltime,type="l",xlab="",
     ylab="Global active power (kilowatts)")
dev.off()


