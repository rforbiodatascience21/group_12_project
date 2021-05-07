# Clear workspace ---------------------------------------------------------
rm(list = ls())
#

# Load libraries ----------------------------------------------------------
library("tidyverse")

# Define functions --------------------------------------------------------
source(file = "R/99_functions.R")

# Load data ---------------------------------------------------------------
my_data_clean_aug <- read_tsv(file = "data/03_my_data_clean_aug.tsv.gz")


# Wrangle data ------------------------------------------------------------
mean_NA <- my_data_clean_aug %>%
  select(-Abundance,
         -Sample,
         -OTU,
         -Season,
         -Location) %>% 
  map(~ mean(is.na(.))) %>% 
  as_tibble() %>% 
  pivot_longer(names_to = "Taxonomic level", values_to = "Percent NA's", cols=everything())


#Making the plot
mean_NA %>% 
  relocate(any_of(c("Kingdom",
                    "Phylum",
                    "Class",
                    "Order",
                    "Family",
                    "Genus",
                    "Species"))) %>% 
  ggplot(aes(x = `Taxonomic level`, y=`Percent NA's`)) +
  geom_col()

