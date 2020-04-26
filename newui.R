library(shiny)

newui <- fluidPage(
  
  # App title ----
  titlePanel("The Effects of COVID on the Stock Market"),
  
  # Sidebar layout with input and output definitions ----
  sidebarLayout(
    
    # Sidebar panel for inputs ----
    sidebarPanel(
      
      # Input: Select the random distribution type ----
      radioButtons("covid", "COVID Data:",
                   c("Global Cases" = "GC",
                     "Global Deaths" = "GD",
                     "US Cases" = "USC",
                     "US Deaths" = "USD")),
      
      # br() element to introduce extra vertical spacing ----
      br(),
      
      # Input: Slider for the number of observations to generate ----
      dateInput("start",
                "Start Date:",
                value = "2019-01-01"),
      
      selectInput("sector",
                  "Sector:",
                  c("Materials" = "Materials",
                    "Communications" = "Communications",
                    "Energy" = "Energy",
                    "Financials" = "Financials",
                    "Industrials" = "Industrials",
                    "Technology" = "Technology",
                    "ConsumerStaples" = "ConsumerStaples",
                    "RealEstate" = "RealEstate",
                    "Utilities" = "Utilities",
                    "HealthCare" = "HealthCare",
                    "ConsumerDiscretionary" = "ConsumerDiscretionary" ))
      
    ),
    
    # Main panel for displaying outputs ----
    mainPanel(
      
      # Output: Tabset w/ plot, summary, and table ----
      tabsetPanel(type = "tabs",
                  tabPanel("Summary", plotOutput("plot")),
                  tabPanel("Comparative", verbatimTextOutput("summary")),
                  tabPanel("Sentiment", tableOutput("table"))
      )
      
    )
  )
)

install.packages(c("ggplot", "scales", "Quandl", "TTR"))
library(shiny)
library(ggplot2)
library(scales)
require(Quandl)
library("TTR")

#Shiny Application
server <- function(input,output) {
  
  #Obtain data for plotting
  df <- input$marketdata
  
  output$marketdata <- renderText({
    paste("Market Data: ", input$marketdata)
  })
  
  output$covid <- renderText({
    paste("COVID Date: ", input$covid)
  })
  
  output$sectorselection <- renderUI({
    selectInput("sector", "ETF:", choices = colnames(df))
  })
  #output$plot <- renderPlot({
  # simplemovingaverage=SMA(Communications$XLC.Close,n=20)
  
  
  #plot(x = frame$variable
  
  
}


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
)



