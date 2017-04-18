#Read in the Data
setwd("/Users/ilin/Documents/EDA/P2/NEI_data")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Create a subset of emission source code/name mapping for coal combustion related sources
#Looks like we only need the entries whose EI.sector == "Fuel Comb - Electric Generation - Coal", "Fuel Comb - Industrial Boilers, ICEs - Coal", or "Fuel Comb - Comm/Institutional - Coal"
SCC_coal <- subset(SCC, EI.Sector=="Fuel Comb - Electric Generation - Coal" | EI.Sector=="Fuel Comb - Industrial Boilers, ICEs - Coal" | EI.Sector=="Fuel Comb - Comm/Institutional - Coal")

#Create a subset of NEI when its SCC exists in SCC_coal we just created
NEI_coal <- subset(NEI, SCC %in% SCC_coal$SCC)

#Aggregate the emissions based on years
USCoalTotalEmission <- aggregate(list(emissions = NEI_coal$Emissions), list(year = NEI_coal$year), sum)

#Using ggplots library
library("ggplot2")

#Start Creating PNG file
png("plot4.png", width=480, height=480)

#Drew a line chart with a line for the coal combustion related emissions in US
ggplot(USCoalTotalEmission, aes(year, emissions, colour = "Source Type")) + geom_line(aes(y = USCoalTotalEmission$emissions, colour = "Coal Combustion USA"))

#Close the PNG device
dev.off()