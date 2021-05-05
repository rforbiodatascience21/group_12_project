# Clear workspace ---------------------------------------------------------
rm(list = ls())

#install.packages("cowplot")
# Load libraries ----------------------------------------------------------
library("tidyverse")
library("tidyr")
library("vegan")


# Define functions --------------------------------------------------------
source(file = "R/99_functions.R")

# Load data ---------------------------------------------------------------
metadata <- read_tsv(file = "data/01_meta_data.tsv.gz")

# Wrangle data ------------------------------------------------------------
tab <- metadata %>%
  summarise(
    before_filter = n(), 
    after_filter = sum(Season != "N"))
  )
  

samples_before_filter <- 44
samples_after_filter <- tally(metadata, wt = )

samples_summer <- 27-15
samples_winter <- 15
samples_discharge <-
samples_downstream
samples_upstream







# Write data --------------------------------------------------------------

