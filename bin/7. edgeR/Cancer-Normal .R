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
GR <- factor(paste0(sampleinfo$Pathology))
h <- DGEList(seqdata, group=GR)
colnames(h) <- sampleinfo$Sample

##Normalization and filtering
##Filter genes with enough reads
keep <- filterByExpr(y)
summary(keep)
h <- h[keep, , keep.lib.sizes=FALSE]

##Normalization
h <- calcNormFactors(h)
h$samples


##-------
#Quality control
h$samples$lib.size
barplot(h$samples$lib.size,names=colnames(h),las=2)
title("Barplot of library sizes")
logcounts_h <- cpm(h,log=TRUE)
boxplot(logcounts_h, xlab="", ylab="Log2 counts per million",las=2)
abline(h=median(logcounts),col="blue")
title("Boxplots of logCPMs")
##-----



##Differential expression 
group
##Design Matrix
design_h <- model.matrix(~0+GR, data=h$samples)
colnames(design_h) <- levels(GR)
design_h

###Estimate dispersion
h <- estimateDisp(h, design_h, robust=TRUE)
h$common.dispersion
plotBCV(h)
##glmTest
fit_h <- glmQLFit(h, design_h)

##MakeContrasts
con <- makeContrasts(Normal-Cancer, levels = design_h)
##Genes in group I 
qlf_h <- glmQLFTest(fit_h, contrast=con)
topTags(qlf_h)
summary(decideTests(qlf_h))
##Genes in group I 
qlf <- glmQLFTest(fit, contrast=my.contrasts[,"IvsAll"])
topTags(qlf)
summary(decideTests(qlf))
write.csv(qlf$table, "~/Documents/Maestria/Taller_Bioinfo/pediatric_astrocytoma/qlfI.csv")
tr <- glmTreat(fit, contrast=my.contrasts[,"IvsAll"], lfc=log2(2.0))
topTags(tr)
summary(decideTests(tr))
head
