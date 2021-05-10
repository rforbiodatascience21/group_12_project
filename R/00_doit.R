# Clear workspace ---------------------------------------------------------
rm(list = ls())

# Load libraries ----------------------------------------------------------
library("tidyverse")
library("knitr")
library("markdown")

#Run pipeline
source(file = "R/01_load.R")
source(file = "R/02_clean.R")
source(file = "R/03_augment.R")
source(file = "R/04_model_table.R")
source(file = "R/05_model_NA_barchart.R")
source(file = "R/06_model_abundance.R")
source(file = "R/07_model_alphadiversity.R")
source(file = "R/08_model_nmds.R")


#Create slides from markdown
rmarkdown::render("doc/master_presentation.Rmd")
