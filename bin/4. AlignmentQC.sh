### Post-alignment QC
#Once you have installed RSeQC

## I performed the clipping_profile parameter

## coverage analysis
##clipping_profile.py -h

sam_dirs= ~data/sam_files

for file in $sam_dirs; do
       samp_name=$(echo $file | sed "s/.*\///g")
       echo RUNNING:clipping_profile.py -i ~data/sam_files$samp_name -o data/clip/$samp_name
       clipping_profile.py -i ~/Documents/FernandaRNA/SAM_STAR_files/$samp_name -s "PE"  -o data/clip/$samp_name
done
