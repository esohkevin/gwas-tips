#!/bin/bash

if [[ $# == 3 ]]; then
   
    in_vcf="$1"
    maf="$2"
    outname="$3"

    #-------- LD-prune the raw data
    plink \
        --vcf ${in_vcf} \
        --allow-no-sex \
	--keep-allele-order \
	--aec \
	--autosome \
	--threads 4 \
        --indep-pairwise 5k 50 0.2 \
        --out pruned

    #-------- Now extract the pruned SNPs to perform check-sex on
    plink \
        --vcf ${in_vcf} \
        --allow-no-sex \
	--keep-allele-order \
	--maf ${maf} \
	--aec \
	--autosome \
	--threads 4 \
	--double-id \
        --extract pruned.prune.in \
        --recode vcf-fid bgz \
	--real-ref-alleles \
        --out ${outname}

    rm pruned* *.nosex temp*

else
    echo """
    Usage:./fst_prep.sh <in-vcf(plus path)> <maf> <bfile-outname>
    """
fi

#in_vcf=Phased-pca-filtered
#maf=0.05
#outname=""
