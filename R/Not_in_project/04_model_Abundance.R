# Clear workspace ---------------------------------------------------------
rm(list = ls())

# Load libraries ----------------------------------------------------------
library("tidyverse")
library("hues")
library("forcats")
library("dplyr")
library("stringr")

# Define functions --------------------------------------------------------
source(file = "R/99_functions.R")

# Load data ---------------------------------------------------------------
my_data_clean_aug <- read_tsv(file = "data/03_my_data_clean_aug.tsv.gz")

# Wrangle data ------------------------------------------------------------
topX_phylum <- topX(data = my_data_clean_aug, 
                    X = 8)

my_data_clean_aug_plot <- my_data_clean_aug %>%
  mutate(Phylum = case_when(Phylum %in% topX_phylum ~ Phylum, 
                            Phylum %in% topX_phylum == FALSE ~ "Other")) %>% 
  group_by(Sample, Phylum, Location, Season) %>% 
  summarise(Phylum_abundance = sum(Abundance)) %>%
  ungroup()

#make factor level for top phyla alphabetically, then add "Other" at the end
plot_data <- my_data_clean_aug_plot %>% 
  mutate(Phylum = factor(x = Phylum, 
                         levels = c(topX_phylum, "Other")))
  
#make color vector
color_code <- plot_data %>%
  distinct(Phylum) %>% 
  count() %>% 
  pull() %>% 
  iwanthue() 

# Visualise data ----------------------------------------------------------
#plot rel abundance sorted by location
plot_rel_abundance <- ggplot(plot_data, 
       aes(x = Sample, 
           y = Phylum_abundance,
           fill = Phylum)) + 
  geom_bar(stat = "identity",
           position = "fill") + 
  labs(x = "Sample", 
       y = "Relative abundance",
       title = "Relative abundance of 8 most abundant Phyla in samples") + 
  scale_y_continuous(expand = c(0.02, 0), 
                     labels = scales::percent_format()) +
  scale_fill_manual(values = color_code,
                    name = "Top 8 most abundant Phylum") +
  facet_grid( ~ factor(Location, 
                       levels = location), 
              scales = "free_x", 
              space = "free_x") + 
  theme_classic() +
  my_theme

# Write data --------------------------------------------------------------
ggsave(filename = "08_mean_abundance_location.png", 
       path = "/cloud/project/figures", 
       plot = ggsave(filename = "04_abundance_sample.png", 
                     path = "/cloud/project/figures", 
                     plot = plot_rel_abundance, 
                     device = "png", 
                     width = 8, 
                     height = 4, 
                     dpi = 136))
