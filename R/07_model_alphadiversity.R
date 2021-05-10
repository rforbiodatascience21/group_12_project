# Clear workspace ---------------------------------------------------------
rm(list = ls())

# Load libraries ----------------------------------------------------------
library("tidyverse")
library("vegan")

# Define functions --------------------------------------------------------
source(file = "R/99_functions.R")

# Load data ---------------------------------------------------------------
my_data_clean_aug <- read_tsv(file = "data/03_my_data_clean_aug.tsv.gz")

# Wrangle data ------------------------------------------------------------
my_data_wide <- my_data_clean_aug %>% 
  select(OTU, Abundance, Sample, 
         Season, Location) %>%
  pivot_wider(names_from = OTU,
              values_from = Abundance)

# Calculate diversity index
shannon <- my_data_wide %>% 
  select(-Season, -Location, -Sample) %>% 
  diversity(index = "shannon")

# Combine into same data table for plotting
result <- my_data_wide %>% 
  select(Sample, Location, Season) %>% 
  bind_cols(shannon)

#Plot
plot_alpha_div <- result %>% 
  group_by(Location, Season) %>% 
  ggplot(aes(x = Location,
             y = shannon, 
             fill= Season)) +
  geom_boxplot() +
  theme_bw() +
  theme(axis.text.x = element_text(angle = 45, 
                                   hjust = 1)) +
  labs(x = "Location",
       y = "Shannon index",
       title = "Alpha diversity",
       subtitle = "Shannon diversity index")

# Write data --------------------------------------------------------------
ggsave(filename = "alpha_div.png", 
       path = "/cloud/project/figures", 
       plot = plot_alpha_div, 
       device = "png", 
       width = 8, 
       height = 5, 
       dpi = 136)
