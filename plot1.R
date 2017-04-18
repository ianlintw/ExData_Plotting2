#Read in the Data
setwd("/Users/ilin/Documents/EDA/P2/NEI_data")
NEI <- readRDS("summarySCC_PM25.rds")

#Start Creating PNG file
png("plot1.png", width=480, height=480)

#Aggreate column "Emissions" according to column "year" so we can have the sum of PM2.5 emission for each year
TotalEmissions <- aggregate(list(emissions = NEI$Emissions), list(year = NEI$year), sum)
plot(TotalEmissions$year, TotalEmissions$emissions, type="l", cex.lab=0.8, cex.axis=0.8, col="red", xlab="Year", ylab="Total PM2.5 Emissions (Tons)")

#Close the PNG device
dev.off()