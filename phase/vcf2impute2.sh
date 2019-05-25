#!/bin/bash

cd ../
baseDir="`pwd`"
cd -
phase_path="${baseDir}/phase/"
sample_path="${baseDir}/samples/"

# Convert phased haplotypes in vcf format to IMPUTE2 .haps + .sample format


for chr in {1..22}; do
  if [[ -f "${phase_path}""chr${chr}-phased_wref.vcf.gz" ]]; then
     if [[ ! -f "chr${chr}-phased_wref.haps" ]]; then
        plink2 \
	   --vcf "$phase_path"chr"${chr}"-phased_wref.vcf.gz \
	   --export haps \
	   --double-id \
	   --out chr"${chr}"-phased_wref
     else
        echo "chr"${chr}"-phased_wref.haps already exists!"
     fi
  else
     echo "chr"${chr}"-phased_wref.vcf.gz was not found!"
  fi
done

