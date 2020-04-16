install.packages(c("ggplot", "scales", "Quandl", "TTR"))
library(shiny)
library(ggplot2)
library(scales)
require(Quandl)
library("TTR")

#Shiny Application
shinyServer(function(input,output) {
  
  #Obtain data for plotting
  selectedtrends <- reactive({
    req(input$sector)
    req(input$covid)
    req(input$marketdata)
    
    frame <- input$marketdata
    
    variable <- input$sector
  })
  
  output$plot <- renderPlot({
    simplemovingaverage=SMA(Communications$XLC.Close,n=20)
    
   
    plot(x = frame$variable
    
      
  })
})

