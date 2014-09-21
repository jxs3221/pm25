# pm25_plot3.R
# This will create a plot that shows what type of source of emissions of PM2.5 decreased in
# Baltimore from 1999 to 2008

# Read in the source datasets

library(ggplot2)
library(plyr)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Subset the data for Baltimore (fips 24510)
balt_data <- subset(NEI, fips=="24510", select=c(year, Emissions, type))

balt_data_type <- ddply(balt_data, .(type,year), summarize, Emissions = sum(Emissions))

qplot(year, Emissions, data=balt_data_type, group=type, color=type, 
    geom = c("point", "line"), ylab = "Total Emissions",
    xlab = "Year", main = "Total Emissions in U.S. by Type of Pollutant")	   

ggsave(file="plot3.png")
	
dev.off()