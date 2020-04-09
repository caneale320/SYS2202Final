install.packages("quantmod")
install.packages("rtsdata")

library(quantmod)
library(rtsdata)

createDF <- function(symbols){
  for(item in symbols){
    df = data.frame(ds.getSymbol.yahoo(item, from = "1900-01-01", to = Sys.Date()))
    
    arg_name <- deparse(substitute(item)) # Get argument name
    var_name <- paste("df", arg_name, sep=".") # Construct the name
    assign(var_name, df, env=.GlobalEnv) # Assign values to variable
    # variable will be created in .GlobalEnv 
  }
}

symbolsList = c("XLB", "XLC", "XLE", "XLF", "XLI", "XLK", "XLP", "XLRE", "XLU", "XLV", "XLY")

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
