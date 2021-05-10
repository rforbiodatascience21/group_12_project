# Clear workspace ---------------------------------------------------------
rm(list = ls())
#

# Load libraries ----------------------------------------------------------
library("tidyverse")

# Define functions --------------------------------------------------------
source(file = "R/99_functions.R")

# Load data ---------------------------------------------------------------
data <- read_tsv(file = "data/01_data.tsv.gz")
metadata <- read_tsv(file = "data/01_meta_data.tsv.gz")

# Wrangle data ------------------------------------------------------------
#merging data with metadata, renaming and removal of columns
my_data_clean_aug = data %>%
  full_join(y = metadata, 
            by = c("Sample" = "#SampleID")) %>%
  filter(Description != "N") %>%
  select(-Rank8, -Rank9, -Rank10, 
         -Rank11, -Rank12, -Rank13, 
         -Rank14, -Rank15, -BarcodeSequence, 
         -LinkerPrimerSequence, -ReversePrimer, -Description) %>%
  mutate(Rank1 = str_sub(Rank1, 
                         start = 6), 
         Rank2 = str_sub(Rank2, 
                         start = 6),
         Rank3 = str_sub(Rank3, 
                         start = 6),
         Rank4 = str_sub(Rank4, 
                         start = 6),
         Rank5 = str_sub(Rank5, 
                         start = 6),
         Rank6 = str_sub(Rank6, 
                         start = 6)) %>%
  rename(Kingdom = Rank1, 
         Phylum = Rank2, 
         Class = Rank3, 
         Order = Rank4, 
         Family = Rank5, 
         Genus = Rank6, 
         Species = Rank7)

#Find NA percentage content for each taxonomic level
NA_percentage <- my_data_clean_aug %>% 
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
ggsave(filename = "na_bar_plot.png", 
       path = "/cloud/project/figures", 
       plot = plot_NAs, 
       device = "png", 
       width = 8, 
       height = 5, 
       dpi = 136)
