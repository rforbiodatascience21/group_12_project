# Clear workspace ---------------------------------------------------------
rm(list = ls())
#

# Load libraries ----------------------------------------------------------
library("tidyverse")

# Define functions --------------------------------------------------------
source(file = "R/99_functions.R")

# Load data ---------------------------------------------------------------
data <- read_tsv(file = "data/01_data.tsv.gz")
metadata <- read_tsv(file = "data/01_meta_data.tsv.gz")

# Wrangle data ------------------------------------------------------------
my_data_clean = data %>%
  full_join(metadata, by = c("Sample"="#SampleID")) %>%
  filter(Description != "N") 

my_data_clean_aug = my_data_clean %>%
  select(-Rank8, -Rank9, -Rank10, -Rank11, -Rank12, -Rank13, -Rank14, 
         -Rank15, -BarcodeSequence, -LinkerPrimerSequence, -ReversePrimer, -Description) %>%
  mutate(Rank1 = str_sub(Rank1, start = 6), 
         Rank2 = str_sub(Rank2, start = 6),
         Rank3 = str_sub(Rank3, start = 6),
         Rank4 = str_sub(Rank4, start = 6),
         Rank5 = str_sub(Rank5, start = 6),
         Rank6 = str_sub(Rank6, start = 6)) %>%
  rename(Kingdom = Rank1, 
         Phylum = Rank2, 
         Class = Rank3, 
         Order = Rank4, 
         Family = Rank5, 
         Genus = Rank6, 
         Species = Rank7)

NA_percentage <- my_data_clean_aug %>%
  select(-Abundance,
         -Sample,
         -OTU,
         -Season,
         -Location) %>% 
  map(~ mean(is.na(.))) %>% 
  as_tibble() %>% 
  pivot_longer(names_to = "Taxonomic level", values_to = "Percent NA's", cols=everything())


#Making the plot
NA_percentage %>% 
  ggplot(aes(x = reorder(`Taxonomic level` , `Percent NA's`), y=`Percent NA's`)) +
  geom_col(fill = "turquoise") +
  labs(x= "Taxonomic level", y="Percent NA's") +
  scale_y_continuous(labels=scales::percent_format()) +
  theme_classic() +
  my_theme
