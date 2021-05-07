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
#find most abundant phylum
topX_phylum <- topX(my_data_clean_aug, 8)

my_data_clean_aug_plot <- my_data_clean_aug %>%
  mutate(Phylum = case_when(Phylum %in% topX_phylum ~ Phylum, 
                            T ~ "Other")) %>% 
  group_by(Phylum, Location, Season) %>% 
  summarise(Phylum_abundance = sum(Abundance)) %>%
  ungroup()


# Visualise data ----------------------------------------------------------
#save plot theme
my_theme <- theme(axis.text = element_text(colour = "black"),
                  axis.text.x = element_text(angle = 90, hjust = 1, vjust = 0.5, size = 8),
                  panel.border = element_rect(linetype = "solid", fill = NA,
                                              size = 0.5),
                  axis.line = element_blank(),
                  strip.background = element_blank(),
                  legend.key.size = unit(0.4, "cm"))

#plot rel abundance sorted by Season and Location
ggplot(my_data_clean_aug_plot, 
       aes(x = Location, y = Phylum_abundance, 
           # we sort the top phyla alphabetically, then add "Other" at the end
           fill = factor(Phylum, c(sort(topX_phylum), "Other")))) + 
  geom_bar(stat = "identity", position = "fill") + 
  labs(x = "Location", y = "Relative abundance") + 
  scale_y_continuous(expand = c(0.02, 0), labels = scales::percent_format()) +
  scale_fill_manual(values = c(as.character(iwanthue(length(topX_phylum)+1))),
                    name = "Top 8 most abundant Phylum") +
  facet_grid( ~ Season, scales = "free_x", space = "free_x") + 
  theme_classic() +
  my_theme

# Write data --------------------------------------------------------------
