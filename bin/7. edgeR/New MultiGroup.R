##https://combine-australia.github.io/RNAseq-R/06-rnaseq-day1.html
getwd()
setwd("~/Documents/Maestria/Taller_Bioinfo/pediatric_astrocytoma")
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

##DGElist w/ edgeR
group <- factor(paste0(sampleinfo$Histopatologic_group))
y <- DGEList(seqdata, group=group)
colnames(y) <- sampleinfo$Sample
##Normalization and filtering
##Filter genes with enough reads
keep <- filterByExpr(y)
summary(keep)
y <- y[keep, , keep.lib.sizes=FALSE]
##Normalization
y <- calcNormFactors(y)
y$samples


##-------
#Quality control
y$samples$lib.size
barplot(y$samples$lib.size,names=colnames(y),las=2)
title("Barplot of library sizes")
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

##HeatMaps
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
heatmap.2(logcounts,col=rev(morecols(50)),trace="none", labCol=sampleinfo$Histopatologic_group, main="Top 500 most variable genes across samples",ColSideColors=col.cell,scale="row")


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
my.contrasts <- makeContrasts(
conC = I-Normal,
conII = I-ControlC,
conII = I-II,
conII = I-III, 
conII = I-IV, 
levels=design)

##Genes in group I 
qlf <- glmQLFTest(fit, contrast=my.contrasts[,"IvsAll"])
topTags(qlf)
summary(decideTests(qlf))
##Genes in group I 
qlf <- glmQLFTest(fit, contrast=my.contrasts[,"IvsAll"])
topTags(qlf)
summary(decideTests(qlf))
write.csv(qlf$table, "~/Documents/Maestria/Taller_Bioinfo/pediatric_astrocytoma/qlfI.csv")
tr <- glmTreat(fit, contrast=my.contrasts[,"IvsAll"], lfc=log2(2.0))
topTags(tr)
summary(decideTests(tr))
head
##HEATMAP 
install.packages(pheatmap)
library(pheatmap)


fit.cont <- contrasts.fit(fit, cont.matrixCI)
fit.cont <- eBayes(fit.cont)
dim(fit.cont)
summa.fit <- decideTests(fit.cont)
summary(summa.fit)
