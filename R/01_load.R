# Clear workspace ---------------------------------------------------------
rm(list = ls())


# Load libraries ----------------------------------------------------------
<<<<<<< HEAD
library("tidyverse")
library("biom")
=======
library(tidyverse)
library(phyloseq)
library(readxl)



# Define functions --------------------------------------------------------
source(file = "R/99_functions.R")


# Load raw data and save it------------------------------------------------
<<<<<<< HEAD
SPE = read_biom(file = "data/raw/SPE_pitlatrine.csv")

=======
data = import_biom("data/raw/feature-table_taxonomy.biom")
metadata = read_xlsx("data/raw/GE_mapfile.xlsx")
>>>>>>> 59d28168825b287a79a0e10c9d3bce7bc8f7de55


# Write data --------------------------------------------------------------
write_tsv(x = SPE, file = "data/01_SPE_pitlatrine.tsv.gz")
write_tsv(x = ENV, file = "data/01_ENV_pitlatrine.tsv.gz")
