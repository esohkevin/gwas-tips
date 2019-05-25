#!/bin/bash

# Extract population from each into separate files

#for file in include_*; do
#plink \
#	--vcf ../1000G/Phase3_merged.vcf.gz \
#	--keep $file \
#	--autosome \
#	--extract qc-rs.ids \
#	--allow-no-sex \
#	--make-bed \
#	--exclude-snp rs16959560 \
#	--biallelic-only \
#	--out 1kGp3_$file

#done

# Extract frequent, independent, biallelic SNPs from the 1KGP3 for population strcuture analysis
plink \
	--vcf ../1000G/Phase3_merged.vcf.gz \
	--allow-no-sex \
	--autosome \
	--make-bed \
	--biallelic-only \
	--double-id \
	--exclude-snp rs16959560 \
	--geno 0.01 \
	--indep-pairwise 50 5 0.2 \
	--maf 0.35 \
	--mind 0.1 \
	--out 1kgp3_ps-data
	

# Split qc-camgwas data by region (Buea, Y'de and D'la)
for file in *_sample.ids; do
plink \
	--bfile ../analysis/qc-camgwas-updated-autosome \
	--keep $file \
	--allow-no-sex \
	--make-bed \
	--out ${file/.ids/s};

done

