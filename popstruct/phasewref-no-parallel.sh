#!/bin/bash

inclu_grp="AFR"
#base_dir=""
new_dir="./"
ref_dir="../phase/1000GP_Phase3/"
#base="qc-camgwas-updated-chr"
out_dir="../phase/"

# Check the datset for missingness
#for chr in $(seq 1 22); do 
#	if [[ ! -f "qc-camgwas-updated-chr"${chr}".alignments.snp.strand.exclude" ]]; 
#	then 
#		shapeit_v2 \
#			-check \
#                        -B qc-camgwas-updated-chr"${chr}" \
#                        -M "${ref_dir}"genetic_map_chr"${chr}"_combined_b37.txt \
#                        --input-ref "${ref_dir}"1000GP_Phase3_chr"${chr}".hap.gz "${ref_dir}"1000GP_Phase3_chr"${chr}".legend.gz "${ref_dir}"1000GP_Phase3.sample \
#                        --output-log qc-camgwas-updated-chr"${chr}".alignments
#	else
#		echo -e "\nStrand alignmnets checked already. Proceeding to phasing with reference panel..."
#	fi
#done

# Get Population group of interest (AFR)
echo "${inclu_grp}" > group.list

# Check the existence of the .exclude files before phasing

# Phase each chromosome independently with reference
for chr in 11; do
	if [[ ! -f "qc-camgwas-updated-chr"${chr}".alignments.snp.strand.exclude" ]];
        then
		shapeit_v2 \
                	-B qc-camgwas-updated-chr"${chr}" \
                	-M "${ref_dir}"genetic_map_chr"${chr}"_combined_b37.txt \
                	-T 30 \
                	--burn 10 \
                	--prune 10 \
                	--main 50 \
                	--states 200 \
                	--window 2 \
                	--effective-size 17469 \
                	--input-ref "${ref_dir}"1000GP_Phase3_chr"${chr}".hap.gz "${ref_dir}"1000GP_Phase3_chr"${chr}".legend.gz "${ref_dir}"1000GP_Phase3.sample \
                	--seed 123456789 \
                	--include-grp group.list \
                	-O qc-camgwas-updated-chr"${chr}".phased.with.ref
	else
		shapeit_v2 \
			-B qc-camgwas-updated-chr"${chr}" \
			-M "${ref_dir}"genetic_map_chr"${chr}"_combined_b37.txt \
			-T 30 \
			--burn 10 \
			--prune 10 \
			--main 50 \
			--states 200 \
			--window 2 \
			--effective-size 17469 \
			--input-ref "${ref_dir}"1000GP_Phase3_chr"${chr}".hap.gz "${ref_dir}"1000GP_Phase3_chr"${chr}".legend.gz "${ref_dir}"1000GP_Phase3.sample \
			--seed 123456789 \
			--exclude-snp qc-camgwas-updated-chr"${chr}".alignments.snp.strand.exclude \
			--include-grp group.list \
			-O qc-camgwas-updated-chr"${chr}".phased.with.ref
	fi
done

################# Phasing ChrX ################################
# Check for missingness
#shapeit_v2 \
#	-check \
#	-B qc-camgwas-updated-chr23 \
#        --output-log gwas.chrX.log \
#	-T 30 \
#        --chrX

# Phase chrX with reference
#shapeit_v2 \
#	-B qc-camgwas-updated-chr23 \
#        -M "${ref_dir}"genetic_map_chrX_nonPAR_combined_b37.txt \
#        -O "${out_dir}"qc-camgwas-chrX.phased \
#	-T 30 \
#        --chrX \
#        --input-ref "${ref_dir}"1000GP_Phase3_chrX_NONPAR.hap.gz "${ref_dir}"1000GP_Phase3_chrX_NONPAR.legend.gz "${ref_dir}"ref_chrX.sample
