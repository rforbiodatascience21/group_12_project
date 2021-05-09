# Clear workspace ---------------------------------------------------------
rm(list = ls())

#install.packages("cowplot")
# Load libraries ----------------------------------------------------------
library("tidyverse")
library("vegan")


# Define functions --------------------------------------------------------
source(file = "R/99_functions.R")


# Load data ---------------------------------------------------------------
my_data_clean_aug <- read_tsv(file = "data/03_my_data_clean_aug.tsv.gz")

# Wrangle data ------------------------------------------------------------
my_data_wide <- my_data_clean_aug %>%
  select(OTU, Abundance, Sample, Species) %>%  
  replace(is.na(.), "Unknown") %>% 
  pivot_wider(names_from = Species,
              values_from = Abundance,
              values_fill = 0) %>% 
  select(-OTU) %>% 
  group_by(Sample) %>%
  summarise_all(a=sum(.))

#calculate total n of species
data(BCI)
S <- specnumber(BCI) 
  





# Write data --------------------------------------------------------------
gtsave(table,
       filename = "table1.html",
       path = "/cloud/project/figures")
