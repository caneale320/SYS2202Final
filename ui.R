install.packages("shiny")
library(shiny)

#define UI
ui <- fluidPage(
  titlePanel("Title: Stock Market Data"),
  
  fluidRow(
    
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
                     selected = GlobalCovidCases)),
    uiOutput("sectorselection")
      
  ),
  
  
  #Show a plot of the generated output
  mainPanel(
    
   
  ))


