#### Preamble ####
# Purpose: Cleans the raw data that was obtain from IPUMS
# Author: Sachin Chhikara
# Date: 10 March 2024 
# Contact: sachin.chhikara@utoronto.ca 
# License: MIT
# Pre-requisites:
# Makes sure to download usa_00001.xml and usa_00001.dat into data/raw_data/.
# For information on how to do this check on the readme file.
 

#### Workspace setup ####
library(tidyverse)
library(arrow)
library(ipumsr)

#### Clean data ####
ddi <- read_ipums_ddi("data/raw_data/usa_00001.xml")
raw_data_IPUMS <- read_ipums_micro(ddi)


create_mapping <- function(table) {
  # Initialize an empty named vector for mapping
  mapping <- c()
  
  # Loop through each row of the table and construct the mapping
  for (i in 1:nrow(table)) {
    mapping[table$val[i]] <- table$lbl[i]
  }
  
  # Return the named vector
  return(mapping)
}

map_hisp <- function(hisp) {
  case_when(
    hisp == 0 ~ "No",
    hisp %in% c(1, 2, 3, 4) ~ "Yes",
    TRUE ~ NA_character_  # Catch-all for other cases
  )
}

map_education <- function(educ) {
  case_when(
    educ %in% c(0, 1, 2, 4, 5) ~ "No high school diploma",
    educ == 6 ~ "High school graduate (includes equivalency)",
    educ %in% c(7, 8, 9) ~ "Some college or associate's degree",
    educ == 10 ~ "Bachelor's degree",
    educ == 11 ~ "Graduate or professional degree",
    TRUE ~ NA_character_  # Catch-all for other cases
  )
}

map_age <- function(age) {
  case_when(
    age >= 18 & age <= 34 ~ "18-34",
    age >= 35 & age <= 54 ~ "35-54",
    age >= 65 ~ "65+",
    TRUE ~ NA_character_  # Catch-all for other cases
  )
}

map_race <- function(race) {
  case_when(
    race == 1 ~ "White",
    race == 2 ~ "Black",
    race == 3 ~ "Native American",
    race %in% c(4, 5, 6) ~ "Asian",
    race == 7 ~ "Other",
    race %in% c(8,9) ~ "Two or more races",
    TRUE ~ NA_character_  # Catch-all for other cases
  )
}

#variables we are interested in: sex, age, race, hispanic, state, education
clean_data_IPMUS <-
  raw_data_IPUMS |>
  select(SEX, AGE, RACE, HISPAN, STATEICP, EDUC) |>
  filter((!(STATEICP %in% c(83, 96, 97, 98, 99))) & AGE >=18 & SEX != 3 & HISPAN != 9) |>
  mutate(
    hispanic = map_hisp(HISPAN),
    education = map_education(EDUC),
    age_group = map_age(AGE),
    race = map_race(RACE)
  ) |>
  tidyr::drop_na()

table_states <- ddi[["var_info"]][["val_labels"]][[7]]
table_gender <- ddi[["var_info"]][["val_labels"]][[12]]

clean_data_IPMUS$STATEICP <- create_mapping(table_states)[clean_data_IPMUS$STATEICP]
clean_data_IPMUS$SEX <- create_mapping(table_gender)[clean_data_IPMUS$SEX]

clean_data_IPMUS <-
  clean_data_IPMUS |>
  select(SEX, age_group, race, hispanic, STATEICP, education) |>
  rename(gender = SEX, state = STATEICP)

#drops states that are not in survey data to make easier to do the analysis
survey_data <- read.csv("data/analysis_data/analysis_survey_data.csv")

survey_states <- unique(survey_data$state)

# Filter analysis_data_IPUMS to keep only rows with states present in survey_states
clean_data_IPMUS <- clean_data_IPMUS[clean_data_IPMUS$state %in% survey_states, ]


#### Save data ####
write_parquet(clean_data_IPMUS,"data/analysis_data/analysis_data_IPUMS.parquet")
