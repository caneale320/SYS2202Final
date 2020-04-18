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

#STREAM TWEETS WITH: USER: KEYWORD: coronavirus LOCATION: usa LANGUAGE: english
rt <- stream_tweets("coronavirus", timeout = 30, "lang:en")


rt_df <- data.frame(rt$created_at,rt$text)
