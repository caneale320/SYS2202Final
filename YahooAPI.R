install.packages("quantmod")
install.packages("rtsdata")

# importing necessary packages for pulling data
library(quantmod)
library(rtsdata)

# function to create dataframes for each sector etf
createDF <- function(symbols){
  for(item in symbols){
    df = data.frame(ds.getSymbol.yahoo(item, from = "2019-1-1", to = Sys.Date())) # creates dataframe with data from the range [from, to]
    arg_name <- deparse(substitute(item)) # Get argument name from etf/stock symbol
    var_name <- paste("df", arg_name, sep=".") # Constructs df name
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
<<<<<<< HEAD

#Trimming data to include only entries from January 1, 2019
Materials <- subset(Materials, row.names(Materials) >= "2019-01-01")
Communications <- subset(Communications, row.names(Communications) >= "2019-01-01")
Energy <- subset(Energy, row.names(Energy) >= "2019-01-01")
Financials <- subset(Financials, row.names(Financials) >= "2019-01-01")
Industrials <- subset(Industrials, row.names(Industrials) >= "2019-01-01")
Technology <- subset(Technology, row.names(Technology) >= "2019-01-01")
ConsumerStaples <- subset(ConsumerStaples, row.names(ConsumerStaples) >= "2019-01-01")
RealEstate <- subset(RealEstate, row.names(RealEstate) >= "2019-01-01")
Utilities <- subset(Utilities, row.names(Utilities) >= "2019-01-01")
HealthCare <- subset(HealthCare, row.names(HealthCare) >= "2019-01-01")
ConsumerDiscretionary <- subset(ConsumerDiscretionary, row.names(ConsumerDiscretionary) >= "2019-01-01")

=======
>>>>>>> 57656dd55e56f845e80a795be09b97c7a71b2be8
