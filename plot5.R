#Read in the Data
setwd("/Users/ilin/Documents/EDA/P2/NEI_data")
NEI <- readRDS("summarySCC_PM25.rds")

#Create a subset containing only Baltimore data
BaltimoreTotal <- subset(NEI, NEI$fips=="24510")

#Create a subset for the source type OnRoad since it is supposed to include all motor vehicle by definition, and aggregate the emissions based on years
BaltimoreOnRoadTotal <- subset(BaltimoreTotal, type=="ON-ROAD")
BaltimoreOnRoadTotalEmission <- aggregate(list(emissions = BaltimoreOnRoadTotal$Emissions), list(year = BaltimoreOnRoadTotal$year), sum)

#Using ggplots library
library("ggplot2")

#Start Creating PNG file
png("plot5.png", width=480, height=480)

#Draw a line chart with lines for source type Motor Vehicle in Baltimore
ggplot(BaltimorePointTotalEmission, aes(year, emissions, colour = "Source Type")) + geom_line(aes(y = BaltimoreOnRoadTotalEmission$emissions, colour = "Motor Vehicle Baltimore"))

#Close the PNG device
dev.off()