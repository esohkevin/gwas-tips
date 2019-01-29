#!/bin/bash

phase() {
echo """
usage:	0 - Phase without reference
	1 - Phase with reference
"""
phasewref="$1"
inclu_grp="AFR"
base_dir="$HOME/GWAS/Git/GWAS/phase/"
new_dir="$HOME/GWAS/Git/GWAS/phase/phasewref/"
ref_dir="$HOME/GWAS/Git/GWAS/phase/1000GP_Phase3/"
base="qc-camgwas-updated-chr"

if [[ "$phasewref" == "0" ]];
then
	rm phaseCommands.txt

	for i in $(seq 1 22); do

		echo "-B ${base}${i} -M 1000GP_Phase3/genetic_map_chr${i}_combined_b37.txt -O ${base}${i}.phased -T 8 --burn 10 --prune 10 --main 50 --states 200 --window 2 --effective-size 20000 --seed 123456789" >> phaseCommands.txt
	done

	# Run SHAPEIT2 without reference panel with the commands in the command file
	cat phaseCommands.txt | xargs -P8 -n8 shapeit_v2 &
else
	echo -e "\n"
fi

if [[ "$phasewref" == "1" ]];
then
	for i in $(seq 1 22); 
	do
		if [[ ! -f "${base_dir}${base}${i}.alignments.snp.strand.exclude" ]]; 
		then
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

	for i in $(seq 1 22); 
	do
		shapeit_v2 \
		-B ${base}${i} \
        	-M ${ref_dir}genetic_map_chr${i}_combined_b37.txt \
        	--input-ref ${ref_dir}1000GP_Phase3_chr${i}.hap.gz ${ref_dir}1000GP_Phase3_chr9.legend.gz ${ref_dir}1000GP_Phase3.sample \
        	--exclude-snp ${base}${i}.alignments.snp.strand.exclude \
        	--include-grp group.list \
		-T 8 \
		--burn 15 \
		--prune 10 \
		--main 60 \
		--states 300 \
		--window 2 \
		--effective-size 20000 \
		--seed 123456789 \
        	-O ${new_dir}${base}${i}.phased.with.ref
	done
else
	echo -e "\n"
fi

if [[ "$phasewref" == "0" || "$phasewref" == "1" ]]
then
	echo -e "\nNow concerting HAPS/SAMPLE to HAPS/LEGEND/SAMPLE format\n"

# Convert HAPS/SAMPLE to HAPS/LEGEND/SAMPLE formats for IMPUTE2
	for i in $(seq 1 22);
	do
		shapeit_v2 \
			-convert \
        		--input-haps ${new_dir}${base}${i}.phased \
        		--output-ref ${new_dir}${base}${i}.phased.hap ${new_dir}${base}${i}.phased.leg ${new_dir}${base}${i}.phased.sam
	done
else
	echo -e "\nSorry we do not understand your choice. PLease enter "0" to phase without reference or "1" to phase with reference"
fi
}
