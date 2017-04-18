#Read in the Data
setwd("/Users/ilin/Documents/EDA/P2/NEI_data")
NEI <- readRDS("summarySCC_PM25.rds")

#Create a subset containing only Baltimore data
BaltimoreTotal <- subset(NEI, NEI$fips=="24510")

#Create a subset for each of the source types (Point, NonPoint, OnRoad, NonRoad), and aggregate the emissions based on years
BaltimorePointTotal <- subset(BaltimoreTotal, type=="POINT")
BaltimorePointTotalEmission <- aggregate(list(emissions = BaltimorePointTotal$Emissions), list(year = BaltimorePointTotal$year), sum)
BaltimoreNonPointTotal <- subset(BaltimoreTotal, type=="NONPOINT")
BaltimoreNonPointTotalEmission <- aggregate(list(emissions = BaltimoreNonPointTotal$Emissions), list(year = BaltimoreNonPointTotal$year), sum)
BaltimoreOnRoadTotal <- subset(BaltimoreTotal, type=="ON-ROAD")
BaltimoreOnRoadTotalEmission <- aggregate(list(emissions = BaltimoreOnRoadTotal$Emissions), list(year = BaltimoreOnRoadTotal$year), sum)
BaltimoreNonRoadTotal <- subset(BaltimoreTotal, type=="NON-ROAD")
BaltimoreNonRoadTotalEmission <- aggregate(list(emissions = BaltimoreNonRoadTotal$Emissions), list(year = BaltimoreNonRoadTotal$year), sum)


#Using ggplots library
library("ggplot2")

#Start Creating PNG file
png("plot3.png", width=480, height=480)

#Drew a line chart with lines for source types
ggplot(BaltimorePointTotalEmission, aes(year, emissions, colour = "Source Type")) + geom_line(aes(y = BaltimorePointTotalEmission$emissions, colour = "point")) + geom_line(aes(y = BaltimoreNonPointTotalEmission$emissions, colour = "nonpoint")) + geom_line(aes(y = BaltimoreOnRoadTotalEmission$emissions, colour = "onroad")) + geom_line(aes(y = BaltimoreNonRoadTotalEmission$emissions, colour = "nonroad"))

#Close the PNG device
dev.off()