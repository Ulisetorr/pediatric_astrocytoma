# Analysis of pediatric astrocytoma transcriptome

Central nervous system (CNS) tumors are a heterogeneous group and represent the most common solid tumors during the childhood of humans [(Dang & Phillips, 2017)](https://www.ncbi.nlm.nih.gov/pubmed/29200119). Gliomas or astrocytomas are those tumors caused by astrocytes, which are divided into subgroups according to their clinical-pathological characteristics and histological subtype. In children, the most common glial tumors are astrocytomas ([Bethesda, 2002](https://www.ncbi.nlm.nih.gov/books/NBK82221/)). In Mexico alone, they represent 32% of CNS tumors in infants ([Eguía-Aguilar et al., 2014](https://www.ncbi.nlm.nih.gov/pubmed/24718706)).

Until 2016, the World Health Organization classified astrocytomas according to clinical-pathological and histological subtypes in grades I through IV ([Louis et al., 2007](https://www.ncbi.nlm.nih.gov/pubmed/?term=Louis%2C+D.+N.%2C+Ohgaki%2C+H.%2C+Wiestler%2C+O.+D.%2C+Cavenee%2C+W.+K.%2C+Burger%2C+P.+C.%2C+Jouvet%2C+A.%2C+%E2%80%A6+Kleihues%2C+P.+(2007).+The+2007+WHO+classification+of+tumours+of+the+central+nervous+system.+Acta+Neuropathologica%2C+114(2)%2C+97-109.+https%3A%2F%2Fdoi.org%2F10.1007%2Fs00401-007-0243-4)). However, with the expansion of genomic studies, the understanding of these tumors changed, establishing a new classification system based on molecular tools for diagnosis. In this, pediatric astrocytomas are reorganized into two groups ([Louis et al., 2016](https://www.ncbi.nlm.nih.gov/pubmed/27157931)):

**1. Diffuse astrocytomas:** Groups anaplastic, diffuse and gliomas astrocytomas according to their recurrent mutations in the IDH1, IDH2, and H3F3A genes.

**2. Other astrocytomas:** Those astrocytomas with a more restricted growth pattern and absence of the aforementioned recurrent mutations.

Being a public health problem worldwide and nationally, the search for white biomarkers has become a therapeutic strategy that has been approached from different biological aspects. A common strategy to identify such markers is to analyze the transcriptome of tumors by mass sequencing. This technique has been used successfully to identify biological markers in the different histopathological degrees of astrocytomas in adults and some types of pediatric astrocytomas and gliomas ([Seifert et al., 2015](https://bmccancer.biomedcentral.com/articles/10.1186/s12885-015-1939-9)). However, this technique has not been implemented under the new model of molecular classification of this type of tumors. That would allow the search for new specific biomarkers for each cell subtype.

To characterize the transcriptome of the different histopathological grades. I analyzed 21 samples:

* 3 biological replicates Grade I (Brain)
* 3 biological replicates Grade I (Cerebellum)
* 3 biological replicates Grade II (Brain)
* 3 biological replicates Grade III (Brain)
* 3 biological replicates Grade IV (Brain)

* 3 biological replicates Control from adjacent tissue (Brain)
* 3 biological replicates Control (Brain - autopsy)

### FastQC 

To check the QC of the obtained data. I performed a FastQC analysis. In the next image you can see the "Per base sequence quiality" of the MultiQC report containing all the samples. 

![](https://github.com/FernandaDiaz12/pediatric_astrocytoma/blob/master/Reports/QC.png)

### Alignment with STAR 

The obtained sequences were aligned to the _Homo sapiens_ genome hg38. In the next table you can see the percentages of the aligned reads. 

| Sample                  | A10A   | A12A   | A12B   | CM15   | CM30   | CM39   | CM46   | CM54   | CM71   | CM75   | CM8    | M102   | M108   | M10    | M20    | M29    | M49    | M692   |
|-------------------------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|
| % Uniquely mapped reads | 84.81% | 85.18% | 83.75% | 88.93% | 84.63% | 82.21% | 86.88% | 84.91% | 86.97% | 86.51% | 83.99% | 88.25% | 85.99% | 85.48% | 88.74% | 84.29% | 87.00% | 83.71% |



### Differential Expression analysis

#### PCA

First, to check the differences and similarities among the samples I performed a PCA analysis contrasting the differences when I compare Normal samples vs Cancer and Among Histopathologic groups. This was made with edgeR, from Bioconductor and you can find the script for this plot in the [Multi-group DE.R](https://github.com/FernandaDiaz12/pediatric_astrocytoma/blob/master/bin/7.%20edgeR/Multi-group%20DE.R) script. 

![](https://github.com/FernandaDiaz12/pediatric_astrocytoma/blob/master/Reports/Rplot_for%20analysis.png)

As you can see in the left panel, there is not a clear grouping of the samples according to the Histopathologic group. But comparing between conditions (Normal vs Cancer) in the right panel, you can see that the cancer samples group on the right side of the plot and on the left side you will find the controls.
Suggesting that the transcriptome differences are more clear between conditions than among grades. 


#### Cancer vs Normal 

To check how many genes were differentially expressed between the conditions Normal vs Cancer. I created a group called "condition" and continue with the analysis. The next plot is from the R script [Cancer-Normal .R](https://github.com/FernandaDiaz12/pediatric_astrocytoma/blob/master/bin/7.%20edgeR/Cancer-Normal%20.R). 

![](https://github.com/FernandaDiaz12/pediatric_astrocytoma/blob/master/Reports/Rplot_CancervsNormal.png)

This was the number of genes obtained with this comparison:

| Up      | 1827  |
|---------|-------|
| Not sig | 56274 |
| Down    | 783   |


#### Histopathological grades

As we saw on the PCA the differences among these groups are not that clear with this transcriptional data. To look for more prominent changes in expression. I took the 500 most variable genes among all the histopathological grades. Resulting on the next heat map made with the pheatmap package from R. You can find the script for this heatmap on the [Multi-group DE.R](https://github.com/FernandaDiaz12/pediatric_astrocytoma/blob/master/bin/7.%20edgeR/Multi-group%20DE.R) script.

![500 most variable genes](https://github.com/FernandaDiaz12/pediatric_astrocytoma/blob/master/Reports/Rplot_pheatmap.png)

With this plot, we can see that the controls cluster together. And that most low-grade astrocytomas (I and II) form a cluster on the left side of the Heatmap and the high-grade samples (III and IV) form a cluster on the right side of the heatmap. 

For the last part of the analysis, to create a table with differentially expressed genes I needed to define the comparations among the groups. I was able to define them in my script [Multi-group DE.R](https://github.com/FernandaDiaz12/pediatric_astrocytoma/blob/master/bin/7.%20edgeR/Multi-group%20DE.R) this was last week. So I wasn't able to perform the GSEA analysis. 


###Conclusions 
This first approach gives me a general overview of the transcriptional landscape of the samples from pediatric astrocytoma. Utili this point we can see that there are more clear differences between the Cancer and Normal conditions in contrast to the differences among the histopathological groups. Further analysis like GSEA and isoform analysis will elucidate if there are in fact clear transcriptional differences among the groups. 




