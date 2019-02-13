#!/bin/bash

inclu_grp="AFR"
base_dir="$HOME/GWAS/Git/GWAS/phase/"
new_dir="$HOME/GWAS/Git/GWAS/phase/phasewref/"
ref_dir="$HOME/GWAS/Git/GWAS/phase/1000GP_Phase3/"
base="qc-camgwas-updated-chr"

for i in $(seq 1 22); do
if [[ ! -f "${base_dir}${base}${i}.alignments.snp.strand.exclude" ]]; then

shapeit_v2 \
	-check \
        -B ${base_dir}${base}${i} \
        -M ${ref_dir}genetic_map_chr${i}_combined_b37.txt \
        --input-ref ${ref_dir}1000GP_Phase3_chr${i}.hap.gz ${ref_dir}1000GP_Phase3_chr9.legend.gz ${ref_dir}1000GP_Phase3.sample \
        --output-log ${base_dir}${base}${i}.alignments
else
	echo -e "\nStrand alignmnets checked already. Proceeding to phasing with reference panel..."
fi
done

echo "${inclu_grp}" > group.list

#for i in $(seq 1 22); do
#shapeit_v2 \
#	-B ${base}${i} \
#        -M ${ref_dir}genetic_map_chr${i}_combined_b37.txt \
#        --input-ref ${ref_dir}1000GP_Phase3_chr${i}.hap.gz ${ref_dir}1000GP_Phase3_chr9.legend.gz ${ref_dir}1000GP_Phase3.sample \
#        --exclude-snp ${base}${i}.alignments.snp.strand.exclude \
#        --include-grp group.list \
#	-T 8 \
#	--burn 15 \
#	--prune 10 \
#	--main 60 \
#	--states 300 \
#	--window 2 \
#	--effective-size 20000 \
#	--seed 123456789 \
#        -O ${new_dir}${base}${i}.phased.with.ref
#done

#echo -e "\nNow concerting HAPS/SAMPLE to HAPS/LEGEND/SAMPLE format\n"

# Convert HAPS/SAMPLE to HAPS/LEGEND/SAMPLE formats for IMPUTE2
#shapeit_v2 -convert \
#        --input-haps ${new_dir}${base}.phased \
#        --output-ref ${new_dir}${base}.phased.hap ${new_dir}${base}.phased.leg ${new_dir}${base}.phased.sam
