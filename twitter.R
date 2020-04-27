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
View(coronavirus_sentiment_scores)
View(marketwatch_sentiment_scores)

#Date range as of date written 4/11: 4/06 - 4/11
head(marketwatch_df)
tail(marketwatch_df)

head(coronavirus_df)
tail(coronavirus_df)

View(coronavirus_sentiment_scores)

#Create a dataframe of the average sentiment score of each tweet
coronavirus_average_sentiment <- coronavirus_sentiment_scores[,.(sentiment_averaged = sum(sentiment)),by=element_id]
marketwatch_average_sentiment <- marketwatch_sentiment_scores[,.(sentiment_averaged = sum(sentiment)),by=element_id]

View(marketwatch_df)

#Add Datetime of each tweet 
marketwatch_average_sentiment <- cbind(marketwatch_average_sentiment,PublishedTime=marketwatch_df$PublishedTime)
coronavirus_average_sentiment <- cbind(coronavirus_average_sentiment,PublishedTime=coronavirus_df$PublishedTime)

head(coronavirus_average_sentiment)
tail(coronavirus_average_sentiment)

head(marketwatch_average_sentiment)
tail(marketwatch_average_sentiment)

#Plot 
ggplot(coronavirus_average_sentiment) + 
  geom_smooth(aes(PublishedTime,sentiment_averaged)) 
 ggplot(marketwatch_average_sentiment) + 
  geom_smooth(aes(PublishedTime,sentiment_averaged))



