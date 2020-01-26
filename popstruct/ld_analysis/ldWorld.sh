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

if [[ $# == 5  ]]; then

plink \
        --bfile ${world}../cam-controls \
        --chr $1 \
        --ld-snp $2 \
	--maf 0.0001 \
        --out chr"$1""$3"cam \
        --ld-window 99999 \
        --ld-window-kb 2000 \
        --ld-window-r2 0 \
        --r2

# Reference-wise LD

   for pop in gwd yri lwk; do 

       plink \
	--bfile ${world}mergedSet \
	--chr $1 \
	--ld-snp $2 \
	--maf 0.0001 \
	--keep ${sample}"${pop}".ids \
	--ld-window 99999 \
	--ld-window-kb 2000 \
	--ld-window-r2 0 \
	--out chr"$1""$3""${pop}" \
	--r2

   done

# Plot
Rscript ldWorld.R chr"$1""$3"cam.ld chr"$1""$3"gwd.ld chr"$1""$3"yri.ld chr"$1""$3"lwk.ld ${3}world.png $4 $5 ${kgp}genetic_map_chr"${1}"_combined_b37.txt

#./showLdTags.sh ${3}

else
	echo """
	Usage: ./ldWorld.sh <chr#> <snp> <gene> <R-index1> <R-index2>
"""

fi
