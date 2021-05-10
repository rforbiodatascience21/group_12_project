# Clear workspace ---------------------------------------------------------
rm(list = ls())

# Load libraries ----------------------------------------------------------
library("tidyverse")
library("gt")
library("webshot")


# Define functions --------------------------------------------------------
source(file = "R/99_functions.R")


# Load data ---------------------------------------------------------------
metadata <- read_tsv(file = "data/01_meta_data.tsv.gz")
data <- read_tsv(file = "data/01_data.tsv.gz")


# Wrangle data ------------------------------------------------------------
#merge datasets but without any filtering
my_data_merged = data %>%
  full_join(metadata, 
            by = c("Sample"="#SampleID"))

#find number of samples and OTU
n_samples_data <- my_data_merged %>%
  select(Sample, OTU)  %>%
  summarise(Samples = n_distinct(Sample), 
            OTU = n_distinct(OTU))  %>% 
  pivot_longer(cols = c(Samples, OTU), 
               names_to = " ", 
               values_to = "Total")

#find number of samples and OTU in each season
n_samples_season <- my_data_merged %>%
  filter(Abundance != 0) %>% 
  group_by(Season) %>%
  summarise(Samples = n_distinct(Sample),
            OTU = n_distinct(OTU)) %>% 
  pivot_longer(cols = - Season,
               names_to = " ") %>% 
  pivot_wider(names_from = Season,
              values_from = value) %>% 
  rename("No season" = None)

#finder number of samples and OTU by location    
n_samples_location <- my_data_merged %>%
  filter(Abundance != 0) %>% 
  group_by(Location) %>%
  summarise(Samples = n_distinct(Sample),
            OTU = n_distinct(OTU)) %>% 
  pivot_longer(cols = - Location,
             names_to = " ") %>% 
  pivot_wider(names_from = Location,
              values_from = value) %>%  
  relocate(" ", "No location" = N, Upstream, Wastewater, Discharge, Downstream)

#combine info to one table
table_info <- n_samples_data %>% 
  left_join(n_samples_location) %>% 
  left_join(n_samples_season)

#tranform table to gt format
table <- table_info %>%
  gt() %>% 
  tab_spanner(label = "Location",
              columns = vars("No location", Upstream, Wastewater, 
                             Discharge, Downstream)) %>% 
  tab_spanner(label = "Season",
              columns = vars("No season", Summer, Winter))


# Write data --------------------------------------------------------------
gtsave(data = table,
       filename = "04_model_table.png",
       path = "/cloud/project/figures")
