# Clear workspace ---------------------------------------------------------
rm(list = ls())
#
#install.packages("cowplot")
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

#Do a PCA fit
pca_fit <- my_data_clean_aug %>% 
  select(where(is.numeric)) %>% # retain only numeric columns
  prcomp(scale = TRUE) # do PCA on scaled data


# Visualise data ----------------------------------------------------------
pca_fit %>%
  tidy(matrix = "eigenvalues") %>%
  ggplot(aes(PC, percent)) +
  geom_col(fill = "#56B4E9", alpha = 0.8) +
  scale_x_continuous(limits=c(0,11), breaks=1:10) +
  scale_y_continuous(
    labels = scales::percent_format(),
    expand = expansion(mult = c(0, 0.01))
  ) +
  theme_minimal_hgrid(12)

#Cumulative PCA-plot
pca_fit %>%
  tidy(matrix = "eigenvalues") %>%
  ggplot(aes(PC, cumulative)) +
  geom_col(fill = "indianred4", alpha = 0.8) +
  scale_x_continuous(limits=c(0,11), breaks=1:10) +
  scale_y_continuous(
    labels = scales::percent_format(),
    expand = expansion(mult = c(0, 0.01))
  ) + 
  labs(x = "Principal componet", 
       y = "Cumulative percentage",
       title = "Variance explained by principal componets") +
  geom_hline(yintercept = 0.95, linetype = "dashed", color = "turquoise4") +
  theme_minimal_hgrid(12)


# Write data --------------------------------------------------------------

