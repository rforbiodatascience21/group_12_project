# Define project functions ------------------------------------------------
topX <- function(data, X){
  total_abun <- data %>% 
    group_by(Sample) %>% 
    summarise(total_abundance = sum(Abundance))
  
  top_phylum <- data %>% 
    left_join(total_abun) %>% 
    mutate(rel_abundance = Abundance / total_abundance) %>% 
    group_by(Phylum) %>%
    summarise(sum_rel_abundance = sum(rel_abundance)) %>% 
    top_n(X, sum_rel_abundance) %>%
    pull(Phylum) 
  
  return(top_phylum)
}


#save plot theme
my_theme <- theme(axis.text = element_text(colour = "black"),
                  axis.text.x = element_text(angle = 90, 
                                             hjust = 1,
                                             vjust = 0.5, 
                                             size = 8),
                  panel.border = element_rect(linetype = "solid", 
                                              fill = NA,
                                              size = 0.5),
                  axis.line = element_blank(),
                  strip.background = element_blank(),
                  legend.key.size = unit(x = 0.4, 
                                         units = "cm"))



#vector of order of Location
location = c("Upstream", "Wastewater", "Discharge", "Downstream" )

