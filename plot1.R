# Script: plot1.R
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
myplot<-function(){
  hist(xdf2[,"Global_active_power"],col="red",
       main="Global Active Power", xlab="Global Active Power (kilowatts)")
}
myplot()

# Save the plot...
plotfile<-paste(cpath,"/plot1.png",sep="")
png(filename=plotfile, width=480, height=480)
myplot()
dev.off()

# rm(list=ls())
