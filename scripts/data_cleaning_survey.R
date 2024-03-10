#### Preamble ####
# Purpose: Cleans the raw survey data based off a few variables
# Author: Sachin Chhikara
# Date: 10 March 2024 
# Contact: sachin.chhikara@utoronto.ca 
# License: MIT


#### Workspace setup ####
library(tidyverse)

#### Clean data ####
raw_data_survey <- read_csv("data/raw_data/2024_week5_Jan-26--Feb-01.csv")

#helper functions
map_age <- function(age) {
  case_when(
    age >= 18 & age <= 34 ~ "18-34",
    age >= 35 & age <= 54 ~ "35-54",
    age >= 65 ~ "65+",
    TRUE ~ NA_character_  # Catch-all for other cases
  )
}

map_education <- function(educ) {
  case_when(
    educ == "No HS" ~ "No high school diploma",
    educ == "High school graduate" ~ "High school graduate (includes equivalency)",
    educ == "Some college" | educ == "2-year" ~ "Some college or associate's degree",
    educ == "4-year" ~ "Bachelor's degree",
    educ == "Post-grad" ~ "Graduate or professional degree",
    TRUE ~ NA_character_  # Catch-all for other cases
  )
}


#variables we are interested in: sex, age, race, hispanic, state, education and
# who they voted for 2020 election(Trump or Biden)

cleaned_data_survey <-
  raw_data_survey |>
  mutate(
    age = year - birthyr,
    age_group = map_age(age),
    education = map_education(educ)
  ) |>
  select(gender, age_group, race, hispanic, inputstate, education, presvote20post) |>
  filter(presvote20post %in% c('Donald Trump', 'Joe Biden')) |>
  tidyr::drop_na()





  
  #### Save data ####
write_csv(cleaned_data_survey, "data/analysis_data/analysis_survey_data.csv")
