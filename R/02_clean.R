# Clear workspace ---------------------------------------------------------
rm(list = ls())


# Load libraries ----------------------------------------------------------
library("tidyverse")


# Define functions --------------------------------------------------------
source(file = "R/99_functions.R")


# Load data ---------------------------------------------------------------
SPE <- read_tsv(file = "data/SPE_pitlatrine.tsv.gz")
ENV <- read_tsv(file = "data/ENV_pitlatrine.tsv.gz")

# Wrangle data ------------------------------------------------------------
my_data_clean = SPE %>%
  pivot_longer(cols = -Taxa,
               names_to = "Samples",
               values_to = "OTU_Count") %>%
  full_join(ENV, by = "Samples")

# Write data --------------------------------------------------------------
write_tsv(x = my_data_clean,
          file = "data/02_my_data_clean.tsv.gz")