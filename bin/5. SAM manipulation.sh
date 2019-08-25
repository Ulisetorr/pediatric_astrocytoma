##SAM manipulation
## samtools


#Transform SAM > BAM

samtools view -bS SAM_STAR_files/*Aligned.out.sam > BAM/


#Sort by coordinates

samtools sort BAM/*.bam -o Sorted/


#Index BAM —> Bam.Bai

> samtools index *.sorted.bam 
