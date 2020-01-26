#!/bin/bash

analysis="../../analysis/"
world="../eig/world/worldPops/"
phase="../../phase/"
kgp="${phase}1000GP_Phase3/"
sample="../../samples/"

if [[ $# != 4 ]]; then
   echo """
        Usage: mafWorld.sh <chr#> <from-kb> <to-kb> <gene-name>
"""
else	
#   plink \
#   	--bfile world \
#   	--freq \
#   	--keep-allele-order \
#   	--within camAfr.cluster \
#   	--out world
   
   plink \
        --bfile world \
        --freq \
   	--chr $1 \
   	--from-kb $2 \
   	--to-kb $3 \
        --keep-allele-order \
        --within camAfr.cluster \
        --out world$4
fi

#./blocksWorld.sh $1 $2 $3 $4 $5
