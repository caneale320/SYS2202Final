library(shiny)
library(ggplot2)

newserver <- function(input, output){
  # Reactive expression to generate the requested distribution ----
  # This is called whenever the inputs change. The output functions
  # defined below then use the value computed from this expression
  dates <- CleanCommunications$row.names.Communications.
  covid <- reactive({
    c <- switch(input$covid,
                   GC = GlobalCasesByDay$DailyChange ,
                   GD = GlobalDeathsByDay$DailyChange,
                   USC = USCasesByDay$DailyChange,
                   USD = USDeathsByDay$DailyChange )
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
  
  comparative <- reactive({
    c <- switch(input$covid,
                GC = GlobalCasesByDay$DailyChange ,
                GD = GlobalDeathsByDay$DailyChange,
                USC = USCasesByDay$DailyChange,
                USD = USDeathsByDay$DailyChange )
    
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
    
    comp1data <- data.frame(c, s1)
    
    
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
  output$summary <- renderPlot({
    d <- comparative()
    plot(d$c, d$s1)
  })
  
  # Generate an HTML table view of the data ----
  output$table <- renderTable({
    
  })
  
}





