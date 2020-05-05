install.packages("quantmod")
install.packages("rtsdata")
install.packages("RCurl")
install.packages("dplyr")
install.packages("shiny")


# importing necessary packages for pulling data
library(quantmod)
library(rtsdata)

# function to create dataframes for each sector etf
createDF <- function(symbols){
  for(item in symbols){
    df = data.frame(ds.getSymbol.yahoo(item, from = "2019-12-1", to = Sys.Date())) # creates dataframe with data from the range [from, to]
    arg_name <- deparse(substitute(item)) # Get argument name from etf/stock symbol
    var_name <- paste("df", arg_name, sep=".") # Constructs df name
    df$date = row.names(df)
    assign(var_name, df, env=.GlobalEnv) # assigns dataframe symbol name
    # variable will be created in .GlobalEnv 
  }
}


# list of etfs
symbolsList = c("XLB", "XLC", "XLE", "XLF", "XLI", "XLK", "XLP", "XLRE", "XLU", "XLV", "XLY")

# creates dataframes for each etf
createDF(symbolsList)

#Renaming DF for easier referencing
Materials <- `df."XLB"`
Communications <- `df."XLC"`
Energy <- `df."XLE"`
Financials <- `df."XLF"`
Industrials <- `df."XLI"`
Technology <- `df."XLK"`
ConsumerStaples <- `df."XLP"`
RealEstate <- `df."XLRE"`
Utilities <- `df."XLU"`
HealthCare <- `df."XLV"`
ConsumerDiscretionary <- `df."XLY"`

#-------------------------------------------------------------------------------------------

library (RCurl)

library(dplyr)

# download global covid cases data
download3 <- getURL("https://data.humdata.org/hxlproxy/data/download/time_series_covid19_confirmed_global_narrow.csv?dest=data_edit&filter01=merge&merge-url01=https%3A%2F%2Fdocs.google.com%2Fspreadsheets%2Fd%2Fe%2F2PACX-1vTglKQRXpkKSErDiWG6ycqEth32MY0reMuVGhaslImLjfuLU0EUgyyu2e-3vKDArjqGX7dXEBV8FJ4f%2Fpub%3Fgid%3D1326629740%26single%3Dtrue%26output%3Dcsv&merge-keys01=%23country%2Bname&merge-tags01=%23country%2Bcode%2C%23region%2Bmain%2Bcode%2C%23region%2Bsub%2Bcode%2C%23region%2Bintermediate%2Bcode&filter02=merge&merge-url02=https%3A%2F%2Fdocs.google.com%2Fspreadsheets%2Fd%2Fe%2F2PACX-1vTglKQRXpkKSErDiWG6ycqEth32MY0reMuVGhaslImLjfuLU0EUgyyu2e-3vKDArjqGX7dXEBV8FJ4f%2Fpub%3Fgid%3D398158223%26single%3Dtrue%26output%3Dcsv&merge-keys02=%23adm1%2Bname&merge-tags02=%23country%2Bcode%2C%23region%2Bmain%2Bcode%2C%23region%2Bsub%2Bcode%2C%23region%2Bintermediate%2Bcode&merge-replace02=on&merge-overwrite02=on&filter03=explode&explode-header-att03=date&explode-value-att03=value&filter04=rename&rename-oldtag04=%23affected%2Bdate&rename-newtag04=%23date&rename-header04=Date&filter05=rename&rename-oldtag05=%23affected%2Bvalue&rename-newtag05=%23affected%2Binfected%2Bvalue%2Bnum&rename-header05=Value&filter06=clean&clean-date-tags06=%23date&filter07=sort&sort-tags07=%23date&sort-reverse07=on&filter08=sort&sort-tags08=%23country%2Bname%2C%23adm1%2Bname&tagger-match-all=on&tagger-default-tag=%23affected%2Blabel&tagger-01-header=province%2Fstate&tagger-01-tag=%23adm1%2Bname&tagger-02-header=country%2Fregion&tagger-02-tag=%23country%2Bname&tagger-03-header=lat&tagger-03-tag=%23geo%2Blat&tagger-04-header=long&tagger-04-tag=%23geo%2Blon&header-row=1&url=https%3A%2F%2Fraw.githubusercontent.com%2FCSSEGISandData%2FCOVID-19%2Fmaster%2Fcsse_covid_19_data%2Fcsse_covid_19_time_series%2Ftime_series_covid19_confirmed_global.csv")
# store as df
GlobalCovidCases <- read.csv (text = download3)

