getwd()
setwd()
##I recomend you to install Biocmanager 
install.packages("BiocManager")

##Then it is easier to install the rest of the boconductor packages 
BiocManager::install("edgeR")
BiocManager::install("limma")
BiocManager::install("gplots")
BiocManager::install("org.Mm.eg.db")
BiocManager::install("RColorBrewer")
BiocManager::install("Glimma")
library(edgeR)
library(limma)
library(gplots)
library(org.Mm.eg.db)
library(RColorBrewer)
library(Glimma)