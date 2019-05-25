#!/bin/bash

base=".pbwt_reference_impute.vcf.gz"

for i in $(seq 1 22); do
bcftools view -Ou -i 'INFO>0.75' -q 0.5:minor "${i}""${base}" | bcftools convert --tag GP -g chr${i}-sanger-imputed
done

bcftools view -Ou -i 'INFO>0.75' -q 0.5:minor X.vcf.gz | bcftools convert --tag GP -g chrX-sanger-imputed
