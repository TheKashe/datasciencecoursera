library(data.table)
library(ggplot2)
NEI <- data.table(readRDS("./data/summarySCC_PM25.rds"))
SCC <- data.table(readRDS("./data/Source_Classification_Code.rds"))

#join NEI and SCC
setkey(NEI,SCC)
setkey(SCC,SCC)
NEI <- NEI[SCC,nomatch=0]
rm(SCC)

##filter NEI by EI.Sector which contain string "Vehicle"
#and fips=Baltimore City or LA Country
#calculate total emissions by year and fips
totalVehiclePolutionByYear <- NEI[grepl("Vehicle",EI.Sector) & (fips == "24510" | fips == "06037"),list(totalVehicleEmissions=sum(Emissions)),b=list(year,fips)]
#replace numeric factors with human readable values
totalVehiclePolutionByYear[fips == "24510", fips:= "Baltimore City"]
totalVehiclePolutionByYear[fips == "06037", fips:= "LA County"]

#plot
png(filename='plot6.png',width = 480,height = 480)
plot <- ggplot(data = totalVehiclePolutionByYear,aes(x=year,y=totalVehicleEmissions,color=fips)) + 
	geom_smooth() +
	geom_point() +
	ggtitle("Total Vehicle Emissions by year in Baltimore City and  LA County") +
	ylab("Total Vehicle Emissions")
print(plot)
dev.off()