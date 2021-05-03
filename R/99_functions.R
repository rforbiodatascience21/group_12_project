# Define project functions ------------------------------------------------
library("tidyverse")
library("hues")

my_data_clean_aug <- read_tsv(file = "data/03_my_data_clean_aug.tsv.gz")
my_data_clean_small <- my_data_clean_aug %>%
  select(Sample, Abundance, Season, Location, Phylum)


#Function to calculate X most abundant phylum in samples while the rest is 
#grouped in "Other"
rel_topX <- function(data, X){

  total_count <- data %>% 
    group_by(Sample) %>% 
    summarise(total_abundance = sum(Abundance))
  
  top_phylum <- data %>%
    left_join(total_count) %>%
    mutate(rel_abundance = Abundance / total_abundance) %>%
    group_by(Phylum) %>%
    summarise(sum_rel_abundance = sum(rel_abundance)) %>%
    top_n(., X, sum_rel_abundance) %>%
    pull(., Phylum)
  
  topX <- data %>%
    #classify all other phylum as "Other"
    mutate(Phylum = case_when(Phylum %in% top_phylum ~ Phylum, T ~ "Other")) %>% 
    #sum up for each Phylum for the ones named "Other"
    group_by(Sample, Phylum, Location) %>% 
    summarise(Phylum_abundance = sum(Abundance)) %>%
    # Add metadata
    ungroup()
  
  return(topX)
}


#Function to calculate vector of X most abundant phylum in samples with rest
#is grouped in "Other"
topX <- function(data, X){
  top_phylum <- data %>%
    group_by(Phylum) %>%
    summarise(sum_abundance = sum(Abundance)) %>%
    top_n(., X, sum_abundance) %>%
    pull(., Phylum)
  
  return(top_phylum)
}





