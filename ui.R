library(shiny)

#define UI
ui <- fluidPage(
  titlePanel("Title: Stock Market Data"),
  
  fluidRow(
    column(3,
           selectInput("symbols",
                       h3("ETFs"),
                       choices = c(Materials = "Materials",
                                   Communications = "FRED2",
                                   Energy = "FRED3"),
                       selected = Materials)),
    column(3,
           dateInput("start_date",
                     h3("Start Date"),
                     value="2016-05-01")),
    column(3,
           dateInput("end_date",
                     h3("End Date"),
                     value="2017-05-01"))
  ),
  
  #Show a plot of the generated output
  mainPanel(
    plotOutput("FXResults") 
  )
  
)