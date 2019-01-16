#!/usr/bin/env bash

#mv 1000G/merged1kp3 .
plink \
	--bfile merged1kp3 \
	--thin-indiv-count 360 \
	--autosome \
	--make-bed \
	--exclude-snp rs16959560 \
	--keep-allele-order \
	--biallelic-only \
	--out 1kGp3

cut -f2 1kGp3.bim > thinned.rs.ids

plink \
	--bfile qc-camgwas \
	--make-bed \
	--biallelic-only \
	--extract thinned.rs.ids \
	--autosome \
	--allow-no-sex \
	--out qc-data

plink \
	--bfile qc-data \
	--bmerge 1kGp3 \
	--make-bed \
	--autosome \
	--biallelic-only \
	--allow-no-sex \
	--out merge

plink \
	--bfile merge \
	--indep-pairwise 50 5 0.2 \
	--allow-no-sex \
	--biallelic-only \
	--out merge

plink \
	--bfile merge \
	--extract merge.prune.in \
	--allow-no-sex \
	--genome \
	--biallelic-only \
	--out merge

plink \
	--bfile merge \
	--read-genome merge.genome \
	--cluster --mds-plot 2 \
	--out mds-data

# Retrieve the 1000Genome Phase sample bfile from the website by visiting
# http://www.internationalgenome.org/data-portal/sample
# Then click on Phase 3 to filter and then hit the button to download the list

# Replace gaps in the list with underscore '_'
sed 's/ /_/g' igsr_samples.tsv > igsr_phase3.samples

# Extract ids of the 360 randomly generated phase 3 samples
cut -f1 -d' ' 1kGp3.fam > 3601kGp3.ids

# Now obtain the ids and their corresponding populations in the igsr_phase3.samples file
echo "IID Status" > merge.txt
grep -f 3601kGp3.ids igsr_phase3.samples | cut -f1,4 >> merge.txt

# Also obtain the ids of the remaining dataset in qc-data.fam and corresponding status in the large sample bfile
cut -f1 -d' ' qc-data.fam > qc-data.ids
grep -f qc-data.ids tmp/Cameroon_GWAS-2.5M_b37_release.sample | cut -f1,9 -d' ' >> merge.txt

# Now Compute 10 axes of genetic variation to determine pop structure
plink \
	--bfile qc-camgwas \
	--autosome \
	--indep-pairwise 50 5 0.2 \
	--out qc-data

plink \
	--bfile qc-camgwas \
	--autosome \
	--extract qc-data.prune.in \
	--genome \
	--out qc-data

plink \
	--bfile qc-camgwas \
	--read-genome qc-data.genome \
	--cluster \
	--mds-plot 10 \
	--out ps-data

##############################################################################################
#					Generate Plots in R				     #
##############################################################################################
echo "Now generating MDS and Population structure plots in R. Please wait... "

R CMD BATCH popstruct.R


