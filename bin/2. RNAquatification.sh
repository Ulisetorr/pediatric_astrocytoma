### RNA quantification pipeline

## These scripts perform a "pseudo-alignment" against a reference fasta file so you can measure the percentage of reads that align to your sequence of interest.
#In this case, I measure how much ribosomal and mitochondrial reads do my samples had.
#This script is run in STAR

#First index both fasta files 
#Considering you are running from the bin directory

## indexing mitochondria
star --runMode genomeGenerate --genomeDir ../data/Mithocondria_index --genomeFastaFiles ../data/Mithocondria.fa --runThreadN 16 

## indexing ribosomal unit
star --runMode genomeGenerate --genomeDir ../data/Ribosomal_index --genomeFastaFiles data/Ribosomal.fa --runThreadN 16


##Where: 
# --readFiles --> fastq files to align
#--runMode genomeGenerate --> Specify STAR to index de DNA
#--genomeDir --> Where to put the indexed genome
#--genomeFastaFiles  --> Where is the fasta input file
#--runThreadN --> How many Threads to run

 ############ Then you can run the alignment toward this indexed fasta files.
 #The information of interest will be in the .log file generated at the end
 #You will know the percentage of reads that align to both fasta files


## alignment to mitochondria
star --readFilesIn ../data/Fastq/*.fastq --genomeDir ../data/Ribosomal_index --runThreadN 16 --outFileNamePrefix ../Reports/Ribosomal

## alignment to ribosomal unit 
star --readFilesIn ../data/Fastq/*.fastq --genomeDir ../data/Mithocondria_index --runThreadN 16 --outFileNamePrefix ../Reports/Mithocondria


##Where: 
# --readFiles --> fastq files to align
#--genomeDir --> Where the indexed genome is
#--outFileNamePrefix --> Where to send the output files and what name will have
#--runThreadN --> How many Threads to run
