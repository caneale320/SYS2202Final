library(shiny)
library(ggplot2)

#Defining Server for Shiny Application
newserver <- function(input, output){
  
  #Creation of date dataframe which will be referenced in the summary tab and begins on January 1, 2019
  dates <- CleanCommunications$row.names.Communications.
  
  #Creation of COVID data which is to be used on summary tab
  covid <- reactive({
    
    #Mapping radio button input into numeric vectors which will serve as y values on summary plot
    c <- switch(input$covid,
                   GlobalCases = GlobalCasesByDay$DailyChange ,
                   GlobalDeaths = GlobalDeathsByDay$DailyChange,
                   USCases = USCasesByDay$DailyChange,
                   USDeaths = USDeathsByDay$DailyChange )
    
    #Data frame which includes full time period and COVID data
    coviddata <- data.frame(dates, c)
  })
  
  #Creation of Sector data which will be used on the summary tab
  sumstock <- reactive({
    
    #Mapping sector user input into numerical vectors which will then be used as y values on the summary tab
    #In this case we chose to use Adjuested Close values on the plot, however it is possible to use Open or Average the two
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
    
    #Data frame which includes date and stock sector data
    sumdata <- data.frame(dates, s)
    
  })
  
  #Comparative Tab
  
  #Trimming of data for first comparative plot which is Daily Change in Sector vs. COVID data
  comparative1 <- reactive({
    
    #Mapping radio button input into numeric vectors which will serve as y values on summary plot
    c <- switch(input$covid,
                GlobalCases = GlobalCasesByDay$DailyChange ,
                GlobalDeaths = GlobalDeathsByDay$DailyChange,
                USCases = USCasesByDay$DailyChange,
                USDeaths = USDeathsByDay$DailyChange )
    
    #Selecting paticular variable vector from Clean Sector data frame
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
    
    #Creation of data frame including covid data, x variable, and sector data, y variable
    comp1data <- data.frame( c, s1)
    
    #Trimmed data frame to remove days where there was 0 covid cases/deaths to avoid skewing plot to the left
    #Additionally, the summary tab provides insight to preexisting trends the comparative tab is for when covid is present
    comp1data <- subset(comp1data, c>0)
    
    
  })
  
  comparative2 <- reactive({
    
    #Mapping radio button input into numeric vectors which will serve as y values on summary plot
    c <- switch(input$covid,
                GlobalCases = GlobalCasesByDay$DailyChange ,
                GlobalDeaths = GlobalDeathsByDay$DailyChange,
                USCases = USCasesByDay$DailyChange,
                USDeaths = USDeathsByDay$DailyChange )
    
    #Selecting paticular variable vector from Clean Sector data frame
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
    
    #Creation of data frame including covid data, x variable, and sector data, y variable
    comp2data <- data.frame(c, s2)
    
    comp2data <- subset(comp2data, c>0)
    
    
  })
  
  comparative3 <- reactive({
    
    #Mapping radio button input into numeric vectors which will serve as y values on summary plot
    c <- switch(input$covid,
                GlobalCases = GlobalCasesByDay$DailyChange ,
                GlobalDeaths = GlobalDeathsByDay$DailyChange,
                USCases = USCasesByDay$DailyChange,
                USDeaths = USDeathsByDay$DailyChange )
    
    #Selecting paticular variable vector from Clean Sector data frame
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
    
    #Creation of data frame including covid data, x variable, and sector data, y variable
    comp3data <- data.frame(c, s3)
    
    
    comp3data <- subset(comp3data, c>0)
    
  })
  
 
  # Generate a plot of the data ----
  # Also uses the inputs to build the plot label. Note that the
  # dependencies on the inputs and the data reactive expression are
  # both tracked, and all expressions are called in the sequence
  # implied by the dependency graph.
  output$plot <- renderPlot({
    ggplot() + 
      geom_line(data=sumstock(), aes(x=dates, y=s))+ 
      geom_line(data=covid(), aes(x=dates, y=c/2000)) +
      scale_y_continuous(sec.axis = sec_axis(~.*2000, name = "Temporary")) +
      labs(x= "Date") +
      theme(axis.text.x = element_text(angle=45)) +
      scale_x_date(date_breaks = "1 week")
        
  })
  
  # Generate a summary of the data ----
  output$comparativea <- renderPlot({
    ggplot(data=comparative1(), aes(x=c, y=s1)) +
      geom_point(aes(colour = c)) +
      geom_smooth(method="loess") + 
      ggtitle("Normalized Daily Change vs. Change in COVID Data") +
      xlab(input$covid) + 
      ylab(input$sector) + 
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
  
}





