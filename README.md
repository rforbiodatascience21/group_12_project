# group_12_project
In this project we explore the bacterial compositions of communities from samples from a creek near an antibiotics production facility in Croatia. 
The data consists of an OTU count table and a metadata table with information about sampling location and season. This data comes from the an article published by Milena Milaković et.al (https://www.sciencedirect.com/science/article/pii/S0048969719359972)

The full analysis pipeline can be performed simply by running the "00_doit.R" script

This pipeline include the following scripts:

R/01_load.R - Loads the "not-flat" datafile and rewrite it to a flat tsv.gz file. 

R/02_clean.R - Joins the OTU table with the metadata, and then cleans the combined data table.

R/03_augment.R - Creates two data files ready for analysis, one for with all NA's included for summary of raw data size and one ready for modelling.

R/04_model_table.R - Makes a table of sample and OTU counts prior to cleaning, outputs the table as a .png file.

R/05_model_NA_bar_chart.R - Outputs a barchart showing the number of NA's at each taxonomic level prior to data prior to NA-filtering.

R/06_model_abundance.R - Calculates relative abundance at Phyla level, generates a nice plot as output.

R/07_model_alphadiversity.R - Calculates a Shannon-Weaver index and outputs a boxplot with the results.

R/08_model_nmds.R - Outputs a NMDS plot for all the samples based on bray curtis dissimilarity.
