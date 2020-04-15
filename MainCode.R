#Main 


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

#Renaming Daily Change Columns
names(DailyChange)[1] <- "Materials"
names(DailyChange)[2] <- "Communications"
names(DailyChange)[3] <- "Energy"
names(DailyChange)[4] <- "Financials"
names(DailyChange)[5] <- "Industrials"
names(DailyChange)[6] <- "Technology"
names(DailyChange)[7] <- "ConsumerStaples"
names(DailyChange)[8] <- "RealEstate"
names(DailyChange)[9] <- "Utilities"
names(DailyChange)[10] <- "HealthCare"
names(DailyChange)[11] <- "ConsumerDiscretionary"

#Renaming daily range columns
names(DailyRange)[1] <- "Materials"
names(DailyRange)[2] <- "Communications"
names(DailyRange)[3] <- "Energy"
names(DailyRange)[4] <- "Financials"
names(DailyRange)[5] <- "Industrials"
names(DailyRange)[6] <- "Technology"
names(DailyRange)[7] <- "ConsumerStaples"
names(DailyRange)[8] <- "RealEstate"
names(DailyRange)[9] <- "Utilities"
names(DailyRange)[10] <- "HealthCare"
names(DailyRange)[11] <- "ConsumerDiscretionary"

#Renaming daily volume columns
names(DailyVolume)[1] <- "Materials"
names(DailyVolume)[2] <- "Communications"
names(DailyVolume)[3] <- "Energy"
names(DailyVolume)[4] <- "Financials"
names(DailyVolume)[5] <- "Industrials"
names(DailyVolume)[6] <- "Technology"
names(DailyVolume)[7] <- "ConsumerStaples"
names(DailyVolume)[8] <- "RealEstate"
names(DailyVolume)[9] <- "Utilities"
names(DailyVolume)[10] <- "HealthCare"
names(DailyVolume)[11] <- "ConsumerDiscretionary"

#Normalizing Daily Change
NormalizedChange <- zscore(DailyChange)

#Normalizing Daily Range
NormalizedRange <- zscore(DailyRange)

#Normalizing Daily Volume
NormalizedVolume <- zscore(DailyVolume)


#Libraries needed for shiny
library(shiny)
library(shinythemes)
library(dplyr)
library(readr)

#Defining the server
server <- function( input, output ){
  
}