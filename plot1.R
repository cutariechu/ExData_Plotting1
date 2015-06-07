#load library useful for fast reading heavy tables
library(data.table)
#load data 
a<-fread("household_power_consumption.txt",sep=";",na.strings="?")
#subset rows of interest by date
b<-a[a$Date=="1/2/2007" | a$Date=="2/2/2007",]
#plot histogram and save it on PNG in working directory
png("plot1.png",width=480,height=480,units="px")
hist(as.numeric(b$Global_active_power),col="red",
     main="Global active power",xlab="Global active power (kilowatts)")
dev.off()


