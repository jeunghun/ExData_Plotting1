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



## Plot3

with(dataforplot,{plot(Sub_metering_1~Datetime, xlab="", type="l", ylab="Energy sub metering")
                  lines(Sub_metering_2~Datetime, col="red")
                  lines(Sub_metering_3~Datetime, col="blue")})
legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3")
       ,lty=1, lwd=2.5, col=c("black","red","blue"))

## save graph to file
dev.copy(png, file="plot3.png", height=480, width=480)
dev.off()


