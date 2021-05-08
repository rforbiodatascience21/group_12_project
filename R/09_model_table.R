# Clear workspace ---------------------------------------------------------
rm(list = ls())

#install.packages("cowplot")
# Load libraries ----------------------------------------------------------
library("tidyverse")
library("gt")
library("glue")


# Define functions --------------------------------------------------------
source(file = "R/99_functions.R")


# Load data ---------------------------------------------------------------
metadata <- read_tsv(file = "data/01_meta_data.tsv.gz")
data <- read_tsv(file = "data/01_data.tsv.gz")


# Wrangle data ------------------------------------------------------------
#merge datasets but without any filtering
my_data_merged = data %>%
  full_join(metadata, by = c("Sample"="#SampleID"))

n_samples_data <- my_data_merged %>%
  select(Sample, OTU) %>%
  summarise(Samples = n_distinct(Sample), 
            OTU = n_distinct(OTU)) %>% 
  pivot_longer(cols = c(Samples, OTU), 
               names_to = " ", 
               values_to = "Total number of")

n_samples_season <- my_data_merged %>% 
  group_by(Season) %>%
  summarise(Samples = n_distinct(Sample),
            OTU = n_distinct(OTU)) %>% 
  pivot_longer(cols = - Season,
               names_to = "Seasons") %>% 
  pivot_wider(names_from = Seasons,
              values_from = value)
    
n_samples_location <- my_data_merged %>%
  group_by(Location) %>%
  summarise(Samples = n(Sample)
            ) %>% 
  pivot_longer(cols = -Location,
             names_to = "Locations") %>% 
  pivot_wider(names_from = Locations,
              values_from = value)
  relocate(Other = N, Upstream, Wastewater, Discharge, Downstream)


#combine info to one table
table_info <-  

table <- table_info %>%
  tab_spanner(label = " ",
              columns = "Total number") %>% 
  tab_spanner(label = "Season",
              columns = vars(None, Summer, Winter)) %>% 
  tab_spanner(label = "Location",
              columns = vars())

    





# Write data --------------------------------------------------------------

