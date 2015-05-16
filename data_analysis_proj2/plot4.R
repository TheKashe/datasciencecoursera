library(data.table)
library(ggplot2)
NEI <- data.table(readRDS("./data/summarySCC_PM25.rds"))
SCC <- data.table(readRDS("./data/Source_Classification_Code.rds"))

#join NEI and SCC by SCC
setkey(NEI,SCC)
setkey(SCC,SCC)
NEI <- NEI[SCC,nomatch=0]
#remove SCC as it's not needed anymore
rm(SCC)

#filter NEI by SCC.Level.Three which contains string "Coal"
#calculate total emissions by year
totalCoalPolutionByYear <- NEI[grepl("Coal",SCC.Level.Three),list(totalCoalEmissions=sum(Emissions)),year]

#plot
png(filename='plot4.png',width = 480,height = 480)
plot <- ggplot(data = totalCoalPolutionByYear,aes(x=year,y=totalCoalEmissions)) + 
	geom_smooth() +
	geom_point() +
	ggtitle("Total Coal Emissions by year in the USA") +
	ylab("Total Coal Emissions")
print(plot)
dev.off()