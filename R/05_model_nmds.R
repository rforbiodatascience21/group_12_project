# Clear workspace ---------------------------------------------------------
rm(list = ls())

#install.packages("cowplot")
# Load libraries ----------------------------------------------------------
library("tidyverse")
library("tidyr")
library("vegan")


# Define functions --------------------------------------------------------
source(file = "R/99_functions.R")

# Load data ---------------------------------------------------------------
my_data_clean_aug <- read_tsv(file = "data/03_my_data_clean_aug.tsv.gz")

# Wrangle data ------------------------------------------------------------

my_data_clean_aug_wide <- my_data_clean_aug %>%
  select(., OTU, Abundance, Sample, Season, Location) %>%
  pivot_wider(names_from = OTU, values_from = Abundance)

my_data_clean_aug_wide_smaller <- my_data_clean_aug_wide %>%
  select(., -Sample, -Season, -Location)

nmds = metaMDS(my_data_clean_aug_wide_smaller, distance = "bray")

scores_nmds <- nmds %>%
  scores() %>% 
  as_tibble()

#as_tibble(scores(nmds))

#add columns to data frame
my_data_clean_aug_wide_joined <- my_data_clean_aug_wide %>%
  select(., Sample, Season, Location) %>%
  bind_cols(scores_nmds)
  
plot_nmds <- my_data_clean_aug_wide_joined %>%
  ggplot(., aes(x=NMDS1, y=NMDS2)) + 
  geom_point(size =4, aes( shape = Season, colour = Location)) +
  labs(x = "NMDS1", colour = "Location", y = "NMDS2", shape = "Season")

# Write data --------------------------------------------------------------
ggsave(filename = "nmds_plot.png", path = "/cloud/project/figures", plot = plot_nmds, device = "png", width = 16, height = 9, dpi = 136)
