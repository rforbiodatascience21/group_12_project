# Clear workspace ---------------------------------------------------------
rm(list = ls())
#

# Load libraries ----------------------------------------------------------
library("tidyverse")

# Define functions --------------------------------------------------------
source(file = "R/99_functions.R")

# Load data ---------------------------------------------------------------
my_data_clean_aug_na <- read_tsv(file = "data/03_my_data_clean_aug_na.tsv.gz")

# Wrangle data ------------------------------------------------------------
#Find NA percentage content for each taxonomic level
NA_percentage <- my_data_clean_aug_na %>% 
  select(-Abundance, -Sample, -OTU,
         -Season, -Location) %>% 
  summarise_all(~ mean(is.na(.))) %>% 
  pivot_longer(names_to = "Taxonomic_level", 
               values_to = "Percent_NA", 
               cols = everything())

taxonomic_order <- c("Kingdom", "Phylum", "Class", 
                     "Order", "Family", "Genus", "Species")

#Making the plot
plot_NAs <- NA_percentage %>% 
  ggplot(aes(x = factor(Taxonomic_level, 
                        level = taxonomic_order), 
             y = Percent_NA)) +
  geom_col(fill = "turquoise") +
  scale_y_continuous(labels = scales::percent_format()) +
  labs(x = "Taxonomic level",
       y = "NA percentage",
       title = "NA's by taxonomic level") +
  theme_bw() +
  theme(axis.text.x = element_text(angle = 45, 
                                   hjust = 1),
        plot.title = element_text(size = 20)) 


# Write data --------------------------------------------------------------
ggsave(filename = "05_na_barplot.png", 
       path = "/cloud/project/figures", 
       plot = plot_NAs, 
       device = "png", 
       width = 8, 
       height = 5, 
       dpi = 136)
