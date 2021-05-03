
##PCoA map
library(MASS)
library(vegan)
require(ape)
library(reshape2)
library(ggplot2)
library(readr)
library(dplyr)
library(tidyr)
library(RColorBrewer)

pdf('PCoA.abundance.pdf', onefile=TRUE)

table1<-read.table("AbundanceTable.top20genus.txt", sep="", dec=".", header=TRUE, row.names=1)
table2<-t(table1)
distbray<-vegdist(table2, method="bray", binary=FALSE, na.rm=TRUE)
#table1<-read.table("fiber.tree2.tre1.weighted.phylip.dist", sep="", dec=".", header=TRUE)
res <- pcoa(distbray, correction="none", rn=NULL)
summary(res)
biplot(res,main="PCoA of top 20 bacteria genus")
ordiplot(res)


##ResFinder
table1 = read.table(file='ResFinder.FPKM_agg_matrix.txt', header=T, check.names=FALSE, sep='\t', row.names=1)

table2<-t(table1)
distbray<-vegdist(table2, method="bray", binary=FALSE, na.rm=TRUE)

res <- pcoa(distbray, correction="none", rn=NULL)
summary(res)
biplot(res,main="PCoA of Resistance genes")
ordiplot(res)

dev.off()

data = read.table("ResFinder.FPKM_agg_matrix.txt", sep="\t", dec = '.',header=TRUE, check.names = F, row.names=1)
myvars <- names(data) %in% c("FPKM_sum","Country", "Continent")
data_drug <- data[!myvars]
drug <- data.frame(data_drug[,2:ncol(data_drug)], row.names=data_drug[,1], check.names=FALSE)
library(vegan)
drug2 <- vegdist(decostand(drug ,method = "hellinger"), dist="bray")
data2 <- read.table("ResFinder_FPKM_Class_FPKM_table_all_tranposed_Continent_sorted.txt", sep="\t", dec = '.',header=TRUE)


