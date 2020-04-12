##Packages needed: httpuv, rtweet
if (!requireNamespace("httpuv", quietly = TRUE)) {
  install.packages("httpuv")
}
if (!requireNamespace("rtweet", quietly = TRUE)) {
  install.packages("rtweet")
}

#load packages
library(rtweet)
library(httpuv)
library(ggplot2)
library(dplyr)
library(tidytext)
library(sentimentr)
library(tidyverse)

#store api keys
api_key <- "p04GAo8bI83sitlG7eGCYYjhp"
api_scret_key <- "XRtlRUD3cFUJmJ5NIiQ5YRp4WFLKnmoJ9N82wzITAMFABQbhYF"

#authenticate via web 
token <- create_token(
  app="Sowoko Waterp",
  consumer_key=api_key,
  consumer_secret = api_scret_key
)

#search for 500 tweets using the #coronavirus hashtag in the us
usa <- lookup_coords("usa")
coronavirus_tweets <- search_tweets(q="#coronavirus",n=500,geocode = usa)
marketwatch_tweets <- get_timeline("marketwatch",n=500)

#Create a dataframe 
coronavirus_df <-  data.frame(PublishedTime=coronavirus_tweets$created_at, Text=coronavirus_tweets$text)
marketwatch_df <-  data.frame(PublishedTime=marketwatch_tweets$created_at, Text=marketwatch_tweets$text)

#apply sentiment 
coronavirus_df$Text <- as.character(coronavirus_df$Text)
marketwatch_df$Text <- as.character(marketwatch_df$Text)

#Create a dataframe of the sentiment results of #coronavirus 
coronavirus_sentiment_scores <- sentiment(coronavirus_df$Text)

#View the result
View(coronavirus_sentiment_scores)

temarketwatch_sentiment_scores <- sentiment(marketwatch_df$Text)
View(marketwatch_sentiment_scores)

#marketsubset <- subset(marketwatch_sentiment_scores,,select= which(c(TRUE,(df[which(marketwatch_sentiment_scores$sentence_id),]==1)[4:5])))


#marketwatch_df <-  data.frame(PublishedTime=marketwatch_tweets$created_at, 
                             # Text=marketwatch_tweets$text,
                              #Sentiment=marketwatch_sentiment_scores$sentiment)

