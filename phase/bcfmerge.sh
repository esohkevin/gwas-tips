#!/bin/bash

#for i in chr*-phased_wref.vcf.gz; do
#    tabix -f -p vcf ${i}
#done

#bcftools concat -a -d snps -Oz chr{1..22}-phased_wref.vcf.gz -o Phased_wref.vcf.gz

bcftools merge ../1000G/Phase3_1kgpsnps.vcf.gz Phased_wref.vcf.gz --threads 20 -Oz -o temp.vcf.gz

bcftools view -k -m2 -M2 -p -Oz -v snps --threads 20 temp.vcf.gz -o qc1kgp_merge.vcf.gz

rm temp.vcf.gz
