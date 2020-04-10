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

