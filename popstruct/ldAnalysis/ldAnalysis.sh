#!/bin/bash

analysis="../../analysis/"
world="../eig/world/worldPops/"
phase="../../phase/"

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


# camgwas data
#plink \
#        --bfile ${phase}phasedCamgwasAutosome \
#        --autosome \
#        --allow-no-sex \
#        --out cam \
#        --maf 0.01 \
#        --make-bed

plink \
        --bfile cam \
        --chr $1 \
        --ld-snp $2 \
        --ld-window 70 \
        --ld-window-kb 1000 \
        --ld-window-r2 0 \
        --out chr"$1""$3" \
        --r2 

# Reference-wise LD

for pop in gwd lwk yri gbr chb; do 
#   plink \
#	--bfile ${world}qc-rsids-world \
#	--autosome \
#	--keep ${pop}.ids \
#	--extract nodups.rsids \
#	--allow-no-sex \
#	--out ${pop} \
#	--maf 0.01 \
#	--make-bed

plink \
	--bfile ${pop} \
	--chr $1 \
	--ld-snp $2 \
	--ld-window 70 \
	--ld-window-kb 1000 \
	--ld-window-r2 0 \
	--out chr"$1""$3""${pop}" \
	--r2

done

# Plot
Rscript ldAnalysis.R
