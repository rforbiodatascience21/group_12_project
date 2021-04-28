# Clear workspace ---------------------------------------------------------
rm(list = ls())


# Load libraries ----------------------------------------------------------
library("tidyverse")
library("stringr")


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
         -Rank15, -BarcodeSequence, -LinkerPrimerSequence, -ReversePrimer) %>%
  mutate(., Rank1 = str_sub(Rank1, start = 6), 
         Rank2 = str_sub(Rank2, start = 6),
         Rank3 = str_sub(Rank3, start = 6),
         Rank4 = str_sub(Rank4, start = 6),
         Rank5 = str_sub(Rank5, start = 6),
         Rank6 = str_sub(Rank6, start = 6)) %>%
  rename(Kingdom = Rank1, Phylum = Rank2, Class = Rank3, Order = Rank4, 
         Family = Rank5, Genus = Rank6, Species = Rank7) 


# Write data --------------------------------------------------------------
write_tsv(x = my_data_clean,
          file = "data/02_my_data_clean.tsv.gz")
