#!/bin/bash

#echo 'If pulling from github, change --geneticMapFile to ../tables/genetic_map_hg19_example.txt.gz'
#echo

ref_path="$HOME/GWAS/Git/GWAS/1000G"

echo "`tabix -f -p vcf qc-camgwas-updated.vcf.gz`"

for chr in {2..22}; do
  eagle \
    --vcfRef=${ref_path}/ALL.chr${chr}.phase3_integrated.20130502.genotypes.bcf \
    --vcfTarget=qc-camgwas-updated.vcf.gz \
    --geneticMapFile=tables/genetic_map_hg19_withX.txt.gz \
    --outPrefix=chr${chr}-phased_wref \
    --chrom=${chr} \
    --pbwtIters=10 \
    --numThreads=90 \
    --Kpbwt=50000 \
    --vcfOutFormat=z \
    2>&1 | tee chr${chr}-phase_wref.log

  echo "`tabix -f -p vcf chr${chr}-phase_wref.vcf.gz`"

done

# --vcfOutFormat: Specify output format (.vcf, .vcf.gz, or .bcf)
# --noImpMissing: Turn off imputation of missing genotypes
# --bpStart=50e6, --bpEnd=100e6, and --bpFlanking=1e6: Impute genotypes to specific regions
# --Kpbwt=10000: Adjust speed and accuracy of impuatation. Increase value to improve accuracy
