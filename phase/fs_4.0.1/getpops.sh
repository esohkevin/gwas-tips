#!/bin/bash

# for i in msl gwd esn yri lwk; do 
#    grep -wi $i ../../popstruct/world/pca_eth_world_pops.txt | \
#        awk '{print $1}' | \
#        shuf -n 50; 
# done > afr50.txt
# 
# cat sam.ids afr50.txt > cam-afr50.txt
# 
# bcftools view -S cam-afr50.txt --threads 15 -Oz -o msl.fs.vcf.gz ../qc1kgp_merge.vcf.gz

bcftools view -S pca.ids --threads 15 -Oz -o fs.vcf.gz ../qc1kgp_merge.vcf.gz
