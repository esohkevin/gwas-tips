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
	    --maf 0.0001 \
            --r2 square yes-really \
            --out cam${4}region \
            --bfile ${world}../cam-controls
    
    #gnuplot -e 'set terminal canvas; set output "camhbbregion.html"; set autoscale yfix; set autoscale xfix; set title "Pair-wise LD around HBB Region";set pm3d map; plot "camhbbregion.ld" matrix with image'
    
    
    for pop in gwd lwk yri; do
        plink \
            --chr $1 \
            --from-kb $2 \
            --to-kb $3 \
	    --maf 0.0001 \
            --keep ${sample}${pop}.ids \
            --r2 square yes-really \
            --out ${pop}${4}region2 \
            --bfile ${world}world-pops-updated
    
    sed 's/nan/0/g' ${pop}${4}region2.ld > ${pop}${4}region.ld
    
    done
    
    #gnuplot -e 'set terminal canvas; set output "bantuhbbregion.html"; set autoscale yfix; set autoscale xfix; set title "Pair-wise LD around HBB Region";set pm3d map; plot "bantuhbbregion.ld" matrix with image'
    #gnuplot -e 'set terminal canvas; set output "semibantuhbbregion.html"; set autoscale yfix; set autoscale xfix; set title "Pair-wise LD around HBB Region";set pm3d map; plot "semibantuhbbregion.ld" matrix with image'
    #gnuplot -e 'set terminal canvas; set output "fulbehbbregion.html"; set autoscale yfix; set autoscale xfix; set title "Pair-wise LD around HBB Region";set pm3d map; plot "fulbehbbregion.ld" matrix with image'
    
    Rscript plotPairWiseldWorld.R lwk${4}region.ld cam${4}region.ld yri${4}region.ld gwd${4}region.ld ${kgp}genetic_map_chr${1}_combined_b37.txt ${4}WorldPairwise.png

else
    echo """
	Usage: ./plotPairWiseldWorld.sh <chr#> <from-kb> <to-kb> <gene-name>
"""
fi
