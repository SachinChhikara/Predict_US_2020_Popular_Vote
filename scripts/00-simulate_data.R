#### Preamble ####
# Purpose: Simulates Us 2020 Election Popular Vote
# Author: Sachin Chhikara
# Date: 5 March 2024
# Contact: sachin.chhikarar@utoronto.ca 
# License: MIT
# Pre-requisites: [...UPDATE THIS...]
# Any other information needed? [...UPDATE THIS...]

#### Workspace setup ####
library(tidyverse)
# [...UPDATE THIS...]

set.seed(123)

#creates dataset
parties <- c("Republican", "Democrat", "Independent")
candidates <- c("Donald Trump", "Joe Biden", "Other")

# Define probabilities for party affiliation (you can adjust these as needed)
party_probabilities <- c(0.4, 0.4, 0.2)

# Define probabilities for candidate selection based on party affiliation
candidate_probabilities <- matrix(c(
  # Republican party
  0.85, 0.1, 0.5,
  # Democrat party
  0.05, 0.92, 0.03,
  # Independent party
  0.3, 0.3, 0.4
), nrow = length(parties), byrow = TRUE)

dataset_size <- 1000

# Sample party affiliations
party_affiliations <- sample(parties, size = dataset_size, replace = TRUE, prob = party_probabilities)

# Sample votes based on party affiliation
votes <- character(dataset_size)
for (i in 1:dataset_size) {
  party_index <- match(party_affiliations[i], parties)
  votes[i] <- sample(candidates, size = 1, prob = candidate_probabilities[party_index, ])
}

election_data <- tibble(
  Party = party_affiliations,
  Vote = votes
)

#creates bar plot
vote_table <- table(election_data$Party, election_data$Vote)


vote_df <- as.data.frame(vote_table)

# Rename the columns for better visualization
colnames(vote_df) <- c("Party", "Candidate", "Count")
vote_df$Party <- factor(vote_df$Party, levels = parties)

# Plot the bar plot
ggplot(vote_df, aes(x = Party, y = Count, fill = Candidate)) +
  geom_bar(stat = "identity", position = "dodge") +
  labs(title = "Votes by Party Affiliation and Candidate",
       x = "Party Affiliation",
       y = "Number of Votes",
       fill = "Candidate") +
  theme_minimal()

