# Clear workspace ---------------------------------------------------------
rm(list = ls())
#
#install.packages("cowplot")
# Load libraries ----------------------------------------------------------
library("tidyverse")
library("hues")

# Define functions --------------------------------------------------------
source(file = "R/99_functions.R")

# Load data ---------------------------------------------------------------
my_data_clean_aug <- read_tsv(file = "data/03_my_data_clean_aug.tsv.gz")

# Wrangle data ------------------------------------------------------------
my_data_clean_small <- my_data_clean_aug %>%
  select(Taxa, Samples, OTU_Count, site)

# Get total OTU_Count for each sample
my_data_total_OTU_Count <- my_data_clean_small %>% 
  group_by(Samples) %>% 
  summarise(total_OTU_Count = sum(OTU_Count))


my_data_clean_small_plot <- my_data_clean_small  %>% 
  # Group by phyla name and sum up for each "phyla". This is only necessary to sum
  # up the values for all genes now named "Other"
  group_by(Samples, Taxa, site) %>% 
  summarise(phyla_OTU_Count = sum(OTU_Count)) %>% 
  # Add metadata
  ungroup()

data_len <- nrow(distinct(my_data_clean_small_plot, Taxa))

# Visualise data ----------------------------------------------------------
ggplot(my_data_clean_small_plot,
       aes(x = Samples, 
           y = phyla_OTU_Count, 
           # we sort the top phyla alphabetically, then add "Other" at the end
           fill = factor(Taxa))) + 
  geom_bar(stat = "identity", position = "fill") + 
  labs(x = "Sample", y = "Relative abundance") + 
  scale_y_continuous(expand = c(0.02, 0)) +
  scale_fill_manual(values = c(as.character(iwanthue(data_len)))) +
  facet_grid( ~ site, scales = "free_x", space = "free_x") + 
  theme_classic() +
  theme(axis.text = element_text(colour = "black"),
        axis.text.x = element_text(angle = 90, hjust = 1, vjust = 0.5, size = 8),
        panel.border = element_rect(linetype = "solid", fill = NA,
                                    size = 0.5),
        axis.line = element_blank(),
        strip.background = element_blank(),
        legend.key.size = unit(0.4, "cm"))

# Write data --------------------------------------------------------------

