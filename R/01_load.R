# Clear workspace ---------------------------------------------------------
rm(list = ls())


# Load libraries ----------------------------------------------------------
library(tidyverse)
library(phyloseq)
library(readxl)


# Define functions --------------------------------------------------------
source(file = "R/99_functions.R")


# Load raw data and save it------------------------------------------------
data = import_biom("feature-table_taxonomy.biom")
metadata = read_xlsx("GE_mapfile.xlsx")


# Write data --------------------------------------------------------------
write_tsv(x = SPE, file = "data/01_SPE_pitlatrine.tsv.gz")
write_tsv(x = ENV, file = "data/01_ENV_pitlatrine.tsv.gz")
