install.packages(c("ggplot", "scales", "Quandl", "TTR"))
library(shiny)
library(ggplot2)
library(scales)
require(Quandl)
library("TTR")

#Shiny Application
server <- function(input,output) {
  
  #Obtain data for plotting
  df <- input$marketdata
  
  output$marketdata <- renderText({
    paste("Market Data: ", input$marketdata)
  })
  
  output$covid <- renderText({
    paste("COVID Date: ", input$covid)
  })
  
  output$sectorselection <- renderUI({
    selectInput("sector", "ETF:", choices = colnames(df))
  })
  #output$plot <- renderPlot({
   # simplemovingaverage=SMA(Communications$XLC.Close,n=20)
    
   
    #plot(x = frame$variable
    
      
  }


