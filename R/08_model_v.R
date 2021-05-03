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
otu_abundane = my_data_clean_aug %>% 
  pivot_wider(., names = ) 
nmds = metaMDS(my_data_clean_aug, distance = "bray") #Virker ikke før vi har pivot

# Write data --------------------------------------------------------------

