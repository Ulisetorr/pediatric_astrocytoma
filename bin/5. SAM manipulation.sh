##SAM manipulation
## samtools
###When you have your SAM files post-alignment

####The loop will perform the three following steps:
# 1. Transform SAM > BAM
# 2. Sort by coordinates
# 3. Index BAM —> Bam.Bai

#Create output directories
cd ..
cd data
mkdir BAM
mkdir Sorted
mkdir indexed

cd ..
cd bin

##Loop
for i in $(ls ../data/sam_files/*.Aligned.out.sam) do;
samtools view -bS ../data/sam_files/${prefix} > BAM;
samtools sort BAM/*.bam -o Sorted/;
samtools index *.sorted.bam;
done
