##Create a count matrix using featureCounts from  Subread


##For a matrix for each sample




##For a single matrix with all the samples
featureCounts -T 18 -s 1 -a STAR/Homo_sapiens.GRCh38.96.gtf -o Conteo/featureCounts/Astocytoma.txt ~/Documents/FernandaRNA/BAM/*.bam -B -p -G Conteo/featureCounts/Homo_sapiens.GRCh38.dna.primary_assembly.fa