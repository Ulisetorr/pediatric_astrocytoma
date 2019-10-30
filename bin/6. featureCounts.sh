##Create a count matrix using featureCounts from  Subread
##Once you have installed the Subread package 
##For a single matrix with all the samples

#Create output directory 
cd ..
cd data 
mkdir Conteo 

cd .. 
cd bin 

##Run featureCounts 
featureCounts -T 18 -s 1 -a ../data/Homo_sapiens.GRCh38.96.gtf -o ../data/Conteo/Astocytoma.txt ~/data/Sorted/*.sorted.bam -B -p 
