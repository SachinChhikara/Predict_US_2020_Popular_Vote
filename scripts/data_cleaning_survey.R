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

#variables we are interested in: sex, age, race, hispanic, state, education and
# who they voted for 2020 election(Trump or Biden)

cleaned_data_survey <-
  raw_data_survey |>
  mutate(
    age = year - birthyr,
    age_group = case_when(
      age >= 18 & age <= 34 ~ "18-34",
      age >= 35 & age <= 54 ~ "35-54",
      age >= 65 ~ "65+",
      TRUE ~ NA_character_  # Catch-all for other cases
    )
  ) |>
  select(gender, age_group, race, hispanic, inputstate, educ, presvote20post) |>
  filter(presvote20post %in% c('Donald Trump', 'Joe Biden')) |>
  tidyr::drop_na()


  
  #### Save data ####
write_csv(cleaned_data_survey, "data/analysis_data/analysis_survey_data.csv")
