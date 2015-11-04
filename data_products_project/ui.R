library(shiny)
library(data.table)
library(shinyjs)
library(rCharts)


securities <- read.csv("./securities.csv")
securitySelection <- setNames(as.character(securities$symbol),securities$name)
shinyUI(fluidPage(
	useShinyjs(),
	# Application title
	titlePanel("Stock Analyzer"),
	
	# Sidebar with a slider input for the number of bins
	sidebarLayout(
		sidebarPanel(
			a(href="help.html","Help",target="help"),
			selectInput("securities","Select stock",securitySelection,multiple=F),
			div(id = "controls", 
				dateInput("fromDate","From",value="10/1/2015"),
				dateInput("toDate","To",value=Sys.Date()),
				checkboxGroupInput("which",label="Show", choices=c("open","high","low","close","adjusted"), selected = "adjusted", inline = FALSE, width = NULL)
			)	
		),
		
		# Show a plot of the generated distribution
		mainPanel(
			tabsetPanel(id="tabs",
				tabPanel("Price history",value="price", showOutput("pricePlot","dimple")),
				tabPanel("Net Income", value="income", showOutput("incomePlot","dimple"))
			)
		)
	)
))