# download global covid deaths data
download4 <- getURL("https://data.humdata.org/hxlproxy/data/download/time_series_covid19_deaths_global_narrow.csv?dest=data_edit&filter01=merge&merge-url01=https%3A%2F%2Fdocs.google.com%2Fspreadsheets%2Fd%2Fe%2F2PACX-1vTglKQRXpkKSErDiWG6ycqEth32MY0reMuVGhaslImLjfuLU0EUgyyu2e-3vKDArjqGX7dXEBV8FJ4f%2Fpub%3Fgid%3D1326629740%26single%3Dtrue%26output%3Dcsv&merge-keys01=%23country%2Bname&merge-tags01=%23country%2Bcode%2C%23region%2Bmain%2Bcode%2C%23region%2Bsub%2Bcode%2C%23region%2Bintermediate%2Bcode&filter02=merge&merge-url02=https%3A%2F%2Fdocs.google.com%2Fspreadsheets%2Fd%2Fe%2F2PACX-1vTglKQRXpkKSErDiWG6ycqEth32MY0reMuVGhaslImLjfuLU0EUgyyu2e-3vKDArjqGX7dXEBV8FJ4f%2Fpub%3Fgid%3D398158223%26single%3Dtrue%26output%3Dcsv&merge-keys02=%23adm1%2Bname&merge-tags02=%23country%2Bcode%2C%23region%2Bmain%2Bcode%2C%23region%2Bsub%2Bcode%2C%23region%2Bintermediate%2Bcode&merge-replace02=on&merge-overwrite02=on&filter03=explode&explode-header-att03=date&explode-value-att03=value&filter04=rename&rename-oldtag04=%23affected%2Bdate&rename-newtag04=%23date&rename-header04=Date&filter05=rename&rename-oldtag05=%23affected%2Bvalue&rename-newtag05=%23affected%2Binfected%2Bvalue%2Bnum&rename-header05=Value&filter06=clean&clean-date-tags06=%23date&filter07=sort&sort-tags07=%23date&sort-reverse07=on&filter08=sort&sort-tags08=%23country%2Bname%2C%23adm1%2Bname&tagger-match-all=on&tagger-default-tag=%23affected%2Blabel&tagger-01-header=province%2Fstate&tagger-01-tag=%23adm1%2Bname&tagger-02-header=country%2Fregion&tagger-02-tag=%23country%2Bname&tagger-03-header=lat&tagger-03-tag=%23geo%2Blat&tagger-04-header=long&tagger-04-tag=%23geo%2Blon&header-row=1&url=https%3A%2F%2Fraw.githubusercontent.com%2FCSSEGISandData%2FCOVID-19%2Fmaster%2Fcsse_covid_19_data%2Fcsse_covid_19_time_series%2Ftime_series_covid19_deaths_global.csv")
# store as df
GlobalCovidDeaths <- read.csv (text = download4)

# subsetting US data
UScovidCases = subset(GlobalCovidCases, Country.Region == "US")
UScovidDeaths = subset(GlobalCovidDeaths, Country.Region == "US")

#Removing unnecessary columns from Covid Cases Data
GlobalCovidCases <- select(GlobalCovidCases, c(Date, Country.Region, Value))
GlobalCovidDeaths <- select(GlobalCovidDeaths, c(Date, Country.Region, Value))
UScovidCases <- select(UScovidCases, c(Date, Country.Region, Value))
UScovidDeaths <- select(UScovidDeaths, c(Date, Country.Region, Value))


# cleaning covid data

# converting the number of cases (value column) to a numeric value
GlobalCovidCases <- transform(GlobalCovidCases, Value = as.numeric(as.character(Value)))

# summing the number of cases (value) by day using the aggregate function
GlobalCasesByDay <- aggregate(GlobalCovidCases$Value, by=list(Date=GlobalCovidCases$Date), FUN=sum)

# creating a temporary df to store the daily changes, daily changes calculated by subtracting offset slices of the original dataframe
temp <- (tail(GlobalCasesByDay, -1) - head(GlobalCasesByDay, -1))
# adding a row of NA to make the temp DF the same length as the original
temp <- rbind(c(NA, NA), temp)

# assigning the tempory dataframe to the daily change column in the main covid deaths df
GlobalCasesByDay$DailyChange <- temp$x


# repeating the above process for US covid cases and deaths, as well as global cases. 
GlobalCovidDeaths <- transform(GlobalCovidDeaths, Value = as.numeric(as.character(Value)))
GlobalDeathsByDay <- aggregate(GlobalCovidDeaths$Value, by=list(Date=GlobalCovidDeaths$Date), FUN=sum)

temp <- (tail(GlobalDeathsByDay, -1) - head(GlobalDeathsByDay, -1))
temp <- rbind(c(NA, NA), temp)

GlobalDeathsByDay$DailyChange <- temp$x

UScovidCases <- transform(UScovidCases, Value = as.numeric(as.character(Value)))
USCasesByDay <- aggregate(UScovidCases$Value, by=list(Date=UScovidCases$Date), FUN=sum)

