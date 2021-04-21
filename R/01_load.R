# Clear workspace ---------------------------------------------------------
rm(list = ls())


# Load libraries ----------------------------------------------------------
library("tidyverse")


# Define functions --------------------------------------------------------
#source(file = "R/99_project_functions.R")


# Load raw data and save it------------------------------------------------
SPE = read_csv(file = "data/raw/SPE_pitlatrine.csv")
ENV = read_csv("data/raw/ENV_pitlatrine.csv")


# Write data --------------------------------------------------------------
write_tsv(x = SPE, file = "data/SPE_pitlatrine.tsv.gz")
write_tsv(x = ENV, file = "data/ENV_pitlatrine.tsv.gz")
