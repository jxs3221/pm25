# pm25_plot6.R
# This will create a plot comparing motor vechicle emissions of PM2.5 in
# Baltimore and Los Angeles from 1999 to 2008

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
balt_data_agg$County <- rep("Baltimore",length(balt_data_agg[,1]))

#Subset the data just for LA
la_data <- subset(motor_data, fips=="06037", select=c(year, Emissions))
la_data_agg <- aggregate(la_data[,"Emissions"], by=list(la_data$year), FUN=sum)
la_data_agg$County <- rep("Los Angeles",length(la_data_agg[,1]))

#Combine Baltimore and LA County aggregate datasets
motor_data_agg <- rbind(balt_data_agg,la_data_agg)
motor_data_agg$County <- as.factor(motor_data_agg$County)
colnames(motor_data_agg) <- c("Year", "Emissions","County")

# Put the emissions in Kilotons
motor_data_agg$Emissions <- motor_data_agg$Emissions/1000



qplot(Year, Emissions, data= motor_data_agg, group = County, color = County,
     geom = c("point","line"),theme(axis.title=element_text(size=10, face="bold")),
     main = "Comparison of Emissions", 
     ylab = expression("Total Emission in Kilotons"))

ggsave(file="plot6.png")	 
	 
dev.off()
