#!/bin/bash

analysis="../../../analysis/"
samples="../../../samples/"
kgp="../../../1000G/"
phase="../../../phase/"

# Get Cam control samples
plink \
	--bfile worldPops/qc-world-merge \
	--keep afr-only.txt \
	--extract yriAcertainment.rsids \
	--keep-allele-order \
	--pheno worldPops/update-1kgp.phe \
        --mpheno 1 \
        --maf 0.0001 \
        --update-sex worldPops/update-1kgp.sex 1 \
	--make-bed \
	--out yriascertained


# Prune to get only SNPs at linkage equilibrium (independent SNPs - no LD between them)
plink \
	--bfile yriascertained \
	--indep-pairwise 50kb 1 0.2 \
	--allow-no-sex \
	--out aprune

plink \
	--bfile yriascertained \
	--autosome \
	--maf \
	--geno 0.04 \
	--extract aprune.prune.in \
	--make-bed \
	--out afr-data

# Convert bed to ped required for CONVERTF
plink \
	--bfile afr-data \
	--recode \
	--allow-no-sex \
	--keep-allele-order \
	--double-id \
	--out afr-data


mv afr-data.map afr-data.ped CONVERTF/
rm yriascertained.*
