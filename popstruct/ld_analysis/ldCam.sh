#!/bin/bash

analysis="../../analysis/"
world="../eig/world/worldPops/"
phase="../../phase/"
kgp="${phase}1000GP_Phase3/"
sample="../../samples/"

# Pairwise LD in a region
#plink \
#	--bfile ${analysis}qc-camgwas-updated \
#        --r2 \
#	--chr 4 \
#	--from-bp 144000000 \
#	--to-bp 146000000 \
#        --ld-window-kb 22 \
#        --ld-window 10 \
#        --ld-window-r2 0.2 \
#	--out gypchr4


# Entire cam data
plink \
        --bfile ${world}../cam-controls \
        --chr $1 \
        --ld-snp $2 \
        --ld-window 99999 \
        --ld-window-kb 2000 \
        --ld-window-r2 0 \
        --out chr"$1""$3"cam \
        --r2

# Reference-wise LD

for pop in bantu semibantu fulbe; do 
#   plink \
#	--bfile ${world}qc-world-merge \
#	--autosome \
#	--keep ${pop}.ids \
#	--allow-no-sex \
#	--out ${pop} \
#	--maf 0.01 \
#	--make-bed

plink \
	--bfile ${world}../cam-controls \
	--chr $1 \
	--ld-snp $2 \
	--keep ../haploanalysis/${pop}.txt \
	--ld-window 99999 \
	--ld-window-kb 2000 \
	--ld-window-r2 0 \
	--out chr"$1""$3""${pop}" \
	--r2

done
# Plot
Rscript ldCam.R chr"$1""$3"bantu.ld chr"$1""$3"semibantu.ld chr"$1""$3"fulbe.ld chr"$1""$3"cam.ld ${3}cam.png $4 $5 ${kgp}genetic_map_chr${1}_combined_b37.txt
