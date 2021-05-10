# Clear workspace ---------------------------------------------------------
rm(list = ls())

#install.packages("cowplot")
# Load libraries ----------------------------------------------------------
library("tidyverse")
library("vegan")


# Define functions --------------------------------------------------------
source(file = "R/99_functions.R")


# Load data ---------------------------------------------------------------
my_data_clean_aug <- read_tsv(file = "data/03_my_data_clean_aug.tsv.gz")

# Wrangle data ------------------------------------------------------------
my_data_wide <- my_data_clean_aug %>%
  select(OTU, Abundance, Sample) %>% 
  pivot_wider(names_from = OTU,
              values_from = Abundance,
              values_fill = 0) %>% 
  column_to_rownames(var = "Sample")

#count number of OTU
OTU_count <- specnumber(my_data_wide)

rareMax <- min(rowSums(my_data_wide))

Srare <- rarefy(my_data_wide, rareMax)

plot(OTU_count, Srare, xlab = "Observed No. of Species", ylab = "Rarefied No. of Species")
abline(0, 1)

plot_rarefaction <-rarecurve(my_data_wide, 
          step = 20, 
          sample = rareMax, 
          col = "coral", 
          cex = 0.6,
          tidy = TRUE)


# Write data --------------------------------------------------------------
ggsave(filename = "10_model_rarefactionn.png", 
       path = "/cloud/project/figures", 
       plot = plot_rarefaction, 
       device = "png", 
       width = 8, 
       height = 4, 
       dpi = 136)
