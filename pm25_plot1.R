# pm25_plot1.R
# This will create a plot that shows if total emissions of PM2.5 decreased in
# the United States from 1999 to 2008

# Read in the source datasets

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Aggregate the data by year
nei_agg <- aggregate(NEI[,"Emissions"], by=list(NEI$year), FUN=sum)
colnames(nei_agg) <- c("Year", "Emissions")

# Put the emissions in Kilotons
nei_agg$Emissions <- nei_agg$Emissions/1000

# Display the results in a readable barchart

png("plot1.png", width=640, height=640)
barplot(nei_agg$Emissions, names.arg=nei_agg$Year,
        main="Total Emissions in Kilotons", xlab="Year", ylab="Emissions")

dev.off()