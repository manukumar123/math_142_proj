covid_facts <- function(region) {
  confirmed <- read.csv("time_series_covid19_confirmed_global.csv")
  recovered <- read.csv("time_series_covid19_recovered_global.csv")
  deaths <- read.csv("time_series_covid19_deaths_global.csv")
  vaccines <- read.csv("cumulative-covid-vaccinations.csv")

  dates <- colnames(deaths)
  dates <- sub("^X", "", dates)

  confirmed <- confirmed[confirmed$Country.Region == region, ]
  recovered <- recovered[recovered$Country.Region == region, ]
  deaths <- deaths[deaths$Country.Region == region, ]
  vaccines <- vaccines[vaccines$Entity == region, ]
  vaccines$Day <- as.character(vaccines$Day)

  confirmed <- strtoi(t(confirmed)[5:length(confirmed)])
  recovered <- strtoi(t(recovered)[5:length(recovered)])
  deaths <- strtoi(t(deaths)[5:length(deaths)])
  reinfection <- floor(0.04 * recovered)
  dates <- t(dates)[5:length(dates)]
  dates <- as.character(
    as.Date(dates,
      format = "%m.%d.%y"
    )
  )

  vaccines_adm <- numeric(length = length(confirmed))

  j <- 1
  for (i in seq_len(length(dates))) {
    if (dates[i] %in% vaccines$Day) {
      vaccines_adm[i] <- vaccines$total_vaccinations[j]
      j <- j + 1
    } else {
      vaccines_adm[i] <- 0
    }
  }

  cases <- data.frame(
    Date = cbind(dates),
    Confirmed = cbind(confirmed),
    Recovered = cbind(recovered),
    Deaths = cbind(deaths),
    Reinfection = cbind(reinfection),
    Vaccinations_administered = cbind(vaccines_adm)
  )

  file <- paste(tolower(region), "Cases.csv", sep = "")
  print(file)
  write.csv(cases, file)
}

covid_facts("Germany")