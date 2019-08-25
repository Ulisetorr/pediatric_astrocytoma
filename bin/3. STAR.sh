# Alignment with STAR 
# Download start and copy the binary files to usr/local/bin/
# 

#To create index genome with STAR 
# Download latest version of human genome and annotations
# http://www.ensembl.org/info/data/ftp/index.html — from ensemble download files: <Homo_sapiens.GRCh38.dna.alt.fa.gz> and <Homo_sapiens.GRCh38.96.chr_patch_hapl_scaff.gtf.gz>
# Save into the working directory and gunzip them or unzip them
# Create index genome:
mkdir -p star_indices

STAR --runThreadN 18 --runMode genomeGenerate --genomeDir star_indices/ --genomeFastaFiles Homo_sapiens.GRCh38.dna.primary_assembly.fa --sjdbGTFfile Homo_sapiens.GRCh38.96.gtf --sjdbOverhang 100
STAR --runThreadN 18 --genomeDir STAR/star_indices/ --readFilesIn raw_data/A10A_S16_L004_R1_001.fastq raw_data/A10A_S16_L004_R2_001.fastq --outFileNamePrefix SAM_STAR_files02/A10A_


##Alignment

STAR --runThreadN 18 --genomeDir STAR/star_indices/ --readFilesIn raw_data/A10A_S16_L004_R1_001.fastq raw_data/A10A_S16_L004_R2_001.fastq 
