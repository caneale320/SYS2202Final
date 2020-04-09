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
