library(data.table)
NEI <- data.table(readRDS("./data/summarySCC_PM25.rds"))
SCC <- data.table(readRDS("./data/Source_Classification_Code.rds"))

#using data.table, filter data (strictly speaking that's not necessary)
# group by year and calculate totalEmissions
totalPolutionByYear <- NEI[year %in% c(1999,2002,2005,2008),list(totalEmissions=sum(Emissions)),year]

#plot using base
png(filename='plot1.png',width = 480,height = 480)
with(totalPolutionByYear,
	 barplot(totalEmissions/1e3,
	 		names.arg = year,
	 		xlab="year",
	 		ylab=expression(paste("Total PM"[2.5]," *10^3")),
	 		main=expression(paste("Total PM"[2.5]," per year"))))
dev.off()