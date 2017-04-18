#Read in the Data
setwd("/Users/ilin/Documents/EDA/P2/NEI_data")
NEI <- readRDS("summarySCC_PM25.rds")

#Create subset containing only Baltimore and LA data individually
BaltimoreTotal <- subset(NEI, NEI$fips=="24510")
LATotal <- subset(NEI, NEI$fips=="06037")

#Create subsets for the source type OnRoad since it is supposed to include all motor vehicle by definition, and aggregate the emissions based on years
BaltimoreOnRoadTotal <- subset(BaltimoreTotal, type=="ON-ROAD")
BaltimoreOnRoadTotalEmission <- aggregate(list(emissions = BaltimoreOnRoadTotal$Emissions), list(year = BaltimoreOnRoadTotal$year), sum)

LAOnRoadTotal <- subset(LATotal, type=="ON-ROAD")
LAOnRoadTotalEmission <- aggregate(list(emissions = LAOnRoadTotal$Emissions), list(year = LAOnRoadTotal$year), sum)

#Using ggplots library
library("ggplot2")

#Start Creating PNG file
png("plot6.png", width=480, height=480)

#Drew a line chart with lines for source type Motor Vehicle in both Baltimore and LA
ggplot(BaltimoreOnRoadTotalEmission, aes(year, emissions, colour = "Source Type")) + geom_line(aes(y = BaltimoreOnRoadTotalEmission$emissions, colour = "Motor Vehicle Baltimore")) + geom_line(aes(y = LAOnRoadTotalEmission$emissions, colour = "Motor Vehicle LA"))

#Close the PNG device
dev.off()