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
#calculate samplewise total abundance
total_abun <- my_data_clean_aug %>% 
    group_by(Sample) %>% 
    summarise(total_abundance = sum(Abundance))
 
#find 8 most abundant phylum 
top_phylum <- my_data_clean_aug %>% 
    left_join(y = total_abun) %>% 
    mutate(rel_abundance = Abundance / total_abundance) %>% 
    group_by(Phylum) %>%
    summarise(sum_rel_abundance = sum(rel_abundance)) %>% 
    top_n(n = 8) %>%
    pull(Phylum) 

my_data_clean_aug_plot <- my_data_clean_aug %>%
  mutate(Phylum = case_when(Phylum %in% top_phylum ~ Phylum, 
                            Phylum %in% top_phylum == FALSE ~ "Other")) %>% 
  group_by(Phylum, Location, Season) %>% 
  summarise(Phylum_abundance = sum(Abundance)) %>%
  ungroup()

#make factor level for top phyla alphabetically, then add "Other" at the end
plot_data <- my_data_clean_aug_plot %>% 
  mutate(Phylum = factor(x = Phylum, 
                         levels = c(top_phylum, "Other")))

#make color vector
color_code <- plot_data %>%
  distinct(Phylum) %>% 
  count() %>% 
  pull() %>% 
  iwanthue() 

#save plot theme
my_theme <- theme(axis.text = element_text(colour = "black"),
                  axis.text.x = element_text(angle = 45, 
                                             hjust = 1,
                                             vjust = 1, 
                                             size = 8),
                  panel.border = element_rect(linetype = "solid", 
                                              fill = NA,
                                              size = 0.5),
                  axis.line = element_blank(),
                  strip.background = element_blank(),
                  legend.key.size = unit(x = 0.4, 
                                         units = "cm"))

# Visualise data ----------------------------------------------------------
#plot rel abundance sorted by Season and Location
plot_rel_abundance_Location <- ggplot(plot_data, 
       aes(x = factor(Location, level = location_order), 
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
  facet_grid(~Season) + 
  theme_classic() +
  my_theme


#plot rel abundance sorted by Season and Location
plot_rel_abundance_season <- ggplot(plot_data, 
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
  facet_grid(~ factor(Location,
                       level = location_order)) + 
  theme_classic() +
  my_theme


# Write data --------------------------------------------------------------
ggsave(filename = "06_abundance_location.png", 
       path = "/cloud/project/figures", 
       plot = plot_rel_abundance_Location, 
       device = "png", 
       width = 8, 
       height = 4,
       dpi = 136)

ggsave(filename = "06_abundance_season.png", 
       path = "/cloud/project/figures", 
       plot = plot_rel_abundance_season, 
       device = "png", 
       width = 8, 
       height = 4, 
       dpi = 136)
