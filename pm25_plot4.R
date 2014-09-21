# pm25_plot4.R
# This will create a plot that shows coal emissions of PM2.5 decreased in
# Baltimore from 1999 to 2008

# Read in the source datasets

library(ggplot2)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Find all coal sources
coal_data <- grep("coal", SCC$Short.Name, ignore.case = T)

coal_data <- SCC[coal_data, ]

#Subset the NEI data for coal sources
coal_data <- NEI[NEI$SCC %in% coal_data$SCC, ]

#Aggregate the emissions by year
coal_emissions_agg <- aggregate(coal_data$Emissions, list(coal_data$year), FUN = "sum")
colnames(coal_emissions_agg) <- c("Year","Emissions")

# Put the emissions in Kilotons
coal_emissions_agg$Emissions <- coal_emissions_agg$Emissions/1000

png("plot4.png", width = 640, height = 640)

barplot(coal_emissions_agg$Emissions, names.arg=coal_emissions_agg$Year,
     main = "Total Emissions From Coal Combustion Sources from 1999 to 2008", 
     ylab = expression("Total Emission in Kilotons"))

dev.off()
