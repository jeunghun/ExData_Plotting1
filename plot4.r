##preparation for exploratory data analysis
##you can skip this process, if you've run another plot#.r script.

##downloading file
wd<-getwd()
fn<-"/household_power_consumption"
zipfn<-paste(wd,fn,".zip",sep="")
txtfn<-paste(wd,fn,".txt",sep="")

if(!file.exists(txtfn)){
          download.file("http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
                        zipfn, method="internal")
          unzip(zipfn,overwrite=T,exdir=wd)          
}
## Getting full dataset

tempdata<-read.table("household_power_consumption.txt", sep=";",
                     header=T, na.strings="?")

## converting date format
tempdata$Date<-as.Date(tempdata$Date, format="%d/%m/%Y")

## subsetting the data
dataforplot<-subset(tempdata, subset=(Date>="2007-02-01"&Date<="2007-02-02"))

## merging Date column and Time column
Datetime<-as.POSIXct(Datetime)

## column wise bind Datetime column, and data
dataforplot<-cbind(Datetime,dataforplot)



## Plot4

par(mfrow=c(2,2), mar=c(4,4,2,1),oma=c(0,0,2,0))


with(dataforplot,{plot(Global_active_power~Datetime, type="l", 
                       ylab="Global Active Power (kilowatts)", xlab="")
          plot(Voltage~Datetime, type="l", 
               ylab="Voltage (volt)", xlab="")
          plot(Sub_metering_1~Datetime, type="l", 
               ylab="Global Active Power (kilowatts)", xlab="")
          lines(Sub_metering_2~Datetime,col='Red')
          lines(Sub_metering_3~Datetime,col='Blue')
          legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
                 legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
          plot(Global_reactive_power~Datetime, type="l", 
               ylab="Global Rective Power (kilowatts)",xlab="")
})
## save graph to file
dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()
