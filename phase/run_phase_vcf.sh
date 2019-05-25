#!/bin/bash

for chr in {1..22}; do
  eagle \
    --vcf=qc-camgwas-updated.vcf.gz \
    --geneticMapFile=tables/genetic_map_hg19_withX.txt.gz \
    --chrom=${chr} \
    --numThreads=15 \
    --Kpbwt=100000 \
    --vcfOutFormat=z \
    --outPrefix=Chr${chr}-phased \
    2>&1 | tee Chr${chr}-phase_vcf.log

done
### run eagle without any parameters to list options

### typical options for phasing without a reference in VCF/BCF mode:
# to import genetic map coordinates: --geneticMapFile=tables/genetic_map_hg##.txt.gz
# to select a region to phase: --bpStart, --bpEnd
# --numThreads=4

### old:
# to use Eagle1 algorithm: --v1
# to use Eagle1 fast mode: --v1fast
