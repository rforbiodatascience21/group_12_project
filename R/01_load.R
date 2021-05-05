# Clear workspace ---------------------------------------------------------
rm(list = ls())


# Load libraries ----------------------------------------------------------
#if (!requireNamespace("BiocManager", quietly = TRUE))
 #install.packages("BiocManager")
#BiocManager::install(version = "3.12")
#BiocManager::install("phyloseq")
library(tidyverse)
library(phyloseq)
library(readxl)


# Define functions --------------------------------------------------------
source(file = "R/99_functions.R")


# Load raw data and save it------------------------------------------------
<<<<<<< HEAD
data <- import_biom("data/raw/feature-table_taxonomy.biom")
metadata <- read_xlsx("data/raw/GE_mapfile.xlsx")
=======
data = import_biom("data/raw/feature-table_taxonomy.biom")
metadata = read_xlsx("data/raw/GE_mapfile.xlsx")
metadata2 = read_xlsx("data/raw/Book1.xlsx")

>>>>>>> 8168854c50777f2c47405a17e1be959378bad112

#Convert to tidy format
data <- data %>% 
  psmelt()


# Write data --------------------------------------------------------------
write_tsv(x = data, file = "data/01_data.tsv.gz")
<<<<<<< HEAD
write_tsv(x = metadata, file = "data/01_meta_data.tsv.gz")
=======
write_tsv(x = metadata, file = "data/01_meta_data.tsv.gz")
>>>>>>> 8168854c50777f2c47405a17e1be959378bad112
