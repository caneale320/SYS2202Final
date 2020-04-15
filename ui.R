library(shiny)

#define UI
ui <- fluidPage(
  titlePanel("Title: Stock Market Data"),
  
  fluidRow(
    column(3,
           selectInput("sector",
                       h3("ETFs"),
                       choices = c(Materials = "Materials",
                                   Communications = "Communications",
                                   Energy = "Energy",
                                   Financials="Financials",
                                   Industrials="Industrials",
                                   Technology="Technology",
                                   ConsumerStaples="Consumer Staples",
                                   RealEstate="Real Estate",
                                   Utilities="Utilities",
                                   HealthCare="HealthCare",
                                   ConsumerDiscretionary="Consumer Discretionary"),
                       selected = Materials)),
    column(3,
           dateInput("startdate",
                     h3("Start Date"),
                     value="2016-05-01")),
    column(3,
           selectInput("covid",
                     h3("Covid Data"),
                     choices = c(GlobalCases="Global Cases",
                                 GlobalDeaths="Global Deaths",
                                 USCases="US Cases",
                                 USDeaths="US Deaths"),
                     selected = GlobalCases)
  ),
  
  #Show a plot of the generated output
  mainPanel(
    plotOutput("FXResults") 
  )
  
)