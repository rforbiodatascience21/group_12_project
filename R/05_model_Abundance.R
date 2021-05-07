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
topX_phylum <- topX(my_data_clean_aug, 8)

my_data_clean_aug_plot <- my_data_clean_aug %>%
  mutate(Phylum = case_when(Phylum %in% topX_phylum ~ Phylum, 
                            T ~ "Other")) %>% 
  group_by(Sample, Phylum, Location, Season) %>% 
  summarise(Phylum_abundance = sum(Abundance)) %>%
  ungroup()


# Visualise data ----------------------------------------------------------
#plot rel abundance sorted by location
ggplot(my_data_clean_aug_plot, 
       aes(x = Sample, 
           y = Phylum_abundance, 
           # we sort the top phyla alphabetically, then add "Other" at the end
           fill = factor(Phylum, c(sort(topX_phylum), "Other")))) + 
  geom_bar(stat = "identity", position = "fill") + 
  labs(x = "Sample", 
       y = "Relative abundance") + 
  scale_y_continuous(expand = c(0.02, 0), 
                     labels = scales::percent_format()) +
  scale_fill_manual(values = c(as.character(iwanthue(length(topX_phylum)+1))),
                    name = "Top 8 most abundant Phylum") +
  facet_grid( ~ factor(Location, levels = location), 
              scales = "free_x", 
              space = "free_x") + 
  theme_classic() +
  my_theme


# Write data --------------------------------------------------------------

