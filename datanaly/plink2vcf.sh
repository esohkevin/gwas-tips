#!/bin/bash

base="qc-camgwas-updated-chr"

for i in $(seq 1 23); do
vcfCooker \
	--in-bfile ${base}${i} \
	--ref human_g1k_v37.fasta \
	--out ${base}${i}.vcf \
	--write-vcf
bgzip -f ${base}${i}.vcf
done
cp qc-camgwas-updated-chr23.vcf.gz qc-camgwas-updated-chrX.vcf.gz

