# Clear workspace ---------------------------------------------------------
rm(list = ls())


# Load libraries ----------------------------------------------------------
library("tidyverse")


# Define functions --------------------------------------------------------
source(file = "R/99_functions.R")


# Load data ---------------------------------------------------------------
my_data_clean <- read_tsv(file = "data/02_my_data_clean.tsv.gz")


# Wrangle data ------------------------------------------------------------
#Remove other unwanted coloumns, and rename taxnomic columns
my_data_clean_aug_na = my_data_clean %>%
  select(-Rank8, -Rank9, -Rank10, 
         -Rank11, -Rank12, -Rank13, 
         -Rank14, -Rank15, -BarcodeSequence, 
         -LinkerPrimerSequence, -ReversePrimer, -Description) 
  mutate(Rank1 = str_sub(Rank1, 
                         start = 6), 
         Rank2 = str_sub(Rank2, 
                         start = 6),
         Rank3 = str_sub(Rank3, 
                         start = 6),
         Rank4 = str_sub(Rank4, 
                         start = 6),
         Rank5 = str_sub(Rank5, 
                         start = 6),
         Rank6 = str_sub(Rank6, 
                         start = 6)) %>% 
<<<<<<< HEAD
  na_if(y = "D_6__") %>% 
  
=======
>>>>>>> 16f9ba89ddb10ed0ed1330e98848b6529cf72fb0
  rename(Kingdom = Rank1, 
         Phylum = Rank2, 
         Class = Rank3, 
         Order = Rank4, 
         Family = Rank5, 
         Genus = Rank6, 
         Species = Rank7)

#make extra augment script without na's
my_data_clean_aug <- my_data_clean_aug_na %>% 
  filter(!is.na(Phylum)) 

# Write data --------------------------------------------------------------
write_tsv(x = my_data_clean_aug,
          file = "data/03_my_data_clean_aug.tsv.gz")

write_tsv(x = my_data_clean_aug_na,
          file = "data/03_my_data_clean_aug_na.tsv.gz")
