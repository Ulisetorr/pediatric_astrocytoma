getwd()
setwd("/Users/abrahan/Documents/FernandaRNA")
##For installation first download BiocManager
if (!requireNamespace("BiocManager", quietly = TRUE))
install.packages("BiocManager")
##Then use de "BiocManager install" to install the library
BiocManager::install("edgeR")
#finally call both libraries 
library(limma)
library(edgeR)
###If you only have SAM/BAM files, you can download the Subread package to use featureCounts.
##Upload data
data(`21_astrocytoma`)
##Create a DGElist with the sample's annotation
## Loading required packages 
## If  intsallation is needed use the BiocManager install
library(MASS)
library(lattice)
library(ggplot2)
library(RColorBrewer)
library(mixOmics)
library(HTSFilter)
library(parallel)
library(BiocGenerics)
library(Biobase)
##Set de directory 
directory <- ("/Users/abrahan/Documents/FernandaRNA/Conteo/featureCounts")
dir(directory)
##Load raw count table
rawCountTable <- read.csv("21_astrocytoma.csv", header = TRUE, row.names=1)
sampleInfo <- read.csv("Anotaciones_tumores_r.csv", header=TRUE,row.names=1)
#Check table 
head(rawCountTable)
sampleInfo
#Check number of genes
nrow(rawCountTable)
##Check if we have data for every single metadata

###Create DGElist
dgeFull <- DGEList(rawCountTable, group=sampleInfo$Histopatologic_group)
dgeFull
###Add the sample information object in the DGEList data
dgeFull$sampleInfo <- sampleInfo
dgeFull

##First Data exploration and quality assessment
##Extract pseudo-counts (ie \(\log_2(K+1)\))
pseudoCounts <- log2(dgeFull$counts+1)
head(pseudoCounts)
#Boxplot for pseudo-counts
boxplot(pseudoCounts, col="gray")
#MDS for pseudo-counts
plotMDS(pseudoCounts)
# heatmap for pseudo-counts
#1.Create matrix w/ pseudocounts
sampleDists <- as.matrix(dist(t(pseudoCounts)))
#2. Plot Heat-map
cimColor <- colorRampPalette(rev(brewer.pal(9, "Blues")))(16)
cim(sampleDists, color = cimColor, symkey=FALSE)
#If the error Error in plot.new() : figure margins too large apears:
###The display image will be large, so try to y zoom out your "Files, Plots, Packages, Help, Viewer"



##To add human readeable gene symbols
BiocManager::install("org.Mm.eg.db")

##DGElist w/ edgeR
group <- factor(paste0(sampleInfo$Histopatologic_group))
y <- DGEList(rawCountTable, group = group)
colnames(y) <- sampleInfo$sample

##Filter--> Only retained genes that are expressed at the minimum level 
keep <- filterByExpr(y)
summary(keep)
y <- y[keep, , keep.lib.sizes=FALSE]


##Normalization TMM
y <- calcNormFactors(y)
y$samples
plotMD(cpm(y, log=TRUE), column=1)
abline(h=0, col="red", lty=2, lwd=2)


##DATA EXPLORATION 
#multi-dimensional scaling (MDS) plots
points <- c(0,1,2,15,16,17)
colors <- rep(c("blue", "darkgreen", "red"), 2)
plotMDS(y, col=colors[group], pch=points[group])
legend("topleft", legend=levels(group), pch=points, col=colors, ncol=2)


##Design matrix
#Design a matrix that contains the informatiomn of each group 
design <- model.matrix(~ 0 + group)
colnames(design) <- levels(group)
design

#Estimate dispersion 
library(satatmode)
y <- estimateDisp(y, design, robust=TRUE)
y$common.dispersion


##Differential expression 
