# Clear workspace ---------------------------------------------------------
rm(list = ls())


# Load libraries ----------------------------------------------------------
library("tidyverse")


# Define functions --------------------------------------------------------
#source(file = "R/99_project_functions.R")


# Load data ---------------------------------------------------------------
x <- read_tsv(file = "data/SPE_pitlatrine.csv.gz")
y <- read_tsv(file = "data/ENV_pitlatrine.csv.gz")

# Wrangle data ------------------------------------------------------------
SPE %>%
  pivot_longer(cols = -Taxa,
               names_to = "Samples",
               values_to = "OTU_Count") %>%
  full_join(ENV, by = "Samples")

# Write data --------------------------------------------------------------
write_tsv(x = my_data_clean,
          path = "data/02_my_data_clean.tsv.gz")