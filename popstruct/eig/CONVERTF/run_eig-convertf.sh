#!/bin/bash

analysis="../../../analysis/"


# Prune the eig-dataset for SNPs within 50bp with r^2 < 0.2 using a window of 5 SNPs
plink \
        --bfile "${analysis}"qc-camgwas-updated \
        --indep-pairwise 50 5 0.2 \
        --allow-no-sex \
        --autosome \
        --biallelic-only \
        --out eig-ldPruned
cat eig-ldPruned.log > eig-convertf.log

plink \
        --bfile "${analysis}"qc-camgwas-updated \
        --extract eig-ldPruned.prune.in \
        --allow-no-sex \
        --autosome \
        --make-bed \
        --out eig-camgwas-ldPruned
cat eig-camgwas-ldPruned.log >> eig-convertf.log

plink \
	--bfile eig-camgwas-ldPruned \
	--recode \
	--allow-no-sex \
	--keep-allele-order \
	--keep ../EIGENSTRAT/eig.ids \
	--double-id \
	--out eig-corr-camgwas
cat eig-camgwas.log >> eig-convertf.log

rm eig-ldPruned* eig-camgwas-ldPruned*

# Convert files into eigensoft compartible formats

convertf -p par.PED.EIGENSTRAT
