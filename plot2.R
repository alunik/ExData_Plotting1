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
png("plot2.png")
plot(df$DateTime, df$Global_active_power, type = "l", xlab = "", ylab = "Global active power (kilowatts)")
dev.off()

