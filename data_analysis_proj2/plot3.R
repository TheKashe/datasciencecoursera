library(data.table)
library(ggplot2)
NEI <- data.table(readRDS("./data/summarySCC_PM25.rds"))
SCC <- data.table(readRDS("./data/Source_Classification_Code.rds"))

# filter polution by years (not needed given this data, but generic) 
# and Baltimore City
# summarise total emissions by year and type
totalPolutionByYear <- NEI[year>=1999 & year <=2008 & fips == "24510",
						   list(totalEmissions=sum(Emissions)),by=list(year,type)]

#plot 
png(filename='plot3.png',width = 480,height = 480)
ggplot(data = totalPolutionByYear,aes(x=year,y=totalEmissions,color=type)) + 
	geom_smooth() +
	geom_point() +
	ggtitle("Total Emissions by Type in Baltimore City") +
	ylab("Total Emissions")
dev.off()