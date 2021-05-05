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
metadata2 = read_xlsx("data/raw/Book1.xlsx")
res_genes = read_xlsx("")

#Convert to tidy format
data = psmelt(data)


# Write data --------------------------------------------------------------
write_tsv(x = data, file = "data/01_data.tsv.gz")
write_tsv(x = metadata, file = "data/01_meta_data.tsv.gz")
write_tsv(x = metadata2, file = "data/01_meta_data2.tsv.gz")
