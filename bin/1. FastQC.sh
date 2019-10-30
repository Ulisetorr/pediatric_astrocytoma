###Script to run fastqC 
##Once FastQC is installed 
##You have to download the fastq files from OSF. You will find the link in data > OSF.md
##Download de Fastq files to the data/Fastq directory
##Then you can run the command 

fastqc ../data/Fastq/*.fastq -o ../reports/FastQC -t 64 
 
### The output files (HTML) will apear on the Reports > FastQC directory 
