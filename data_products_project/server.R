
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(quantmod)
library(data.table)
library(Quandl)
library(reshape2)
library(rjson)

#this is for rCharts dimple
xtsMelt <- function(data) {
	#translate xts to time series to json with date and data
	#for this behavior will be more generic than the original
	#data will not be transformed, so template.rmd will be changed to reflect
	#convert to data frame
	data.df <- data.frame(cbind(format(index(data),"%Y-%m-%d"),coredata(data)))
	colnames(data.df)[1] = "date"
	data.melt <- melt(data.df,id.vars=1,stringsAsFactors=FALSE)
	colnames(data.melt) <- c("date","var","value")
	#remove periods from indexnames to prevent javascript confusion
	#these . usually come from spaces in the colnames when melted
	data.melt[,"var"] <- apply(matrix(data.melt[,"var"]),2,gsub,pattern="[.]",replacement="")
	return(data.table(data.melt))
}

shinyServer(function(input, output) {
	observe({
		#browser()
		if (identical(input$tabs, "income")) {
			disable(id="controls")
		} else {
			enable(id="controls")
		}
	})
	
	output$pricePlot <- renderChart2({
		data <-getSymbols(input$securities,auto.assign = F,from=input$fromDate,to=input$toDate)
		colnames(data) <-c ("open","high","low","close","volume","adjusted")
		data <- xtsMelt(data)
		data <- data[var %in% input$which,]
		#browser()
		p <- dPlot(
			value ~ date,
			data = data,
			type = 'line', 
			groups="var",
			bounds = list(x=70,y=10,height=320,width=500)
		)
		return(p)
	})
	
	output$incomePlot <- renderChart2({
		disable(id="controls")
		securities <- data.table(read.csv("./securities.csv"))
		security <- securities[symbol==input$securities,]
		if(is.null(security)|is.na(security$incomeSrc)) return(NULL)
		data <-data.table(Quandl(as.character(security$incomeSrc)))
		data[,Date:=as.character(Date)]
		p <- dPlot(
			Value ~ Date,
			data = data,
			type = 'line',
			bounds = list(x=70,y=10,height=320,width=500)
		)
		return(p)
	})

})
