#### Preamble ####
# Purpose: Simulates Us 2020 Election Popular Vote
# Author: Sachin Chhikara
# Date: 5 March 2024
# Contact: sachin.chhikarar@utoronto.ca 
# License: MIT
# Pre-requisites: [...UPDATE THIS...]
# Any other information needed? [...UPDATE THIS...]

#### Workspace setup ##
# Load required libraries
library(tibble)
library(ggplot2)

# Define options for each column
genders <- c("Male", "Female")
age_groups <- c("18-24", "25-34", "35-44", "45-54", "55-64", "65+")
races <- c("White", "Black", "Hispanic", "Asian", "Other")
hispanic <- c("Yes", "No")
states <- c("Alabama", "Alaska", "Arizona", "Arkansas", "California", "Colorado", "Connecticut", "Delaware", "Florida", "Georgia", "Hawaii", "Idaho", "Illinois", "Indiana", "Iowa", "Kansas", "Kentucky", "Louisiana", "Maine", "Maryland", "Massachusetts", "Michigan", "Minnesota", "Mississippi", "Missouri", "Montana", "Nebraska", "Nevada", "New Hampshire", "New Jersey", "New Mexico", "New York", "North Carolina", "North Dakota", "Ohio", "Oklahoma", "Oregon", "Pennsylvania", "Rhode Island", "South Carolina", "South Dakota", "Tennessee", "Texas", "Utah", "Vermont", "Virginia", "Washington", "West Virginia", "Wisconsin", "Wyoming")
educations <- c("High School", "Bachelor's Degree", "Master's Degree", "PhD")
votes <- c("Trump", "Biden")

# Set the dataset size
dataset_size <- 1000

# Sample data for each column
gender <- sample(genders, dataset_size, replace = TRUE)
age_group <- sample(age_groups, dataset_size, replace = TRUE)
race <- sample(races, dataset_size, replace = TRUE)
hispanic <- sample(hispanic, dataset_size, replace = TRUE)
state <- sample(states, dataset_size, replace = TRUE)
education <- sample(educations, dataset_size, replace = TRUE)
vote <- sample(votes, dataset_size, replace = TRUE)

# Create the dataset
election_data <- tibble(
  Gender = gender,
  Age_Group = age_group,
  Race = race,
  Hispanic = hispanic,
  State = state,
  Education = education,
  Vote = vote
)

######

create_bar_plot <- function(column_name) {
  # Create a table of votes by column and candidate
  vote_table <- table(election_data[[column_name]], election_data$Vote)
  
  # Convert the table to a data frame
  vote_df <- as.data.frame(vote_table)
  
  # Rename the columns for better visualization
  colnames(vote_df) <- c(column_name, "Candidate", "Count")
  
  # Plot the bar plot
  ggplot(vote_df, aes(x = .data[[column_name]], y = Count, fill = Candidate)) +
    geom_bar(stat = "identity", position = "dodge") +
    labs(title = paste("Votes by", column_name, "and Candidate"),
         x = column_name,
         y = "Number of Votes",
         fill = "Candidate") +
    theme_minimal()
}

# Create bar plots for each column
plots_list <- lapply(names(election_data)[-which(names(election_data) == "Vote")], create_bar_plot)

# Display each plot individually



for (plot in plots_list) {
 print(plot)
}