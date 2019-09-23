# Code-key Readme

In this readme, you will find a "code-key" that will help you understand the meaning of each metadata category. 
As you can see in this directory you will find a .csv file that contains the necessary metadata for the multi-group comparisons. 
Also, you will find a pdf file for visualization-only. 

### Sample 
In this column, you will find the names of the samples that I'm working with and whose fastq files can be found on my OSF 
[page](https://osf.io/spmrq/?view_only=dfd16c89a6474e9f8a0299de1bbcde0a.) 

>For the prefixes:

* **A.-**  Stands for "autopsy".
* **CM.-**  Stands for "Centro Médico" where the biopsy was taken.
* **M.-**  Stands for "Muestra" biopsy form Hospital Infantil. 


### Histopathologic_group

Here you can find which group belongs to each sample. According to the 2007 WHO Classification of Tumours of the Central Nervous System
That is based on histopathologic features. Were **I** is the lowest grade and **IV** the highest for astrocytomas. 
You can find more information about this classification in this [paper](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC1929165/).

For the controls, you will find samples as "Control" which are samples taken far away from the tumor. 
> Example: If the tumor was found on the cerebellum the control is taken from the brain and _viceversa_.

You will also find "ControlC" that stands for Control contiguous. Those are samples taken from the adjacent tissue of the tumor. 


### Molecular_classification 
In this column, you will find to which molecular category does each sample belongs. This classification is according to the 2016 WHO recommendation for diagnosis. You can find out more about this classification in  [this paper](https://www.ncbi.nlm.nih.gov/pubmed/27157931). 

As you will see, all samples are classified as "WT".  Meaning that there are no mutations recognized by the WHO to classify these tumors. 

>Except for sample M49, that even though it has a mutation in IDH gene, it is not the mutation used for classification. 

### Localization

Place from where the tissue (tumor or control)  was extracted. 

* **Brain.- ** all cerebral lobes except the cerebellum. 

### Age 

Age in years of the children when the biopsy was taken. 

### Gender 

* **F** = Female 
* **M**= Male 

### Pathology 

Normal or cancer depending on the pathologist diagnosis from the biopsy. 

>ControlC = control contiguous. It's hard to say if these samples are beginning the neoplasia transformation of not. 
