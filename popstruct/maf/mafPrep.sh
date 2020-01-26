#!/bin/bash

world="../world/worldPops/"
analysis="../../analysis/"
sample="../../samples/"

#if [[ -f "worldMergeList.txt" ]]; then
#    rm worldMergeList.txt
#fi

plink \
        --bfile ${analysis}raw-camgwas \
        --make-bed \
        --out cam

cut -f1,4 cam.bim | \
        sed 's/\t/:/g' > cam.pos
cut -f2 cam.bim > cam.ids
paste cam.ids cam.pos > cam-ids-pos.txt

plink \
        --bfile cam \
        --update-name cam-ids-pos.txt 2 1 \
        --allow-no-sex \
        --make-bed \
        --out cam-updated

plink \
        --bfile cam-updated \
        --update-name ${analysis}updateName.txt 1 2 \
        --allow-no-sex \
        --make-bed \
        --out cam



#echo "cam" > worldMergeList.txt

#for pop in gwd lwk yri esn msl; do
#    plink \
#        --vcf ../../1000G/Phase3_chr11.vcf.gz \
#        --keep-allele-order \
#        --out afr \
#	--exclude-snp rs199935366 \
#        --make-bed \
#        --update-sex ${world}update-1kgp.sex 1 \
#        --maf 0.0001
#
#cut -f1,4 afr.bim | \
#        sed 's/\t/:/g' > afr.pos
#cut -f2 afr.bim > afr.ids
#paste afr.ids afr.pos > afr-ids-pos.txt
#
#plink \
#        --bfile afr \
#        --update-name afr-ids-pos.txt 2 1 \
#        --allow-no-sex \
#        --make-bed \
#        --out afr-updated
#
##        echo ${pop} >> worldMergeList.txt
##done
#
#plink \
#        --merge-list worldMergeList.txt \
#        --keep-allele-order \
#        --out world-updated
#
#plink \
#        --bfile world-updated \
#        --update-name ${analysis}updateName.txt 1 2 \
#        --allow-no-sex \
#        --make-bed \
#        --out world
#
#./mafWorld.sh 11 5200 5400 HBB
