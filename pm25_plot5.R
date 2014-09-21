# pm25_plot5.R
# This will create a plot that shows what type of source of emissions of PM2.5 decreased in
# Baltimore from 1999 to 2008

# Read in the source datasets

library(ggplot2)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Find all motor vehicle sources
motor_data <- grep("motor", SCC$Short.Name, ignore.case = T)

motor_data <- SCC[motor_data, ]

#Subset the NEI data for motor vehicle sources
motor_data <- NEI[NEI$SCC %in% motor_data$SCC, ]

#Subset the data just for Baltimore
balt_data <- subset(motor_data, fips=="24510", select=c(year, Emissions))

balt_data_agg <- aggregate(balt_data[,"Emissions"], by=list(balt_data$year), FUN=sum)
colnames(balt_data_agg) <- c("Year", "Emissions")

# Put the emissions in Kilotons
balt_data_agg$Emissions <- balt_data_agg$Emissions/1000

png("plot5.png", width=640, height=640)

barplot(balt_data_agg$Emissions, names.arg=balt_data_agg$Year,
     main = "Total Emissions From Motor Vehicle Sources in Baltimore from 1999 to 2008", 
     ylab = expression("Total Emission in Kilotons"))

dev.off()
