# Analysis of pediatric astrocytoma transcriptome 

In this repository, you will find the basic workflow of a RNA-seq analysis of tumor samples from pediatric astrocytomas. The project aims to cover a differential expression analysis and a Gene set enrichment analysis. 

The libraries were made from Total RNA, (rRNA-depleted) from tumors and contiguous tissue. 


### Objective

Find expression hallmarks that characterized each astrocytoma grade according to the histopathological and molecular classification.

### General workflow
![General workflow](https://github.com/FernandaDiaz12/pediatric_astrocytoma/blob/master/Bulk%20work-flow.png)


### Pre-requisites 

Before starting the analysis here are the programs that need to be installed:

* [FastQC](https://www.bioinformatics.babraham.ac.uk/projects/fastqc/)
* [STAR](https://hbctraining.github.io/Intro-to-rnaseq-hpc-O2/lessons/03_alignment.html)
* [RSeQC](http://rseqc.sourceforge.net/)
* [samtools](http://www.htslib.org/)
* featureCounts [Subread package](http://subread.sourceforge.net/)
* [R](https://www.r-project.org/)
* [GSEA](http://software.broadinstitute.org/gsea/index.jsp)


Then, in R from the console or [R studio](https://rstudio.com/) you will need to download the following libraries:

* [BiocManager](https://cran.r-project.org/web/packages/BiocManager/vignettes/BiocManager.html)
* [edgeR](http://bioconductor.org/packages/release/bioc/html/edgeR.html)
* [limma](http://bioconductor.org/packages/release/bioc/html/limma.html)
* [org.Mm.eg.db](http://bioconductor.org/packages/release/data/annotation/html/org.Mm.eg.db.html)
* [Glimma](https://bioconductor.org/packages/release/bioc/html/Glimma.html)
* [pheatmap](https://www.rdocumentation.org/packages/pheatmap/versions/0.2/topics/pheatmap)



### Repository content 

Here you will find 4 directories to perform the analyses. Two extra folders contain additonal information that can be useful to use this pipeline. 



>### /bin/
  
  Here you will find the scripts that are needed to perform the analyses. The scripts must be used in the order specified. The QC steps for RNAquatification and AlignmentQC are optional.
  
   1. **FastQC.sh** 
  
  Performs a quality control analysis for each fastq file. Additionally, MultiQC condenses the reports for each sample to a single file.
  
   2. **RNAquatification.sh** 
  
  A semi-alignment using STAR to quantify the percentage of rRNA and mtRNA reads in each sample.
  
 
  3. **STAR.sh** 

Genome indexing and alignment to a reference genome.

4. **AlignmentQC.sh** 

Quality control of the alignment, including clipping profile and gene coverage analyses.


5. **SAM manipulation.sh** 

Manipulation of SAM files using samtools. 

* Transform SAM > BAM 
* Sort by coordinates
* Index BAM files —> .bam.bai


6. **featureCounts.sh** 
  
Create a count matrix using featureCounts from Subread. 


7. **edgeR.R** 

Here, you will find a sub-directory with the following scripts: 

* **Cancer-Normal .R.-** Filtering, normalization (TMM) and paired differential expression anlaysis between Cancer samples and Normal samples.  

* **Multi-group DE.R.-** Filtering, normalization (TMM) and multigroup expression anlaysis among all the histhopathological categories to find differentailly expressed (DE) genes unique to each category. 


8. **GSEA** 

Perform a Gene Set Enrichment Analysis form command line. (BASH) 


>### /Reports/

Output directory with QC and log reports. 
The output QC reports are located in in Reports > FastQC > [Readme_FastQC.md](https://github.com/FernandaDiaz12/pediatric_astrocytoma/blob/master/Reports/FastQC/Readme_FastQC.md) since GitHub doesn't allow HTML files. 


>### /data/

Data files:

* Fasta files for alignment
  * [Human mithocondrial genome](https://github.com/FernandaDiaz12/pediatric_astrocytoma/blob/master/data/Mithocondria.fa) 
  * [Human ribosomal](https://github.com/FernandaDiaz12/pediatric_astrocytoma/blob/master/data/Ribosomal.fa)
  * [Homo_sapiens.GRCh38.dna](https://github.com/FernandaDiaz12/pediatric_astrocytoma/edit/master/data/Reference%20genome.md)

* [Fastq files](https://osf.io/spmrq/?view_only=dfd16c89a6474e9f8a0299de1bbcde0a)in [OSF](https://osf.io/).

* Count table [21_astrocytoma.csv](https://github.com/FernandaDiaz12/pediatric_astrocytoma/blob/master/data/21_astrocytoma.csv)

>### /meta/

Metadata of the tumor and contiguous tissue samples. 

* Sample name
* Histopatologic_group
* Molecular_classification
* Localization
* Age_(y)
* Gender

A code-key explaining the meaning of each meta-data cathegory can be find in the [Readme](https://github.com/FernandaDiaz12/pediatric_astrocytoma/blob/master/meta/Readme_meta.md). 


### The folders described above are the 4 directories that are necessary to perform the analyses. The following two directories present additionnal information that can be useful. 


>### /Issues/

Here you will find a [Readme](https://github.com/FernandaDiaz12/pediatric_astrocytoma/blob/master/Issues/Readme_Issues.md) with a link to the issues that I presented in the Bioinformatics workshop at CONABIO, as well as some mock data files to run the scripts for which I needed help in the issues. 


>### /Presentation/

This folder contains an markdown file [Presentations](https://github.com/FernandaDiaz12/pediatric_astrocytoma/blob/master/Presentation/Presentation.md) where you can find a small description of both presentations that I did during the class. 



## Finally... 


You will find a markdown file [Analysis](https://github.com/FernandaDiaz12/pediatric_astrocytoma/blob/master/Analysis.md) with a short presentation and discussion of my results, including the graphics obtained in R and some tips to run the analysis. 