temp <- (tail(USCasesByDay, -1) - head(USCasesByDay, -1))
temp <- rbind(c(NA, NA), temp)

USCasesByDay$DailyChange <- temp$x


UScovidDeaths <- transform(UScovidDeaths, Value = as.numeric(as.character(Value)))
USDeathsByDay <- aggregate(UScovidDeaths$Value, by=list(Date=UScovidDeaths$Date), FUN=sum)

temp <- (tail(USDeathsByDay, -1) - head(USDeathsByDay, -1))
temp <- rbind(c(NA, NA), temp)

USDeathsByDay$DailyChange <- temp$x

#---------------------------------------------------------------------------------------------------------

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


# -----------------------------------------------------------------------


GlobalCasesByDay <- merge(dates, GlobalCasesByDay, by.x = 1, by.y = 1, all.x = TRUE)
GlobalCasesByDay[is.na(GlobalCasesByDay)] <- 0

GlobalDeathsByDay <- merge(dates, GlobalDeathsByDay, by.x = 1, by.y = 1, all.x = TRUE)
GlobalDeathsByDay[is.na(GlobalDeathsByDay)] <- 0

USCasesByDay <- merge(dates, USCasesByDay, by.x = 1, by.y = 1, all.x = TRUE)
USCasesByDay[is.na(USCasesByDay)] <- 0

USDeathsByDay <- merge(dates, USDeathsByDay, by.x = 1, by.y = 1, all.x = TRUE)
USDeathsByDay[is.na(USDeathsByDay)] <- 0

# ----------------------------------------------------------------------------

#load packages
library(rtweet) #access tweets
library(httpuv) #handle http requests within r
library(tidytext) #text mining for word processing and sentiment analysis
library(sentimentr) #calculate text polarity sentiment at the sentence level
library(tidyverse) #ggplot2, dplyr


#Preprocessing: Connect to Twitter API to access dataframe
#store api keys
api_key <- "p04GAo8bI83sitlG7eGCYYjhp"
api_scret_key <- "XRtlRUD3cFUJmJ5NIiQ5YRp4WFLKnmoJ9N82wzITAMFABQbhYF"

#authenticate via web 
token <- create_token(
  app="Sowoko Water",
  consumer_key=api_key,
  consumer_secret = api_scret_key
)

#search for 16000 tweets using the #coronavirus hashtag in the us
usa <- lookup_coords("usa")
coronavirus_tweets <- search_tweets(q="coronavirus",n=16000,geocode = usa)
marketwatch_tweets <- get_timeline("marketwatch",n=16000)


#Create a dataframe 
coronavirus_df <-  data.frame(PublishedTime=coronavirus_tweets$created_at, Text=coronavirus_tweets$text)
marketwatch_df <-  data.frame(PublishedTime=marketwatch_tweets$created_at, Text=marketwatch_tweets$text)


#Processing: apply sentimentr package
#Preprocess: text to character function
coronavirus_df$Text <- as.character(coronavirus_df$Text)
marketwatch_df$Text <- as.character(marketwatch_df$Text)
#apply sentiment 
#Create a dataframe of the sentiment results of #coronavirus 
coronavirus_sentiment_scores <- sentiment(coronavirus_df$Text)
marketwatch_sentiment_scores <- sentiment(marketwatch_df$Text)

#View the result
#View(coronavirus_sentiment_scores)
#View(marketwatch_sentiment_scores)

#Date range as of date written 4/11: 4/06 - 4/11
#head(marketwatch_df)
#tail(marketwatch_df)

#head(coronavirus_df)
#tail(coronavirus_df)

#View(coronavirus_sentiment_scores)

#Create a dataframe of the average sentiment score of each tweet
coronavirus_average_sentiment <- coronavirus_sentiment_scores[,.(sentiment_averaged = sum(sentiment)),by=element_id]
marketwatch_average_sentiment <- marketwatch_sentiment_scores[,.(sentiment_averaged = sum(sentiment)),by=element_id]

#View(marketwatch_df)

#Add Datetime of each tweet 
marketwatch_average_sentiment <- cbind(marketwatch_average_sentiment,PublishedTime=marketwatch_df$PublishedTime)
coronavirus_average_sentiment <- cbind(coronavirus_average_sentiment,PublishedTime=coronavirus_df$PublishedTime)

#head(coronavirus_average_sentiment)
#tail(coronavirus_average_sentiment)

#head(marketwatch_average_sentiment)
#tail(marketwatch_average_sentiment)

#Plot 
ggplot(coronavirus_average_sentiment) + 
  geom_smooth(aes(PublishedTime,sentiment_averaged)) 
ggplot(marketwatch_average_sentiment) + 
  geom_smooth(aes(PublishedTime,sentiment_averaged))




