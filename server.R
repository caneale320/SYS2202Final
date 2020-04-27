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
  
  # Generate a plot of the data ----
  # Also uses the inputs to build the plot label. Note that the
  # dependencies on the inputs and the data reactive expression are
  # both tracked, and all expressions are called in the sequence
  # implied by the dependency graph.
  output$plot <- renderPlot({
    ggplot() + 
      geom_line(data=sumstock(), aes(x=dates, y=s))+ 
      geom_line(data=covid(), aes(x=dates, y=c/2000)) +
      scale_y_continuous(sec.axis = sec_axis(~.*2000, name = "Temporary"))
  })
  
  # Generate a summary of the data ----
  output$summary <- renderPlot({
    
  })
  
  # Generate an HTML table view of the data ----
  output$table <- renderTable({
    
  })
  
}





