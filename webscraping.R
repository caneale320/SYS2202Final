#install.packages("rvest")
library(rvest)

#Scrape the main head and paragraph text/comments of a single Reddit page

#Scrape the time and URL of all latest pages published on Reddit's r/Coronavirus
#Get r/news
reddit_wbpg <- read_html("https://www.reddit.com/r/Coronavirus/")

#Get time  
time <- reddit_wbpg %>%
  html_nodes("a._3jOxDPIQ0KaOWpzvSQo-1s") %>%
  html_text()

#Get urls
urls <- reddit_wbpg %>%
  html_nodes("a._3jOxDPIQ0KaOWpzvSQo-1s") %>%
  html_attr("href")

#Create a dataframe of news pages and their published time
reddit_newspgs_times <- data.frame(NewsPage=urls, PublishedTime=time)

#Filter dataframe by only daily content (keyword: minute, now, hour)
reddit_recent_data <- reddit_newspgs_times[grep("hour|minute|now", reddit_newspgs_times$PublishedTime),]

#Loop through urls, grab the main title and comments,
#assign the comments to their corresponding news page, and create a dataframe

titles <- c()
comments <- c()
for(i in reddit_recent_data$NewsPage){ 
  
  reddit_recent_data <- read_html(i)
  body <- reddit_recent_data %>%
    html_nodes("p._1qeIAgB0cPwnLhDF9XSiJM") %>%
    html_text()
  comments = append(comments, body)
  
  reddit_recent_data <- read_html(i)
  title <- reddit_recent_data %>%
    html_node("title") %>%
    html_text()
  titles = append(titles, rep(title,each=length(body)))
}
#dataframe  of titles and its comments 
reddit_hourly_data <- data.frame(Headline=titles, Comments=comments)
dim(reddit_hourly_data)
head(reddit_hourly_data$Comments)


# Remove disclaimer comments included in all pages so this doesn't flood the comments and skew results
disclaimers <- c(
  "As a reminder, this subreddit is for civil discussion.",
  "In general, be courteous to others. Attack ideas, not users. Personal insults, shill or troll accusations, hate speech, any advocating or wishing death/physical harm, and other rule violations can result in a permanent ban.",
  "If you see comments in violation of our rules, please report them.",
  "I am a bot, and this action was performed automatically. Please contact the moderators of this subreddit if you have any questions or concerns."
  
)

reddit_hourly_data_no_disclaimers <- subset(
  reddit_hourly_data, !(Comments %in% c(disclaimers))
)

dim(reddit_hourly_data_no_disclaimers)
head(reddit_hourly_data_no_disclaimers$Comments)


# Score the overall sentiment of each comment
# This library scores sentiment by taking into account the whole sentence
# It takes into account surrounding words of a target word such as 'not happy'
# which cancels out positive sentiment
# A negative value means sentiment is more negative than positive
# A positive values means the sentiment is more positive than negative
#install.packages('sentimentr')
library(sentimentr)

# Comment out this line so it does not cause errors when scheduling to run the script
#sentiment(reddit_hourly_data_no_disclaimers$Comments)

# Treat comments as characters, not factors
# Convert to a format sentiment() function accepts
reddit_hourly_data_no_disclaimers$Comments <- as.character(reddit_hourly_data_no_disclaimers$Comments)
reddit_hourly_data_no_disclaimers$Headline <- as.character(reddit_hourly_data_no_disclaimers$Headline)

sentiment_scores <- sentiment(reddit_hourly_data_no_disclaimers$Comments)
head(sentiment_scores)

sentiment_scores_title <- sentiment(reddit_hourly_data_no_disclaimers$Headline)
head(sentiment_scores_title)

# Average the scores across all comments
#average_sentiment_score <- sum(sentiment_scores$sentiment)/length(sentiment_scores$sentiment)
#current_time <- Sys.time()

#Date range as of date written 4/11: 4/06 - 4/11
head(marketwatch_df)
tail(marketwatch_df)


sentiment_df = rbind(sentiment_scores, )





