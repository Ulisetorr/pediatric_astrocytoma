# Alignment with STAR 

#To create index genome with STAR 
# Download latest version of the human genome and annotations

# http://www.ensembl.org/info/data/ftp/index.html — from ensemble download files: <Homo_sapiens.GRCh38.dna.alt.fa.gz> and <Homo_sapiens.GRCh38.96.chr_patch_hapl_scaff.gtf.gz>
# Save into the working directory and gunzip them or unzip them

###These files can also be found in the data directory but is better if you download them every time you'll run this script to assure updated fasta files

# Create index genome:
mkdir -p data/star_indices

STAR --runThreadN 18 --runMode genomeGenerate --genomeDir ../data/star_indices --genomeFastaFiles ../data/Homo_sapiens.GRCh38.dna.primary_assembly.fa --sjdbGTFfile ../data/Homo_sapiens.GRCh38.96.gtf --sjdbOverhang 100


##Alignment

cd ..
cd data
cd Fastq

##Loop for alignment
for prefix in $(ls *.fastq | rev | cut -c 14- | rev | uniq);
do;
STAR --readFilesIn ${prefix}_R1_002.fastq ${prefix}_R2_002.fastq; --runThreadN 18 --runMode alignReads --genomeDir ../star_indices --outFileNamePrefix ${prefix%.fastq}_; 
done 
