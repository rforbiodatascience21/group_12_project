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
#plot rel abundance sorted by Season and Location
plot_rel_abundance_Location <- ggplot(my_data_clean_aug_plot, 
       aes(x = Location, y = Phylum_abundance, 
           # we sort the top phyla alphabetically, then add "Other" at the end
           fill = factor(Phylum, c(sort(topX_phylum), "Other")))) + 
  geom_bar(stat = "identity", 
           position = "fill") + 
  labs(x = "Location", 
       y = "Relative abundance") + 
  scale_y_continuous(expand = c(0.02, 0), 
                     labels = scales::percent_format()) +
  scale_fill_manual(values = c(as.character(iwanthue(length(topX_phylum)+1))),
                    name = "Top 8 most abundant Phylum") +
  facet_grid( ~ Season, 
              scales = "free_x", 
              space = "free_x") + 
  theme_classic() +
  my_theme

#plot rel abundance sorted by Season and Location
plot_rel_abundance_season <- ggplot(my_data_clean_aug_plot, 
       aes(x = Season, y = Phylum_abundance, 
           # we sort the top phyla alphabetically, then add "Other" at the end
           fill = factor(Phylum, c(sort(topX_phylum), "Other")))) + 
  geom_bar(stat = "identity", 
           position = "fill") + 
  labs(x = "Season", 
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
ggsave(filename = "08_mean_abundance_location.png", 
       path = "/cloud/project/figures", 
       plot = plot_rel_abundance_Location, 
       device = "png", 
       width = 16, 
       height = 9, 
       dpi = 136)

ggsave(filename = "08_mean_abundance_location.png", 
       path = "/cloud/project/figures", 
       plot = ggsave(filename = "08_mean_abundance_season.png", 
       path = "/cloud/project/figures", 
       plot = plot_rel_abundance_season, 
       device = "png", 
       width = 16, 
       height = 9, 
       dpi = 136)
