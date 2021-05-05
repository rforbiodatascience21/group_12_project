# Define project functions ------------------------------------------------
topX <- function(data, X){
  top_phylum <- data %>%
    group_by(Phylum) %>%
    summarise(sum_rel_abundance = sum(rel_abundance)) %>%
    top_n(X, sum_rel_abundance) %>%
    pull(Phylum)
  return(top_phylum)
}


#Function to calculate X most abundant phylum in samples while the rest is 
#grouped in "Other"
produce_topX <- function(data, top_phylum) { 
  topX <- data %>%
    #classify all other phylum as "Other"
    mutate(Phylum = case_when(Phylum %in% top_phylum ~ Phylum, T ~ "Other")) %>% 
    #sum up for each Phylum for the ones named "Other"
    group_by(Sample, Phylum, Location, Season) %>% 
    summarise(Phylum_abundance = sum(Abundance)) %>%
    # Add metadata
    ungroup()
  
  return(topX)
}







