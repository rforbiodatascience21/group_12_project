# Clear workspace ---------------------------------------------------------
rm(list = ls())


# Load libraries ----------------------------------------------------------
library("tidyverse")
library("biom")


# Define functions --------------------------------------------------------
source(file = "R/99_functions.R")


# Load raw data and save it------------------------------------------------
SPE = read_biom(file = "data/raw/SPE_pitlatrine.csv")



# Write data --------------------------------------------------------------
write_tsv(x = SPE, file = "data/01_SPE_pitlatrine.tsv.gz")
write_tsv(x = ENV, file = "data/01_ENV_pitlatrine.tsv.gz")
