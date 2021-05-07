# Clear workspace ---------------------------------------------------------
rm(list = ls())

# Load libraries ----------------------------------------------------------
library("tidyverse")
library("hues")

# Define functions --------------------------------------------------------
source(file = "R/99_functions.R")

# Load data ---------------------------------------------------------------
my_data_clean_aug <- read_tsv(file = "data/03_my_data_clean_aug.tsv.gz")

# Wrangle data ------------------------------------------------------------
my_data_clean_small <- my_data_clean_aug %>%
  select(Sample, Abundance, Season, Location, Phylum, Family)

topX_phylum <- topX(my_data_clean_small, 8)

my_data_clean_small_plot <- produce_topX(my_data_clean_small, topX_phylum)


# Visualise data ----------------------------------------------------------
#save plot theme
my_theme <- theme(axis.text = element_text(colour = "black"),
      axis.text.x = element_text(angle = 90, hjust = 1, vjust = 0.5, size = 8),
      panel.border = element_rect(linetype = "solid", fill = NA,
                                  size = 0.5),
      axis.line = element_blank(),
      strip.background = element_blank(),
      legend.key.size = unit(0.4, "cm"))

#plot rel abundance sorted by location
ggplot(my_data_clean_small_plot, 
       aes(x = Sample, y = Phylum_abundance, 
           # we sort the top phyla alphabetically, then add "Other" at the end
           fill = factor(Phylum, c(sort(topX_phylum), "Other")))) + 
  geom_bar(stat = "identity", position = "fill") + 
  labs(x = "Sample", y = "Relative abundance") + 
  scale_y_continuous(expand = c(0.02, 0), labels = scales::percent_format()) +
  scale_fill_manual(values = c(as.character(iwanthue(length(topX_phylum)+1))),
                    name = "Top 8 most abundant Phylum") +
  facet_grid( ~ Location, scales = "free_x", space = "free_x") + 
  theme_classic() +
  my_theme

#plot abundance sorted by Location
ggplot(my_data_clean_small_plot,
       aes(x = Sample, y = Phylum_abundance, 
           # we sort the top phyla alphabetically, then add "Other" at the end
           fill = factor(Phylum, c(sort(topX_phylum), "Other")))) + 
  geom_bar(stat = "identity") + 
  labs(x = "Sample", y = "Abundance") + 
  scale_y_continuous(expand = c(0.02, 0)) +
  scale_fill_manual(values = (as.character(iwanthue(length(topX_phylum)+1))),
                    name = "Top 8 most abundant Phylum") +
  facet_grid( ~ Location, scales = "free_x", space = "free_x") + 
  theme_classic() +
  my_theme

#plot rel abundance sorted by Season
ggplot(my_data_clean_small_plot, 
       aes(x = Sample, y = Phylum_abundance, 
           # we sort the top phyla alphabetically, then add "Other" at the end
           fill = factor(Phylum, c(sort(topX_phylum), "Other")))) + 
  geom_bar(stat = "identity", position = "fill") + 
  labs(x = "Sample", y = "Relative abundance") + 
  scale_y_continuous(expand = c(0.02, 0), labels = scales::percent_format()) +
  scale_fill_manual(values = c(as.character(iwanthue(length(topX_phylum)+1))),
                    name = "Top 8 most abundant Phylum") +
  facet_grid( ~ Season, scales = "free_x", space = "free_x") + 
  theme_classic() +
  my_theme


# Write data --------------------------------------------------------------

