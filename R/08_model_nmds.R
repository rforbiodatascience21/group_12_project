# Clear workspace ---------------------------------------------------------
rm(list = ls())

#install.packages("cowplot")
# Load libraries ----------------------------------------------------------
library("tidyverse")
library("tidyr")
library("vegan")


# Define functions --------------------------------------------------------
source(file = "R/99_functions.R")

# Load data ---------------------------------------------------------------
my_data_clean_aug <- read_tsv(file = "data/03_my_data_clean_aug.tsv.gz")

# Wrangle data ------------------------------------------------------------

my_data_clean_aug_wide <- my_data_clean_aug %>%
  select(., OTU, Abundance, Sample, Season, Location) %>%
  pivot_wider(names_from = OTU, values_from = Abundance)

my_data_clean_aug_wide_smaller <- my_data_clean_aug_wide %>%
  select(., -Sample, -Season, -Location)

nmds = metaMDS(my_data_clean_aug_wide_smaller, distance = "bray")

plot(nmds)

scores_nmds <- as_tibble(scores(nmds))

#add columns to data frame
my_data_clean_aug_wide_joined <- my_data_clean_aug_wide %>%
  select(., Sample, Season, Location) %>%
  bind_cols(scores_nmds)
  
plot_nmds <- my_data_clean_aug_wide_joined %>%
  ggplot(., aes(x=NMDS1, y=NMDS2)) + 
  geom_point(size =4, aes( shape = Season, colour = Location)) +
  labs(x = "NMDS1", colour = "Location", y = "NMDS2", shape = "Season")
plot_nmds


xx = ggplot(data.scores, aes(x = NMDS1, y = NMDS2)) + 
  geom_point(size = 4, aes( shape = Type, colour = Time))+ 
  theme(axis.text.y = element_text(colour = "black", size = 12, face = "bold"), 
        axis.text.x = element_text(colour = "black", face = "bold", size = 12), 
        legend.text = element_text(size = 12, face ="bold", colour ="black"), 
        legend.position = "right", axis.title.y = element_text(face = "bold", size = 14), 
        axis.title.x = element_text(face = "bold", size = 14, colour = "black"), 
        legend.title = element_text(size = 14, colour = "black", face = "bold"), 
        panel.background = element_blank(), panel.border = element_rect(colour = "black", fill = NA, size = 1.2),
        legend.key=element_blank()) + 
  labs(x = "NMDS1", colour = "Time", y = "NMDS2", shape = "Type")  + 
  scale_colour_manual(values = c("#009E73", "#E69F00")) 

xx
stressplot(nmds)
ggsave("NMDS.svg")



# Write data --------------------------------------------------------------

