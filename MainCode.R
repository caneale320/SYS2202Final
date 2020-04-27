#Main 

#install.packages("shiny")
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
  return (as.numeric(as.character(input_2))-as.numeric(as.character(input_1)))
}

#Daily change = Close - Open
DailyChange <- difference(DailyOpen, DailyClose)

#Daily range = High - Low
DailyRange <- difference(DailyLow, DailyHigh)

#Z-score function (to be used for normalizing data)
zscore <- function( input_1 ){
  return ((input_1-mean(input_1))/sd(input_1))
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

CleanMaterials <- data.frame(row.names(Materials), Materials$XLB.Adjusted, zscore(DailyChange$Materials), zscore(DailyRange$Materials), zscore(DailyVolume$Materials))
CleanCommunications <- data.frame(row.names(Communications), Communications$XLC.Adjusted, zscore(DailyChange$Communications), zscore(DailyRange$Communications), zscore(DailyVolume$Communications))
CleanConsumerDiscretionary <- data.frame(row.names(ConsumerDiscretionary), ConsumerDiscretionary$XLY.Adjusted, zscore(DailyChange$ConsumerDiscretionary), zscore(DailyRange$ConsumerDiscretionary), zscore(DailyVolume$ConsumerDiscretionary))
CleanConsumerStaples <- data.frame(row.names(ConsumerStaples), ConsumerStaples$XLP.Adjusted, zscore(DailyChange$ConsumerStaples), zscore(DailyRange$ConsumerStaples), zscore(DailyVolume$ConsumerStaples))
CleanTechnology <- data.frame(row.names(Technology), Technology$XLK.Adjusted, zscore(DailyChange$Technology), zscore(DailyRange$Technology), zscore(DailyVolume$Technology))
CleanUtilities <- data.frame(row.names(Utilities), Utilities$XLU.Adjusted, zscore(DailyChange$Utilities), zscore(DailyRange$Utilities), zscore(DailyVolume$Utilities))
CleanRealEstate <- data.frame(row.names(RealEstate), RealEstate$XLRE.Adjusted, zscore(DailyChange$RealEstate), zscore(DailyRange$RealEstate), zscore(DailyVolume$RealEstate))
CleanHealthCare <- data.frame(row.names(HealthCare), HealthCare$XLV.Adjusted, zscore(DailyChange$HealthCare), zscore(DailyRange$HealthCare), zscore(DailyVolume$HealthCare))
CleanFinancials <- data.frame(row.names(Financials), Financials$XLF.Adjusted, zscore(DailyChange$Financials), zscore(DailyRange$Financials), zscore(DailyVolume$Financials))
CleanEnergy <- data.frame(row.names(Energy), Energy$XLE.Adjusted, zscore(DailyChange$Energy), zscore(DailyRange$Energy), zscore(DailyVolume$Energy))
CleanIndustrials <- data.frame(row.names(Industrials), Industrials$XLI.Adjusted, zscore(DailyChange$Industrials), zscore(DailyRange$Industrials), zscore(DailyVolume$Industrials))

dates <- data.frame(CleanCommunications$row.names.Communications.)


#Libraries needed for shiny
library(shiny)
library(shinythemes)
library(dplyr)
library(readr)

#Defining the server
server <- function( input, output ){
  
}
# -----------------------------------------------------------------------


GlobalCasesByDay <- merge(dates, GlobalCasesByDay, by.x = 1, by.y = 1, all.x = TRUE)
GlobalCasesByDay[is.na(GlobalCasesByDay)] <- 0

GlobalDeathsByDay <- merge(dates, GlobalDeathsByDay, by.x = 1, by.y = 1, all.x = TRUE)
GlobalDeathsByDay[is.na(GlobalDeathsByDay)] <- 0

USCasesByDay <- merge(dates, USCasesByDay, by.x = 1, by.y = 1, all.x = TRUE)
USCasesByDay[is.na(USCasesByDay)] <- 0

USDeathsByDay <- merge(dates, USDeathsByDay, by.x = 1, by.y = 1, all.x = TRUE)
USDeathsByDay[is.na(USDeathsByDay)] <- 0

