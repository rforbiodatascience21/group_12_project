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


topX_phylum <- rel_topX(my_data_clean_small, 8)

my_data_clean_small_rel_plot <- produce_topX(my_data_clean_small, topX_phylum)



# Visualise data ----------------------------------------------------------
ggplot(topX_phylum, aes(x = Sample, y = Phylum_abundance, 
           # we sort the top phyla alphabetically, then add "Other" at the end
           fill = factor(Phylum))) + 
  geom_bar(stat = "identity", position = "fill") + 
  labs(x = "Sample", y = "Relative abundance") + 
  scale_y_continuous(expand = c(0.02, 0), labels = scales::percent_format()) +
  scale_fill_manual(values = c(as.character(iwanthue(nrow(distinct(topX_phylum, Phylum)))))) +
  facet_grid( ~ Location, scales = "free_x", space = "free_x") + 
  theme_classic() +
  theme(axis.text = element_text(colour = "black"),
        axis.text.x = element_text(angle = 90, hjust = 1, vjust = 0.5, size = 8),
        panel.border = element_rect(linetype = "solid", fill = NA,
                                    size = 0.5),
        axis.line = element_blank(),
        strip.background = element_blank(),
        legend.key.size = unit(0.4, "cm"))



ggplot(my_data_clean_small_plot,
       aes(x = Sample, y = Phylum_abundance, 
           # we sort the top phyla alphabetically, then add "Other" at the end
           fill = factor(Phylum))) + 
  geom_bar(stat = "identity") + 
  labs(x = "Sample", y = "Abundance") + 
  scale_y_continuous(expand = c(0.02, 0)) +
  scale_fill_manual(values = c(as.character(iwanthue(nrow(distinct(my_data_clean_small_plot, Phylum)))))) +
  facet_grid( ~ Location, scales = "free_x", space = "free_x") + 
  theme_classic() +
  theme(axis.text = element_text(colour = "black"),
        axis.text.x = element_text(angle = 90, hjust = 1, vjust = 0.5, size = 8),
        panel.border = element_rect(linetype = "solid", fill = NA,
                                    size = 0.5),
        axis.line = element_blank(),
        strip.background = element_blank(),
        legend.key.size = unit(0.4, "cm"))



# Write data --------------------------------------------------------------

