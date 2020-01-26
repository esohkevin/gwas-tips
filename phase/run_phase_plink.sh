#!/bin/bash

data_path="../analysis/"

for chr in {1..22}; do
  eagle \
    --bfile=${data_path}qc-camgwas-updated \
    --geneticMapFile=tables/genetic_map_hg19_withX.txt.gz \
    --chrom=${chr} \
    --outPrefix=chr${chr}-phased \
    --numThreads=6 \
    --Kpbwt=10000 \
    2>&1 | tee chr${chr}-plink_files.log
done

### run eagle without any parameters to list options

### typical options for phasing without a reference:
# to import genetic map coordinates: --geneticMapFile=tables/genetic_map_hg##.txt.gz
# to remove indivs or exclude SNPs: --remove, --exclude
# to perform QC on missingness:  --maxMissingPerIndiv, --maxMissingPerSnp
# to select a region to phase: --bpStart, --bpEnd

### old:
# to use Eagle1 algorithm: --v1
# to use Eagle1 fast mode: --v1fast
