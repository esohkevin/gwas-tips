#!/bin/bash

#phase() {
echo """
usage:	0 - Phase without reference
	1 - Phase with reference
"""
phasewref="$1"
inclu_grp="AFR"
#base_dir=""
new_dir="phasewref/"
ref_dir="1000GP_Phase3/"
base="qc-camgwas-updated-chr"
out_dir="../phase/"

if [[ "$phasewref" == "0" ]];
then
	rm phaseCommands.txt

	for i in $(seq 1 22); do

		echo " -B ${base}${i} -M ${ref_dir}genetic_map_chr${i}_combined_b37.txt -O ${out_dir}${i}.phased -T 12 --burn 10 --prune 10 --main 50 --states 200 --window 2 --effective-size 20000 --seed 123456789" >> phaseCommands.txt
	done

	# Run SHAPEIT2 without reference panel with the commands in the command file
	cat phaseCommands.txt | xargs -P12 -n12 shapeit_v2 &

elif [[ "$phasewref" == "1" ]];
then
	for i in $(seq 1 22); 
	do
		if [[ ! -f "${base}${i}.alignments.snp.strand.exclude" ]]; 
		then
			shapeit_v2 \
			-check \
        		-B ${base}${i} \
	        	-M ${ref_dir}genetic_map_chr${i}_combined_b37.txt \
        		--input-ref ${ref_dir}1000GP_Phase3_chr${i}.hap.gz ${ref_dir}1000GP_Phase3_chr9.legend.gz ${ref_dir}1000GP_Phase3.sample \
	        	--output-log ${base}${i}.alignments
		else
			echo -e "\nStrand alignmnets checked already. Proceeding to phasing with reference panel..."
		fi
	done

	echo "${inclu_grp}" > group.list
	rm phase.txt
	for i in $(seq 1 22); 
	do
	echo "--input-bed ${base}${i} -M ${ref_dir}genetic_map_chr${i}_combined_b37.txt --input-ref ${ref_dir}1000GP_Phase3_chr${i}.hap.gz ${ref_dir}1000GP_Phase3_chr9.legend.gz ${ref_dir}1000GP_Phase3.sample --exclude-snp ${base}${i}.alignments.snp.strand.exclude --include-grp group.list -T 12 --burn 15 --prune 10 --main 60 --states 300 --window 2 --effective-size 20000 --seed 123456789 -O ${new_dir}${base}${i}.pwref" >> phase.txt
	done
	cat phase.txt | xargs -P12 -n12 shapeit_v2 &
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
        		--input-haps ${new_dir}${base}${i}.pwref \
        		--output-ref ${new_dir}${base}${i}.phased.hap ${new_dir}${base}${i}.phased.leg ${new_dir}${base}${i}.phased.sam
	done
else
	echo -e "\nSorry we do not understand your choice. Please enter "0" to phase without reference or "1" to phase with reference"
fi
#}
