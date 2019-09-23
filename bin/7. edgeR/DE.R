getwd()
setwd("~/Documents/FernandaRNA/pediatric_astrocytoma")
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

##Upload data
##Your working directory must be pediartic_astocytoma
seqdata <- read.csv("data/21_astrocytoma.csv", header = TRUE, row.names=1)
sampleinfo <- read.csv("meta/Anotaciones_tumores_r.csv")
##Check data
head(seqdata)
dim(seqdata)
sampleinfo
##Check if the order of the samples from the Count-table are the same as in the meta
table(colnames(seqdata)==sampleinfo$Sample)


###Create your DGElist 
#DGElist w/ edgeR
#Select a category to compare 
group <- factor(paste0(sampleinfo$Histopatologic_group))
#Create the DGE 
dgeH<- DGEList(seqdata, group=group)
#Name your columns
colnames(dgeH) <- sampleinfo$Sample
##Normalization and filtering
##Filter genes with enough reads
keep <- filterByExpr(dgeH)
summary(keep)
dgeH <- dgeH[keep, , keep.lib.sizes=FALSE]

##Normalization
y <- calcNormFactors(dgeH)
y$samples

##-------
#Quality control
y$samples$lib.size
barplot(y$samples$lib.size,names=colnames(y),las=2)
title("Count depth")
logcounts <- cpm(y,log=TRUE)
boxplot(logcounts, xlab="", ylab="Log2 counts per million",las=2)
abline(h=median(logcounts),col="blue")
title("Boxplots of logCPMs")
##-----

##Multidimensional scaling plots
#General plot
plotMDS(y)
##Plot according to the variable
#specify the option to let us plot two plots side-by-sde
par(mfrow=c(1,2))
#According to the Histopatology gorup
levels(sampleinfo$Histopatologic_group)
col.cell <- c("purple","orange","pink","red", "dark green", "blue")[sampleinfo$Histopatologic_group]
data.frame(sampleinfo$Histopatologic_group,col.cell)
plotMDS(y,col=col.cell)
legend("topleft",fill=c("purple","orange","pink","red", "dark green", "blue"),legend=levels(sampleinfo$Histopatologic_group))
title("Histopatologic group")
#According to the condition (nomal-cancer)
col.status <- c("blue","red","dark green")[sampleinfo$Pathology]
col.status
plotMDS(y,col=col.status)
legend("topleft",fill=c("blue","red","dark green"),legend=levels(sampleinfo$Pathology),cex=0.8)
title("Condition")

####--------------------


##HeatMaps
library(pheatmap)

var_genes <- apply(logcounts, 1, var)
head(var_genes)
select_var <- names(sort(var_genes, decreasing=TRUE))[1:500]
head(select_var)
# Subset logcounts matrix
highly_variable_lcpm <- logcounts[select_var,]
dim(highly_variable_lcpm)

## Get some nicer colours
mypalette <- brewer.pal(11,"RdYlBu")
morecols <- colorRampPalette(mypalette)
# Set up colour vector for celltype variable
col.cell <- c("purple","orange","pink","red", "dark green", "blue")[sampleinfo$Histopatologic_group]
# Plot the heatmap
heatmap.2(highly_variable_lcpm,col=rev(morecols(50)),trace="none",
          labCol=sampleinfo$Histopatologic_group, main="Top 500 most variable genes across samples",
          ColSideColors=col.cell,scale="row")
library(pheatmap)
pheatmap(highly_variable_lcpm, color = colorRampPalette(rev(brewer.pal(n = 7, name = "RdYlBu")))(100), 
         kmeans_k = NA, breaks = NA, border_color = "grey60", 
         cellwidth = NA, cellheight = NA, scale = "none", cluster_rows = TRUE,
         cluster_cols = TRUE, clustering_distance_rows = "euclidean",
         labels_col = group, 
         main = "Top 500 most variable genes across samples",
         clustering_distance_cols = "euclidean", clustering_method = "complete",
         cutree_rows = NA, cutree_cols = NA, drop_levels =TRUE, show_colnames = TRUE)

###----------------------------------

###----------------------------------
install.packages("statmod")
library(statmod)
##Differential expression 
group
##Design Matrix
design <- model.matrix(~0+group, data=y$samples)
colnames(design) <- levels(group)
design
###Estimate dispersion
y <- estimateDisp(y, design, robust=TRUE)
y$common.dispersion
plotBCV(y)
##glmTest
fit <- glmQLFit(y, design)
##Make contrasts
my.contrastsI_B <- makeContrasts(
        conC = I_B-Control,
        conCC = I_B-ControlC,
        conII = I_B-II,
        conIII = I_B-III, 
        conIV = I_B-IV, 
        levels=design)
##Differentail exxpresion 
qlfC <- glmQLFTest(fit, contrast=my.contrastsI_B[,"conC"])
qlfCC <- glmQLFTest(fit, contrast=my.contrastsI_B[,"conCC"])
qlfII <- glmQLFTest(fit, contrast=my.contrastsI_B[,"conII"])
qlfIII <- glmQLFTest(fit, contrast=my.contrastsI_B[,"conIII"])
qlfIV <- glmQLFTest(fit, contrast=my.contrastsI_B[,"conIV"])

###Create output files w/ Differential exxpresion values
write.csv(qlfC$table, "~/Documents/FernandaRNA/pediatric_astrocytoma/DEControl-I.csv")
write.csv(qlfCC$table, "~/Documents/FernandaRNA/pediatric_astrocytoma/DEControlC-I.csv")
write.csv(qlfII$table, "~/Documents/FernandaRNA/pediatric_astrocytoma/DEII-I.csv")
write.csv(qlfIII$table, "~/Documents/FernandaRNA/pediatric_astrocytoma/DEControlIII-I.csv")
write.csv(qlfIV$table, "~/Documents/FernandaRNA/pediatric_astrocytoma/DEIV-IV.csv")

#Load new data 
C <- (read.csv("~/Documents/FernandaRNA/pediatric_astrocytoma/DEControl-I.csv", header = TRUE))
CC <- (read.csv("~/Documents/FernandaRNA/pediatric_astrocytoma/DEControlC-I.csv", header = TRUE))
II <- (read.csv("~/Documents/FernandaRNA/pediatric_astrocytoma/DEII-I.csv", header = TRUE))
III <- (read.csv("~/Documents/FernandaRNA/pediatric_astrocytoma/DEControlIII-I.csv", header = TRUE))
IV <- (read.csv("~/Documents/FernandaRNA/pediatric_astrocytoma/DEIV-IV.csv", header = TRUE))
###Choose genes that intersect 

install.packages("dplyr")
library(dplyr)

new_data <- merge(C, CC, II, III, IV, by = ncol(1))




topTags(qlfI)

plotMD(qlfI)
