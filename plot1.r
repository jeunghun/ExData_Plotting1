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




## Plot1
hist(dataforplot$Global_active_power,col="red", main="Global Active Power",
     xlab="Global Active Power(kilowatts)")
## Saving graph to file
dev.copy(png, file="plot1.png", height=480, width=480)
dev.off()
