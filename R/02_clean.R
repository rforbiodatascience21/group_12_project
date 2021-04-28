# Clear workspace ---------------------------------------------------------
rm(list = ls())


# Load libraries ----------------------------------------------------------
library("tidyverse")


# Define functions --------------------------------------------------------
source(file = "R/99_functions.R")


# Load data ---------------------------------------------------------------
data <- read_tsv(file = "data/01_data.tsv.gz")
metadata <- read_tsv(file = "data/01_meta_data.tsv.gz")

# Wrangle data ------------------------------------------------------------
my_data_clean = data %>%
  #merging data
  full_join(metadata, by = c("Sample"="#SampleID")) %>%
  #only select samples with metadata
  filter(., Description != "N") %>%
  select(., -Rank8, -Rank9, -Rank10, -Rank11, -Rank12, -Rank13, -Rank14, 
         -Rank15, -BarcodeSequence, -LinkerPrimerSequence, -ReversePrimer)
         
# Write data --------------------------------------------------------------
write_tsv(x = my_data_clean,
          file = "data/02_my_data_clean.tsv.gz")