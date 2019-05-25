#!/bin/bash

# Create sample file for sanger imputation serveice for X-chr imputation
bcftools +guess-ploidy -g b37 qc-camgwas-updated.vcf.gz > samples.txt
cut -f1 samples.txt > samples.txt.ids
grep -f samples.txt.ids samples/camgwas.sex | cut -f4 -d' ' | sed 's/1/M/g' |  sed 's/2/F/g' > samples.txt.sex
paste samples.txt.ids samples.txt.sex > sample.txt
rm samples.txt.ids samples.txt.sex

