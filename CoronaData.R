#install.packages("RCurl")
library (RCurl)

#install.packages("dplyr")
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




