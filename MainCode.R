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


#Libraries needed for shiny
library(shiny)
library(shinythemes)
library(dplyr)
library(readr)

#Defining the server
server <- function( input, output ){
  
}
# -----------------------------------------------------------------------

# cleaning covid data

# converting the number of cases (value column) to a numeric value
GlobalCovidCases <- transform(GlobalCovidCases, Value = as.numeric(Value))

# summing the number of cases (value) by day using the aggregate function
GlobalCasesByDay <- aggregate(GlobalCovidCases$Value, by=list(Date=GlobalCovidCases$Date), FUN=sum)

# creating a temporary df to store the daily changes, daily changes calculated by subtracting offset slices of the original dataframe
temp <- (tail(GlobalCasesByDay, -1) - head(GlobalCasesByDay, -1))
# adding a row of NA to make the temp DF the same length as the original
temp <- rbind(c(NA, NA), temp)

# assigning the tempory dataframe to the daily change column in the main covid deaths df
GlobalCasesByDay$DailyChange <- temp$x


# repeating the above process for US covid cases and deaths, as well as global cases. 
GlobalCovidDeaths <- transform(GlobalCovidDeaths, Value = as.numeric(Value))
GlobalDeathsByDay <- aggregate(GlobalCovidDeaths$Value, by=list(Date=GlobalCovidDeaths$Date), FUN=sum)

temp <- (tail(GlobalDeathsByDay, -1) - head(GlobalDeathsByDay, -1))
temp <- rbind(c(NA, NA), temp)

GlobalDeathsByDay$DailyChange <- temp$x

UScovidCases <- transform(UScovidCases, Value = as.numeric(Value))
USCasesByDay <- aggregate(UScovidCases$Value, by=list(Date=UScovidCases$Date), FUN=sum)

temp <- (tail(USCasesByDay, -1) - head(USCasesByDay, -1))
temp <- rbind(c(NA, NA), temp)

USCasesByDay$DailyChange <- temp$x


UScovidDeaths <- transform(UScovidDeaths, Value = as.numeric(Value))
USDeathsByDay <- aggregate(UScovidDeaths$Value, by=list(Date=UScovidDeaths$Date), FUN=sum)

temp <- (tail(USDeathsByDay, -1) - head(USDeathsByDay, -1))
temp <- rbind(c(NA, NA), temp)

USDeathsByDay$DailyChange <- temp$x

