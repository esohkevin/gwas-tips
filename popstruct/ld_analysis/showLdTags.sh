#!/bin/bash

analysis="../../analysis/"
world="../eig/world/worldPops/"
phase="../../phase/"
kgp="${phase}1000GP_Phase3/"
sample="../../samples/"


plink \
        --bfile ${world}../cam-updated \
        --show-tags camTag.txt \
        --list-all \
	--maf 0.0001 \
        --tag-r2 0.6 \
        --tag-kb 11 \
        --out cam${1}


for pop in gwd lwk yri; do
    plink \
	--bfile ${world}world-pops-updated \
	--show-tags ${pop}Tag.txt \
	--list-all \
	--keep ${sample}"${pop}".ids \
	--allow-no-sex \
	--tag-r2 0.6 \
	--tag-kb 11 \
	--maf 0.0001 \
	--out ${pop}${1}
done
