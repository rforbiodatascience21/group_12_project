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
topX_phylum <- topX(data = my_data_clean_aug, 
                    X = 8)

my_data_clean_aug_plot <- my_data_clean_aug %>%
  mutate(Phylum = case_when(Phylum %in% topX_phylum ~ Phylum, 
                            Phylum %in% topX_phylum == FALSE ~ "Other")) %>% 
  group_by(Phylum, Location, Season) %>% 
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
#plot rel abundance sorted by Season and Location
plot_rel_abundance_Location <- ggplot(plot_data, 
       aes(x = Location, 
           y = Phylum_abundance, 
           fill = Phylum)) + 
  geom_bar(stat = "identity", 
           position = "fill") + 
  labs(x = "Location", 
       y = "Relative abundance",
       title = "Relative abundance of 8 most abundant phylum by locations") + 
  scale_y_continuous(expand = c(0.02, 0), 
                     labels = scales::percent_format()) +
  scale_fill_manual(values = color_code,
                    name = "Top 8 most abundant Phylum") +
  facet_grid( ~ Season) + 
  theme_classic() +
  my_theme

plot_rel_abundance_Location

#plot rel abundance sorted by Season and Location
plot_rel_abundance_season <- ggplot(my_data_clean_aug_plot, 
       aes(x = Season, 
           y = Phylum_abundance, 
           fill = Phylum)) + 
  geom_bar(stat = "identity", 
           position = "fill") + 
  labs(x = "Season", 
       y = "Relative abundance",
       title = "Relative abundance of 8 most abundant phylum by season") + 
  scale_y_continuous(expand = c(0.02, 0), 
                     labels = scales::percent_format()) +
  scale_fill_manual(values = color_code,
                    name = "Top 8 most abundant Phylum") +
  facet_grid( ~ Location) + 
  theme_classic() +
  my_theme

# Write data --------------------------------------------------------------
ggsave(filename = "08_mean_abundance_location.png", 
       path = "/cloud/project/figures", 
       plot = plot_rel_abundance_Location, 
       device = "png", 
       width = 8, 
       height = 4,
       dpi = 136)

ggsave(filename = "08_mean_abundance_location.png", 
       path = "/cloud/project/figures", 
       plot = ggsave(filename = "08_mean_abundance_season.png", 
       path = "/cloud/project/figures", 
       plot = plot_rel_abundance_season, 
       device = "png", 
       width = 8, 
       height = 4, 
       dpi = 136))
