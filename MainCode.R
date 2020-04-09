this is a test
asdgfg
dfs
gsdf
gsd
fg
<<<<<<< HEAD
=======
Steven's test'
>>>>>>> 44e59317fb73197472fc3fa8d34e7b4645379385

Test - Stuart

#Creating working data frame from API

#Market Open Dataframe
DailyOpen <- data.frame(Materials$XLB.Open, Communications$XLC.Open, Energy$XLE.Open, Financials$XLF.Open, Industrials$XLI.Open, Technology$XLK.Open, ConsumerStaples$XLP.Open, RealEstate$XLRE.Open, Utilities$XLU.Open, HealthCare$XLV.Open, ConsumerDiscretionary$XLY.Open)
DailyClose <- data.frame(Materials$XLB.Adjusted, Communications$XLC.Adjusted, Energy$XLE.Adjusted, Financials$XLF.Adjusted, Industrials$XLI.Adjusted, Technology$XLK.Adjusted, ConsumerStaples$XLP.Adjusted, RealEstate$XLRE.Adjusted, Utilities$XLU.Adjusted, HealthCare$XLV.Adjusted, ConsumerDiscretionary$XLY.Adjusted)
DailyLow <- data.frame(Materials$XLB.Low, Communications$XLC.Low, Energy$XLE.Low, Financials$XLF.Low, Industrials$XLI.Low, Technology$XLK.Low, ConsumerStaples$XLP.Low, RealEstate$XLRE.Low, Utilities$XLU.Low, HealthCare$XLV.Low, ConsumerDiscretionary$XLY.Low)
DailyHigh <- data.frame(Materials$XLB.High, Communications$XLC.High, Energy$XLE.High, Financials$XLF.High, Industrials$XLI.High, Technology$XLK.High, ConsumerStaples$XLP.High, RealEstate$XLRE.High, Utilities$XLU.High, HealthCare$XLV.High, ConsumerDiscretionary$XLY.High)
DailyVolume <- data.frame(Materials$XLB.Volume, Communications$XLC.Volume, Energy$XLE.Volume, Financials$XLF.Volume, Industrials$XLI.Volume, Technology$XLK.Volume, ConsumerStaples$XLP.Volume, RealEstate$XLRE.Volume, Utilities$XLU.Volume, HealthCare$XLV.Volume, ConsumerDiscretionary$XLY.Volume)

#Creation of daily change and range datasets

#Function for finding the difference between two dataframes
difference <- function(input_1, input_2){
  return (input_2-input_1)
}

#Daily change = Close - Open
DailyChange <- difference(DailyOpen, DailyClose)

#Daily range = High - Low
DailyRange <- difference(DailyLow, DailyHigh)

#Z-score function (to be used for normalizing data)
zscore <- function( input_1 ){
  return ((x-mean(x))/sd(x))
}


#Libraries needed for shiny
library(shiny)
library(shinythemes)
library(dplyr)
library(readr)

#Defining the server
server <- function( input, output ){
  
}