# pm25_plot2.R
# This will create a plot that shows if total emissions of PM2.5 decreased in
# Baltimore from 1999 to 2008

# Read in the source datasets

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Subset the data for just Baltimore
balt_data <- subset(NEI, fips=="24510", select=c(year, Emissions))

balt_data_agg <- aggregate(balt_data[,"Emissions"], by=list(balt_data$year), FUN=sum)
colnames(balt_data_agg) <- c("Year", "Emissions")

# Put the emissions in Kilotons
balt_data_agg$Emissions <- balt_data_agg$Emissions/1000

# Display the results in a readable barchart

png("plot2.png", width=640, height=640)
barplot(balt_data_agg$Emissions, names.arg=balt_data_agg$Year,
        main="Total Baltimore Emissions in Kilotons", xlab="Year", ylab="Emissions")


dev.off()