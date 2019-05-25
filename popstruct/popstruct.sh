#!/usr/bin/env bash

# Obtain rsIDs of the study dataset for subsequent extraction from the 1000G Phase 3 dataset
cut -f2 ../analysis/qc-camgwas-updated.bim > qc-rs.ids

# Extract from 1000G Phase dataset only rsIDs present in the study dataset with 1% missing genotype and MAF > 0.35,
# While thinning it to obtain 780 individuals with at most 10% missingness.
# Also exclude any SNPs that case plink to error out.
plink \
	--vcf ../1000G/Phase3_merged.vcf.gz \
	--thin-indiv-count 1000 \
	--autosome \
	--extract qc-rs.ids \
	--mind 0.1 \
        --maf 0.35 \
        --geno 0.01 \
	--allow-no-sex \
	--make-bed \
	--exclude-snp rs16959560 \
	--biallelic-only \
	--out 1kGp3
cat 1kGp3.log > log.file

# Obtain the rsIDs of the thinned 1000G dataset for subsequent extraction from the study dataset
cut -f2 1kGp3.bim > thinned.rs.ids

# Extract the thinned rsIDs of the from the study dataset to be sure we'll be working on the same set of SNPs in the study and the 1000G dataset for MDS and Population structure
plink \
	--bfile ../analysis/qc-camgwas-updated \
	--make-bed \
	--biallelic-only \
	--extract thinned.rs.ids \
	--autosome \
	--allow-no-sex \
	--out qc-data
cat qc-data.log >> log.file

# Merge the thinned dataset and the study dataset together
plink \
	--bfile qc-data \
	--bmerge 1kGp3 \
	--make-bed \
	--autosome \
	--biallelic-only \
	--allow-no-sex \
	--out merge
cat merge.log >> log.file

# Prune the merged dataset for SNPs within 50bp with r^2 < 0.2 using a window of 5 SNPs
plink \
	--bfile merge \
	--indep-pairwise 50 5 0.2 \
	--allow-no-sex \
	--biallelic-only \
	--out merge
cat merge.log >> log.file

# Generate an IBD report with the pruned set
plink \
	--bfile merge \
	--extract merge.prune.in \
	--allow-no-sex \
	--genome \
	--biallelic-only \
	--out merge
cat merge.log >> log.file

# Use the IBD report to perform MDS with two (2) axes of genetic variation
plink \
	--bfile merge \
	--read-genome merge.genome \
	--cluster --mds-plot 2 \
	--out mds-data
cat mds-data.log >> log.file

# Retrieve the 1000Genome Phase sample bfile from the website by visiting
# http://www.internationalgenome.org/data-portal/sample
# Then click on Phase 3 to filter and then hit the button to download the list

# Replace gaps in the list with underscore '_'
sed 's/ /_/g' igsr_samples.tsv > igsr_phase3.samples

# Extract ids of the thinned 1000G Phase 3 samples
cut -f1 -d' ' 1kGp3.fam > 3601kGp3.ids

# Now obtain the ids and their corresponding populations in the igsr_phase3.samples file
echo "IID Status" > merge.txt
grep -f 3601kGp3.ids igsr_phase3.samples | cut -f1,4 >> merge.txt

# Also obtain the ids of the remaining dataset in qc-data.fam and corresponding status in the large sample bfile
cut -f1 -d' ' qc-data.fam > qc-data.ids
grep -f qc-data.ids ../tmp/Cameroon_GWAS-2.5M_b37_release.sample | cut -f1,9 -d' ' >> merge.txt

# Now Compute 10 axes of genetic variation to determine pop structure
plink \
	--bfile ../analysis/qc-camgwas-updated \
	--autosome \
	--indep-pairwise 50 5 0.2 \
	--out qc-data
cat qc-data.log >> log.file

plink \
	--bfile ../analysis/qc-camgwas-updated \
	--autosome \
	--extract qc-data.prune.in \
	--genome \
	--out qc-data
cat qc-data.log >> log.file

plink \
	--bfile ../analysis/qc-camgwas-updated \
	--read-genome qc-data.genome \
	--cluster \
	--mds-plot 10 \
	--out ps-data
cat ps-data.log >> log.file

echo """
##############################################################################################
#			Generate MDS and Pop Structure Plots in R			     #
##############################################################################################
"""
echo "Now generating MDS and Population structure plots in R. Please wait..."

R CMD BATCH popstruct.R

mv *.png ../images/

################ Fst Estimates #######################
# For 1KGP3 populations
#plink \
#	--bfile 1kgp3_ps-data \
#	--extract 1kgp3_ps-data.prune.in \
#	--fst \
#	--within 1kgp3-cluster.txt \
#	--make-bed \
#	--double-id \
#	--out fst

