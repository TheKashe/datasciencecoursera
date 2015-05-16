library(data.table)
NEI <- data.table(readRDS("./data/summarySCC_PM25.rds"))
SCC <- data.table(readRDS("./data/Source_Classification_Code.rds"))

# filter by year and Baltimore City,
# group by year and compute totalEmissions
totalPolutionByYear <- NEI[year>=1999 & year <=2008 & fips == "24510",list(totalEmissions=sum(Emissions)),year]

png(filename='plot2.png',width = 480,height = 480)
with(totalPolutionByYear,
	 barplot(totalEmissions/1e3,
	 		names.arg = year,
	 		xlab="year",
	 		ylab=expression(paste("Total PM"[2.5]," *10^3")),
	 		main=expression(paste("Total PM"[2.5]," in Baltimore City, per year"))))
dev.off()