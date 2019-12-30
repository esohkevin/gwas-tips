#!/bin/bash

kgp="../phase/1000GP_Phase3/"
analysis="../analysis/"
phase="../phase/"

if [[ $# == ]]
    #-------- LD-prune the raw data
    plink \
        --vcf ${in_vcf} \
        --allow-no-sex \
	--keep-allele-order \
	--aec \
	--autosome \
	--threads 4 \
        --indep-pairwise 5k 50 0.1 \
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

