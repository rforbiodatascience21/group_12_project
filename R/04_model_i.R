# Clear workspace ---------------------------------------------------------
rm(list = ls())
#
#install.packages("cowplot")
# Load libraries ----------------------------------------------------------
library("tidyverse")
library("tidyr")
library("broom")
library("cowplot")


# Define functions --------------------------------------------------------
source(file = "R/99_functions.R")

# Load data ---------------------------------------------------------------
my_data_clean_aug <- read_tsv(file = "data/03_my_data_clean_aug.tsv.gz")

# Wrangle data ------------------------------------------------------------
#Do a PCA fit
pca_fit <- my_data_clean_aug %>% 
  select(where(is.numeric)) %>% # retain only numeric columns
  prcomp(scale = TRUE) # do PCA on scaled data

# Visualise data ----------------------------------------------------------


# Write data --------------------------------------------------------------

