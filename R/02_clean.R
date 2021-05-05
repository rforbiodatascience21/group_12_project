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
metadata2 <- read_tsv(file = "data/01_meta_data2.tsv.gz")

# Wrangle data ------------------------------------------------------------
#merging data and filter for metadata
my_data_clean = data %>%
  full_join(metadata, by = c("Sample"="#SampleID")) %>%
  filter(., Description != "N") %>%
  filter(., Location != "Wastewater") %>% 
  filter(., !is.na(Rank2))

#WHAM BAM FREE THE RAM!
rm(data, metadata)

metadata2 = metadata2 %>% 
  fill(Parameter) %>% 
  rename(., "Upstream" = "Sampling sites", 
         Discharge = ...4 , 
         Downstream = ...5) %>% 
  slice(., n=2:27)


my_data_clean = my_data_clean %>% 
  full_join(metadata2, by = "Season")
  
# Write data --------------------------------------------------------------
write_tsv(x = my_data_clean,
          file = "data/02_my_data_clean.tsv.gz")
