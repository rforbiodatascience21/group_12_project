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
my_data_wide <- my_data_clean_aug %>%
  select(OTU, Abundance, Sample, Season, Location) %>%
  pivot_wider(names_from = OTU,
              values_from = Abundance)

# Calculate diversity index
shannon <- my_data_wide %>% 
  select(-Season, -Location, -Sample) %>% 
  diversity()

# Placeholder comment
result <- my_data_wide %>% 
  select(Sample, Location, Season) %>% 
  cbind(shannon)

#Plot
plot1 <- result %>% 
  group_by(Location, Season) %>% 
  ggplot(
    aes(x = Location, y = shannon, color = Season)) +
  geom_boxplot()

plot1


#Plot
plot2 <- result %>% 
  group_by(Location, Season) %>% 
  ggplot(
    aes(x = Season, y = shannon, color = Location)) +
  geom_boxplot()

plot2

#Plot
plot3 <- result %>% 
  group_by(Location, Season) %>% 
  ggplot(
    aes(x = Sample, y = shannon, color = Season)) +
  geom_point()

plot3