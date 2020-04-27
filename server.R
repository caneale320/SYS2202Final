library(shiny)
library(ggplot2)

newserver <- function(input, output){
  # Reactive expression to generate the requested distribution ----
  # This is called whenever the inputs change. The output functions
  # defined below then use the value computed from this expression
  dates <- as.Date(CleanCommunications$row.names.Communications.)
  covid <- reactive({
    c <- switch(input$covid,
                   GlobalCases = GlobalCasesByDay$DailyChange ,
                   GlobalDeaths = GlobalDeathsByDay$DailyChange,
                   USCases = USCasesByDay$DailyChange,
                   USDeaths = USDeathsByDay$DailyChange )
    coviddata <- data.frame(dates, c)
  })
  
  
  sumstock <- reactive({
    s <- switch(input$sector,
                "Materials"=CleanMaterials$Materials.XLB.Adjusted,
                "Industrials"=CleanIndustrials$Industrials.XLI.Adjusted,
                "Financials"=CleanFinancials$Financials.XLF.Adjusted,
                "HealthCare"=CleanHealthCare$HealthCare.XLV.Adjusted,
                "Technology"=CleanTechnology$Technology.XLK.Adjusted,
                "Utilities"=CleanUtilities$Utilities.XLU.Adjusted,
                "Energy"=CleanEnergy$Energy.XLE.Adjusted,
                "Communications"=CleanCommunications$Communications.XLC.Adjusted,
                "ConsumerStaples"=CleanConsumerStaples$ConsumerStaples.XLP.Adjusted,
                "ConsumerDiscretionary"=CleanConsumerDiscretionary$ConsumerDiscretionary.XLY.Adjusted)
    
    sumdata <- data.frame(dates, s)
    
  })
  
  comparative1 <- reactive({
    c <- switch(input$covid,
                GlobalCases = GlobalCasesByDay$DailyChange ,
                GlobalDeaths = GlobalDeathsByDay$DailyChange,
                USCases = USCasesByDay$DailyChange,
                USDeaths = USDeathsByDay$DailyChange )
    
    s1 <- switch(input$sector,
                "Materials"=CleanMaterials$zscore.DailyChange.Materials.,
                "Industrials"=CleanIndustrials$zscore.DailyChange.Industrials.,
                "Financials"=CleanFinancials$zscore.DailyChange.Financials.,
                "HealthCare"=CleanHealthCare$zscore.DailyChange.HealthCare.,
                "Technology"=CleanTechnology$zscore.DailyChange.Technology.,
                "Utilities"=CleanUtilities$zscore.DailyChange.Utilities.,
                "Energy"=CleanEnergy$zscore.DailyChange.Energy.,
                "Communications"=CleanCommunications$zscore.DailyChange.Communications.,
                "ConsumerStaples"=CleanConsumerStaples$zscore.DailyChange.ConsumerStaples.,
                "ConsumerDiscretionary"=CleanConsumerDiscretionary$zscore.DailyChange.ConsumerDiscretionary.)
    
   
    comp1data <- data.frame( c, s1)
    
    comp1data <- subset(comp1data, c>0)
    
    
  })
  
  comparative2 <- reactive({
    c <- switch(input$covid,
                GlobalCases = GlobalCasesByDay$DailyChange ,
                GlobalDeaths = GlobalDeathsByDay$DailyChange,
                USCases = USCasesByDay$DailyChange,
                USDeaths = USDeathsByDay$DailyChange )
    
    s2 <- switch(input$sector,
                 "Materials"=CleanMaterials$zscore.DailyRange.Materials.,
                 "Industrials"=CleanIndustrials$zscore.DailyRange.Industrials.,
                 "Financials"=CleanFinancials$zscore.DailyRange.Financials.,
                 "HealthCare"=CleanHealthCare$zscore.DailyRange.HealthCare.,
                 "Technology"=CleanTechnology$zscore.DailyRange.Technology.,
                 "Utilities"=CleanUtilities$zscore.DailyRange.Utilities.,
                 "Energy"=CleanEnergy$zscore.DailyRange.Energy.,
                 "Communications"=CleanCommunications$zscore.DailyRange.Communications.,
                 "ConsumerStaples"=CleanConsumerStaples$zscore.DailyRange.ConsumerStaples.,
                 "ConsumerDiscretionary"=CleanConsumerDiscretionary$zscore.DailyRange.ConsumerDiscretionary.)
    
    comp2data <- data.frame(c, s2)
    
    comp2data <- subset(comp2data, c>0)
    
    
  })
  
  comparative3 <- reactive({
    c <- switch(input$covid,
                GlobalCases = GlobalCasesByDay$DailyChange ,
                GlobalDeaths = GlobalDeathsByDay$DailyChange,
                USCases = USCasesByDay$DailyChange,
                USDeaths = USDeathsByDay$DailyChange )
    
    s3 <- switch(input$sector,
                 "Materials"=CleanMaterials$zscore.DailyVolume.Materials.,
                 "Industrials"=CleanIndustrials$zscore.DailyVolume.Industrials.,
                 "Financials"=CleanFinancials$zscore.DailyVolume.Financials.,
                 "HealthCare"=CleanHealthCare$zscore.DailyVolume.HealthCare.,
                 "Technology"=CleanTechnology$zscore.DailyVolume.Technology.,
                 "Utilities"=CleanUtilities$zscore.DailyVolume.Utilities.,
                 "Energy"=CleanEnergy$zscore.DailyVolume.Energy.,
                 "Communications"=CleanCommunications$zscore.DailyVolume.Communications.,
                 "ConsumerStaples"=CleanConsumerStaples$zscore.DailyVolume.ConsumerStaples.,
                 "ConsumerDiscretionary"=CleanConsumerDiscretionary$zscore.DailyVolume.ConsumerDiscretionary.)
    
    comp3data <- data.frame(c, s3)
    
    comp3data <- subset(comp3data, c>0)
    
  })
  
  plotlabels <- reactive({
    cl <- switch(input$covid,
                GlobalCases = "Daily Change in Global Cases" ,
                GlobalDeaths = "Daily Change in Global Deaths",
                USCases = "Daily Change in US Cases",
                USDeaths = "Daily Change in US Deaths") 
    
    sl <- switch(input$sector,
                 "Materials"= "Materials Z-Score",
                 "Industrials"= "Industrials Z-Score",
                 "Financials"= "Financials Z-Score",
                 "HealthCare"= "Healthcare Z-Score",
                 "Technology"= "Technology Z-Score",
                 "Utilities"= "Utilities Z-Score",
                 "Energy"= "Energy Z-Score",
                 "Communications"= "Communications Z-Score",
                 "ConsumerStaples"= "Consumer Staples Z-Score",
                 "ConsumerDiscretionary"= "Consumer Discretionary Z-Score")
  })
  # Generate a plot of the data ----
  # Also uses the inputs to build the plot label. Note that the
  # dependencies on the inputs and the data reactive expression are
  # both tracked, and all expressions are called in the sequence
  # implied by the dependency graph.
  output$plot <- renderPlot({
    ggplot() + 
      ggtitle("Stock Market Data and COVID Daily Changes") +
      geom_line(data=sumstock(), aes(x=dates, y=s,  color="ETF") )+ 
      geom_line(data=covid(), aes(x=dates, y=c/500, color="COVID")) +
      scale_y_continuous(sec.axis = sec_axis(~.*500, name = input$covid)) +
      labs(y="ETF Close Price", x= "Date", color="Data") +
      theme(axis.text.x = element_text(angle=45), 
            plot.title = element_text(size = 18, face = "bold"),
            axis.title = element_text(face = "bold.italic")) +
      scale_x_date(date_breaks = "2 weeks", date_labels = "%b %d")
  })
  
  # Generate a summary of the data ----
  output$comparativea <- renderPlot({
    ggplot(data=comparative1(), aes(x=c, y=s1)) +
      geom_point(aes(colour = c)) +
      geom_smooth(method="loess") + 
      ggtitle("Normalized Daily Change vs. Change in COVID Data") +
      xlab(input$covid) + 
      ylab(input$sector) + 
      labs(color="Number of Cases") +
      theme(
        plot.title = element_text(size = 18, face = "bold"),
        axis.title = element_text(face = "bold.italic")
      )
  
  })
  
  output$comparativeb <- renderPlot({
    ggplot(data=comparative2(), aes(x=c, y=s2)) +
      geom_point(aes(colour = c))+geom_smooth(method="loess") + 
      ggtitle("Normalized Daily Range vs. Change in COVID Data") +  
      xlab(input$covid) + 
      ylab(input$sector) + 
      labs(color="Number of Cases") +
      theme(
        plot.title = element_text(size = 18, face = "bold"),
        axis.title = element_text(face = "bold.italic")
      )
  })
  
  output$comparativec <- renderPlot({
    ggplot(data=comparative3(), aes(x=c, y=s3)) +
      geom_point(aes(colour = c))+geom_smooth(method="loess")+ 
      ggtitle("Normalized Daily Volume vs. Change in COVID Data")+
      xlab(input$covid) + 
      ylab(input$sector) + 
      labs(color="Number of Cases") +
      theme(
        plot.title = element_text(size = 18, face = "bold"),
        axis.title = element_text(face = "bold.italic")
      )
  
  })
  
  # Generate an HTML table view of the data ----
  output$sentiment <- renderPlot({
    ggplot(marketwatch_average_sentiment) + 
      geom_smooth(aes(PublishedTime,sentiment_averaged)) + 
      ggtitle("Sentiment of @MarketWatch on Twitter") + 
      theme(
        plot.title = element_text(size = 18, face = "bold"),
        axis.title = element_text(face = "bold.italic")
      )
    
    
  })
  
  output$sentimentb <- renderPlot({
    ggplot(coronavirus_average_sentiment) + 
      geom_smooth(aes(PublishedTime,sentiment_averaged)) +
      ggtitle("Sentiment of coronavirus tweets") + 
      theme(
        plot.title = element_text(size = 18, face = "bold"),
        axis.title = element_text(face = "bold.italic")
      )
  })
  
}





