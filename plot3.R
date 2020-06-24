#getting required packages
if (!require("tidyverse")) {
  install.packages("tidyverse")
}
library(tidyverse)

#getting header
colNames<- colnames( read.table("household_power_consumption.txt", sep = ";", header = TRUE, nrows = 1))

#reading only the required rows
df<-read.table("household_power_consumption.txt", sep = ";", skip = 66637, nrows = 69517-66637, col.names = colNames, na.strings = "?")

#Converting dates and times to single date/time variable using tidyverse
df <- unite(df, "DateTime", Date:Time, sep=" ", remove = TRUE)
df$DateTime <- strptime(df[,1], "%d/%m/%Y %H:%M:%S")

#plotting
png("plot3.png")
plot(df[,1], df[,6], type = "l", xlab = "", ylab = "Energy sub metering", col=1)
lines(df[,1], df[,7], type = "l", col=2)
lines(df[,1], df[,8], type = "l", col=3)
legend("topright", legend = colNames[7:9], col = c(1,2,3), lty = 1)
dev.off()

