# Script: plot1.R

print("running plot1.R...")
setwd("/Users/hfc/GitHub/ExData_Plotting1")   # change as needed...
# list.files(path=".")

# get the column headers from the input file...
fn1<-file("household_power_consumption.txt","r")
xch<-scan(fn1,what=character(),sep=";", nlines=1)
close(fn1)

xcc<-c("character","character","numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric")

# get data for two days: Feb 1 2007 and Feb 2, 2007...
xdf1 <- read.csv("household_power_consumption.txt", sep=";", colClasses=xcc, 
                 col.names=xch, header=T, skip=66636, nrows=2880)
rm(xch, xcc)   # get rid of objects that are no longer needed.

# Add Date-time group (DTG) column...
xdt1<-xdf1[,c("Date","Time")]
xdt2<-paste(xdt1[,Date],xdt1[,Time])
xdt3<-strptime(xdt2, "%d/%m/%Y %H:%M:%S")
xdf1$DTG <- xdt3
xdf2<-xdf1[,c("Date","Time","DTG","Global_active_power","Global_reactive_power","Voltage",
              "Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")]

# Define Plotting Functions...
plot1 <- function(df){
  hist(xdf2[,"Global_active_power"],col="red",
       main="Global Active Power", xlab="Global Active Power (kilowatts)")
}
plot2 <-function(df){
  with(xdf2, plot(DTG, Global_active_power, type="l", 
                  ylab="Global Active Power (kilowatts)", xlab=""))
}
plot3 <- function(df){
  with(xdf2, plot(DTG, Sub_metering_1, type="l",xlab="", ylab="Energy sub metering"))
  with(xdf2, lines(DTG,Sub_metering_2,type="l", col="red"))
  with(xdf2, lines(DTG,Sub_metering_3,type="l",col="blue"))
  legend("topright", lty=c(1,1,1), col=c("black","red","blue"), 
         legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
}

# Execute plot functions...
# Create histogram...
plot1(xdf2)

# Create line graph...
plot2(xdf2)

# Creatre multi-variant line graph...

plot3(xdf2)
