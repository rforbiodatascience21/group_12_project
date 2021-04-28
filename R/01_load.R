# Clear workspace ---------------------------------------------------------
rm(list = ls())

# Load libraries ----------------------------------------------------------
#if (!requireNamespace("BiocManager", quietly = TRUE))
# install.packages("BiocManager")
#BiocManager::install(version = "3.12")
#BiocManager::install("phyloseq")
library(tidyverse)
library(phyloseq)
library(readxl)



# Define functions --------------------------------------------------------
source(file = "R/99_functions.R")


# Load raw data and save it------------------------------------------------
data = import_biom("data/raw/feature-table_taxonomy.biom")
metadata = read_xlsx("data/raw/GE_mapfile.xlsx")


# Write data --------------------------------------------------------------
write_tsv(x = SPE, file = "data/01_SPE_pitlatrine.tsv.gz")
write_tsv(x = ENV, file = "data/01_ENV_pitlatrine.tsv.gz")
