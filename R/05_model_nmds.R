# Clear workspace ---------------------------------------------------------
rm(list = ls())

# Set seed ---------------------------------------------------------
set.seed(1337)

# Load libraries ----------------------------------------------------------
library("tidyverse")
library("vegan")

# Define functions --------------------------------------------------------
source(file = "R/99_functions.R")

# Load data ---------------------------------------------------------------
my_data_clean_aug <- read_tsv(file = "data/03_my_data_clean_aug.tsv.gz")

# Wrangle data ------------------------------------------------------------

my_data_clean_aug_wide <- my_data_clean_aug %>%
  select(OTU, Abundance, Sample,
         Season, Location) %>%
  pivot_wider(names_from = OTU, 
              values_from = Abundance)

my_data_clean_aug_wide_smaller <- my_data_clean_aug_wide %>%
  select(-Sample, -Season, -Location)


#Model data - Using Non-metric multidimentional scaling
nmds = metaMDS(comm = my_data_clean_aug_wide_smaller, 
               distance = "bray")

#Extract wanted output from the model
scores_nmds <- nmds %>%
  scores() %>% 
  as_tibble()

#Extract stresslevel from nmds object
stresslevel <- nmds$stress %>% 
  round(digits = 4) %>% 
  toString()
  

#Prepare output for plotting
my_data_clean_aug_wide_joined <- my_data_clean_aug_wide %>%
  select(Sample, Season, Location) %>%
  bind_cols(scores_nmds)

#Plotting  
plot_nmds <- my_data_clean_aug_wide_joined %>%
  ggplot(aes(x=NMDS1, 
                y=NMDS2)) + 
  geom_point(size = 3, 
             aes(shape = Season, 
                 colour = Location)) +
  labs(x = "NMDS1", 
       colour = "Location", 
       y = "NMDS2", 
       shape = "Season",
       title = "Non metric multidimensional scaling of beta diversity",
       subtitle = "Bray curtis dissimilarity") + 
  annotate("text", 
           x=-4, 
           y=2.5, 
           label = str_c("Stress = ", 
                         stresslevel)) 

# Write data --------------------------------------------------------------
ggsave(filename = "nmds_plot.png",
       path = "/cloud/project/figures", 
       plot = plot_nmds, 
       device = "png", 
       width = 8, 
       height = 5, 
       dpi = 262)