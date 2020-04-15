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
  })
  
  output$FXResults <- renderPlot({
    
    #currency = Quandl(input$symbols,start_date=input$start_date , end_date=input$end_date,type = "xts")
    #currencydf = data.frame(currency)
    simplemovingaverage=SMA(Communications$XLC.Close,n=20)
    
   
    plot(Communications$XLC.Close,type="l",col="blue",xlab="Days",ylab="Price")
    lines(simplemovingaverage,type = "l",col="red")
    title(main=input$symbols)
    
      
  })
})
