# Clear workspace ---------------------------------------------------------
rm(list = ls())

#install.packages("cowplot")
# Load libraries ----------------------------------------------------------
library("tidyverse")
library("tidyr")
library("vegan")


# Define functions --------------------------------------------------------
source(file = "R/99_functions.R")

# Load data ---------------------------------------------------------------
metadata <- read_tsv(file = "data/01_meta_data.tsv.gz")
my_data_clean_aug <- read_tsv(file = "data/03_my_data_clean_aug.tsv.gz")

# Wrangle data ------------------------------------------------------------
before_filter <- summarise(metadata, before_filter = n())

my_data_clean_aug <- my_data_clean_aug %>%
  pivot_wider(names_from = Sample, values_from = OTU)

 after_filter_location <- my_data_clean_aug %>%
  group_by(Location) %>%
  summarise(n(Location != N))

after_filter_season <- metadata %>%
  group_by(Season) %>%
  summarise(n())
  
# Write data --------------------------------------------------------------

