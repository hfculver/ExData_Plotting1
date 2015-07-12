# Script: plot4.R
# Author: H. Culver
# Created: 7/12, 2015

cpath<-"/Users/hfc/GitHub/ExData_Plotting1"   #change as needed...
print("running plot1.R...")
setwd(cpath)
# list.files(path=".")

# get the column headers from the input file...
fn1<-file("household_power_consumption.txt","r")
xch<-scan(fn1,what=character(),sep=";", nlines=1)
close(fn1)

# get data for two days: Feb 1 2007 and Feb 2, 2007...
xcc<-c("character","character","numeric", "numeric", "numeric", "numeric", 
       "numeric", "numeric", "numeric")
xdf1 <- read.csv("household_power_consumption.txt", sep=";", colClasses=xcc, 
                 col.names=xch, header=T, skip=66636, nrows=2880)
rm(xch, xcc)   # get rid of objects that are no longer needed.

# Add Date-time group (DTG) column...
xdate<-xdf1[,"Date"]
xtime<-xdf1[,"Time"]
xdt2<-paste(xdate,xtime)
xdt3<-strptime(xdt2, "%d/%m/%Y %H:%M:%S")
xdf1$DTG <- xdt3
xdf2<-xdf1[,c("Date","Time","DTG","Global_active_power","Global_reactive_power","Voltage",
              "Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")]
rm(xdate,xtime,xdt2,xdt3,xdf1)

# Create plot...
myplot1<-function(){
  with(xdf2, plot(DTG, Global_active_power, type="l", 
                  ylab="Global Active Power (kilowatts)", xlab=""))
}
myplot2<-function(){
  with(xdf2, plot(DTG, Sub_metering_1, type="l",xlab="", ylab="Energy sub metering"))
  with(xdf2, lines(DTG,Sub_metering_2,type="l", col="red"))
  with(xdf2, lines(DTG,Sub_metering_3,type="l",col="blue"))
  legend("topright", lty=c(1,1,1), col=c("black","red","blue"), 
         legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
}
myplot3<-function(){
  with(xdf2, plot(DTG, Voltage, type="l",xlab="datetime", ylab="Voltage"))
}
myplot4<-function(){
  with(xdf2, plot(DTG, Global_reactive_power, type="l",xlab="datetime"
                  , ylab="Global_reactive_power"))
}

par(mfcol=c(2,2))
myplot1()
myplot2()
myplot3()
myplot4()

# Save the plot...
plotfile<-paste(cpath,"/plot4.png",sep="")
png(filename=plotfile, width=480, height=480)
par(mfcol=c(2,2))
myplot1()
myplot2()
myplot3()
myplot4()
dev.off()

# rm(list=ls())
