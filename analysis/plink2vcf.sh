#!/bin/bash

prefix="qc-camgwas-updated-chr"

#########################################################################
#            The merged chromosomes file                                #
vcfCooker \
        --in-bfile qc-camgwas-updated \
        --ref human_g1k_v37.fasta \
        --out qc-camgwas-updated.vcf \
        --write-vcf
bgzip -f qc-camgwas-updated.vcf


#########################################################################


#########################################################################
#for i in $(seq 1 23); do
#vcfCooker \
#	--in-bfile ${prefix}${i} \
#	--ref human_g1k_v37.fasta \
#	--out ${prefix}${i}.vcf \
#	--write-vcf
#bgzip -f ${prefix}${i}.vcf
#done
#cp qc-camgwas-updated-chr23.vcf.gz qc-camgwas-updated-chrX.vcf.gz

