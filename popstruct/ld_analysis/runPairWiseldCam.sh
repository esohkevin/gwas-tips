#!/bin/bash

analysis="../../analysis/"
world="../eig/world/worldPops/"
phase="../../phase/"
kgp="${phase}1000GP_Phase3/"
sample="../../samples/"

if [[ $# == 4 ]]; then

	plink \
	        --chr $1 \
	        --from-kb $2 \
	        --to-kb $3 \
		--filter-controls \
	        --r2 square yes-really \
	        --out cam${4}region \
	        --bfile ../../assoc_results/phasedWrefImpute2Biallelic
	
	#gnuplot -e 'set terminal canvas; set output "camhbbregion.html"; set autoscale yfix; set autoscale xfix; set title "Pair-wise LD around HBB Region";set pm3d map; plot "camhbbregion.ld" matrix with image'
	
	
	for pop in bantu semibantu fulbe; do
	    plink \
	        --chr $1 \
	        --from-kb $2 \
	        --to-kb $3 \
		--filter-controls \
		--thin-indiv-count 12 \
		--keep ../maf/${pop}.txt \
	        --r2 square yes-really \
	        --out ${pop}${4}region2 \
	        --bfile ../../assoc_results/phasedWrefImpute2Biallelic
	
	sed 's/nan/0/g' ${pop}${4}region2.ld > ${pop}${4}region.ld
	
	done
	
	#gnuplot -e 'set terminal canvas; set output "bantuhbbregion.html"; set autoscale yfix; set autoscale xfix; set title "Pair-wise LD around HBB Region";set pm3d map; plot "bantuhbbregion.ld" matrix with image'
	#gnuplot -e 'set terminal canvas; set output "semibantuhbbregion.html"; set autoscale yfix; set autoscale xfix; set title "Pair-wise LD around HBB Region";set pm3d map; plot "semibantuhbbregion.ld" matrix with image'
	#gnuplot -e 'set terminal canvas; set output "fulbehbbregion.html"; set autoscale yfix; set autoscale xfix; set title "Pair-wise LD around HBB Region";set pm3d map; plot "fulbehbbregion.ld" matrix with image'
	
	Rscript plotPairWiseldCam.R cam${4}region.ld bantu${4}region.ld semibantu${4}region.ld fulbe${4}region.ld ${kgp}genetic_map_chr${1}_combined_b37.txt ${4}pairwise.png

else
	echo """
	Usage: ./plotPairWiseldCam.sh <chr#> <from-kb> <to-kb> <gene-name>
"""
fi
