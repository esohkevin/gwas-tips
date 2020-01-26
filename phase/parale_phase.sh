#!/bin/bash

ref_path="../1000G"
base="qc-camgwas-updated"
Kpbwt="50000"

tabix -f -p vcf ${base}.vcf.gz

seq 22 | parallel echo "--vcfRef=../1000G/ALL.chr{}.phase3_integrated.20130502.genotypes.bcf --vcfTarget=qc-camgwas-updated.vcf.gz --geneticMapFile=tables/genetic_map_hg19_withX.txt.gz --outPrefix=chr{}-phased_wref --chrom={} --pbwtIters=10 --numThreads=15 --Kpbwt=50000 --vcfOutFormat=z" | xargs -P5 -n9 eagle

