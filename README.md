# Analysis of pediatric astrocytoma transcriptome 

In this repository, you will find the basic workflow of a RNA-seq analysis of tumor samples from pediatric astrocytomas. The project aims to cover a differential expression analysis and a Gene set enrichment analysis. 

The libraries were made from Total RNA, (rRNA-depleted) from tumors and contiguous tissue. 



## Objective

Find expression hallmarks that characterized each astrocytoma grade according to the histopathological and molecular classification.


## General workflow

![](Bulk work-flow.png)

## Repository content 

Here you will find 4 directories to perform the analysis.

>### Bin
  
  Here you will find the scripts that are needed to perform the analysis. They must be used in the order that it's specified. The QC steps may be optional.
  
   * **FastQC** 
  
  Performs a quality control analysis for each fastq file. Additionally, MultiQC condense the reports for each sample to a single file.
  
   * **RNAquatification** 
  
  A semi-alignment using STAR to quantify a percentage of how many rRNA and mtRNA reads are in each sample.
  
 
  * **STAR** 

Genome indexing, and alignment to a reference genome.

* **AlignmentQC** 

Alignment to make the quality control of the alignment. Clipping profile and gene coverage analysis.


* **SAM manipulation** 

Manipulation of SAM files using samtools. 

1. Transform SAM > BAM 
2. Sort by coordinates
3. Index BAM files —> .bam.bai


* **featureCounts** 
  
Create a count matrix using featureCounts from Subread. 


* **edgeR** 

Filtering, normalization (TMM) and multigroup differential expression analysis. 



>### Reports

Output directory to save QC and log reports. 


>### data

Fasta files to perform alignments and link to [Fastq files](https://osf.io/confirm/3h6s8/0l71H7vSGrjFnOMuEys1MDbn8L4XPO/)
in [OSF](https://osf.io/).

>### meta

Metadata of the tumor and cotigous tissue samples. 

* Sample name
* Histopatologic_group
* Molecular_classification
* Localization
* Age_(y)
* Gender


