covid_facts <- function(region) {
  confirmed <- read.csv("time_series_covid19_confirmed_global.csv")
  recovered <- read.csv("time_series_covid19_recovered_global.csv")
  deaths <- read.csv("time_series_covid19_deaths_global.csv")
  
  dates <- colnames(deaths)
  dates <- sub("^X", "", dates)

  confirmed <- confirmed[confirmed$Country.Region == region,]
  recovered <- recovered[recovered$Country.Region == region,]
  deaths <- deaths[deaths$Country.Region == region,]

  confirmed <- strtoi(t(confirmed)[5:length(confirmed)])
  recovered <- strtoi(t(recovered)[5:length(recovered)])
  deaths <- strtoi(t(deaths)[5:length(deaths)])
  dates <- t(dates)[5:length(dates)]

  cases <- data.frame(
    Date = cbind(dates),
    Confirmed = cbind(confirmed),
    Recovered = cbind(recovered),
    Deaths = cbind(deaths)
  )

  file <- paste(tolower(region), 'Cases.csv', sep="")
  print(file)
  write.csv(cases, file)
}

covid_facts('Germany')