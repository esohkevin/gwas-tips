#!/bin/bash

################# Post Imputation GWAS Analysis ###################
shapeit="$HOME/GWAS/Git/GWAS/michigan/shapeit/"
analysis="$HOME/GWAS/Git/GWAS/michigan/analysis/"

# Chech duplicate positions (snps) to exclude from downstream analyses
zgrep -v "^#" merge.filtered.vcf.gz | cut -f3 | sort | uniq -d > merge.filtered.dups

# Covert autosomal imputed and filtered genotypes to plink binary format 
plink \
	--vcf merge.filtered.vcf.gz \
	--exclude merge.filtered.dups \
        --allow-no-sex \
        --make-bed \
	--vcf-min-gp 0.9 \
        --biallelic-only \
	--keep-allele-order \
	--double-id \
        --out merge.filtered

# Update the dataset with casecontrol status from sample files
plink \
	--bfile merge.filtered \
	--allow-no-sex \
	--pheno "$shapeit"update-camgwas.phe \
	--1 \
	--update-name "$shapeit"update-ucsc.ids 2 1 \
	--update-sex "$shapeit"update-camgwas.sex \
	--maf 0.01 \
	--geno 0.04 \
	--hwe 1e-6 \
	--update-name "$analysis"ucss-rsids.txt 1 2 \
	--make-bed \
	--out merge.filtered-updated



