#!/bin/bash

analysis="../../analysis/"

plink2 \
	--bfile ${analysis}raw-camgwas \
	--ref-allele force ${analysis}chimp_anc.txt 3 2 \
	--make-bed \
	--out TEMP

plink2 \
	--bfile TEMP \
	--ref-allele force ${analysis}ancSites.txt 4 3 \
	--make-bed \
	--out raw-camgwas


plink \
	--bfile raw-camgwas \
	--recode vcf-fid bgz \
	--real-ref-alleles \
	--remove ${analysis}fail-ind.qc \
	--exclude ${analysis}fail-Xdiffmiss.qc \
	--mind 0.10 \
	--geno 0.04 \
	--out raw-camgwas
rm *.hh raw-camgwas.b* raw-camgwas.fam TEMP*
