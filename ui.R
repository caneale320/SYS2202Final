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
                   c("Global Cases" = "GlobalCases",
                     "Global Deaths" = "GlobalDeaths",
                     "US Cases" = "USCases",
                     "US Deaths" = "USDeaths")),
      
      # br() element to introduce extra vertical spacing ----
      br(),
      
      # Input: Slider for the number of observations to generate ----
      
      
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
                  tabPanel("Comparative", plotOutput("comparativea", width = 600, height = 300),
                           plotOutput("comparativeb", width = 600, height = 300),
                           plotOutput("comparativec", width = 600, height = 300)),
                  tabPanel("Sentiment", plotOutput("sentiment", width = 600, height = 300),
                           plotOutput("sentimentb", width = 600, height = 300))
      )
      
    )
  )
)
