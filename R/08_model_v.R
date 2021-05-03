# Clear workspace ---------------------------------------------------------
rm(list = ls())
#
#install.packages("cowplot")
# Load libraries ----------------------------------------------------------
library("tidyverse")
library("tidyr")
library("vegan")


# Define functions --------------------------------------------------------
source(file = "R/99_functions.R")

# Load data ---------------------------------------------------------------
my_data_clean_aug <- read_tsv(file = "data/03_my_data_clean_aug.tsv.gz")

# Wrangle data ------------------------------------------------------------

my_data_clean_aug <- my_data_clean_aug %>%
  pivot_wider(names_from = OTU, values_from = Abundance)



nmds = metaMDS(my_data_clean_aug, distance = "bray")

# Write data --------------------------------------------------------------

