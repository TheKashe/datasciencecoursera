library(data.table)
library(ggplot2)
NEI <- data.table(readRDS("./data/summarySCC_PM25.rds"))
SCC <- data.table(readRDS("./data/Source_Classification_Code.rds"))

#join NEI and SCC
setkey(NEI,SCC)
setkey(SCC,SCC)
NEI <- NEI[SCC,nomatch=0]
rm(SCC)

#filter NEI by EI.Sector which contain string "Vehicle"
#and fips=Baltimore City
#calculate total emissions by year
totalVehiclePolutionByYear <- NEI[grepl("Vehicle",EI.Sector) & fips == "24510",
								  list(totalVehicleEmissions=sum(Emissions)),
								  year]

png(filename='plot5.png',width = 480,height = 480)
plot <- ggplot(data = totalVehiclePolutionByYear,aes(x=year,y=totalVehicleEmissions)) + 
	geom_smooth() +
	geom_point() +
	ggtitle("Total Vehicle Emissions by year in Baltimore City") +
	ylab("Total Vehicle Emissions")
print(plot)
dev.off()