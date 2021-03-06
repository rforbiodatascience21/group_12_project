# Clear workspace ---------------------------------------------------------
rm(list = ls())


# REASON FOR NON-inclusion ------------------------------------------------
#THis script contains the beginning of a PCA based on the metadata.
#Since we only ended up with 2 metadata variables it was realized to be a 
#DEAD_END



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

#make season binary
my_data_clean_aug <- my_data_clean_aug %>%
  mutate(Season = case_when(
    Season == "Winter" ~ 0,
    Season == "Summer" ~ 1))

#Do a PCA fit
pca_fit <- my_data_clean_aug %>% 
  select(where(is.numeric)) %>% # retain only numeric columns
  prcomp(scale = TRUE) # do PCA on scaled data

# Visualise data ----------------------------------------------------------
pca_fit %>%
  augment(my_data_clean_aug) %>% # add original dataset back in
  ggplot(aes(.fittedPC1, .fittedPC2, color = Location)) + 
  geom_point(size = 1.5) +
  stat_ellipse(frame = TRUE, frame.type = 'norm') + 
  labs(x = "PC 1", y = "PC 2", title = "Scatter plot in Top 2 Principal Components") +
  theme_half_open(12) + background_grid()

# Write data --------------------------------------------------------------

