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
           varSelectInput("marketdata",
                     h3("Market Data"),
                     choices = c(DailyChange="Daily Change",
                                 DailyRange="Daily Range",
                                 DailyVolume="Daily Volume"),
                     selected = DailyChange)),
    column(3,
           selectInput("covid",
                     h3("Covid Data"),
                     choices = c(GlobalCovidCases="Global Cases",
                                 GlobalCovidDeaths="Global Deaths",
                                 UScovidCases="US Cases",
                                 UScovidDeaths="US Deaths"),
                     selected = GlobalCovidCases))
  ),
  
  #Show a plot of the generated output
  mainPanel(
    plotOutput("FXResults") 
  )
  
)