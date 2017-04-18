#Read in the Data
setwd("/Users/ilin/Documents/EDA/P2/NEI_data")
NEI <- readRDS("summarySCC_PM25.rds")

#Create a subset containing only Baltimore data
BaltimoreTotal <- subset(NEI, NEI$fips=="24510")

#Start Creating PNG file
png("plot2.png", width=480, height=480)

#Aggreate column "Emissions" according to column "year" so we can have the sum of PM2.5 emission for each year
BaltimoreTotalEmissions <- aggregate(list(emissions = BaltimoreTotal$Emissions), list(year = BaltimoreTotal$year), sum)
plot(BaltimoreTotalEmissions$year, BaltimoreTotalEmissions$emissions, type="l", cex.lab=0.8, cex.axis=0.8, col="red", xlab="Year", ylab="Total PM2.5 Emissions (Tons)")

#Close the PNG device
dev.off()