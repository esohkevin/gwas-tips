#!/usr/bin/env bash

base="qc-camgwas.chr"
rm phaseCommands.txt

for i in $(seq 1 22); do

	echo "-B ${base}${i} -M 1000GP_Phase3/genetic_map_chr${i}_combined_b37.txt -O ${base}${i}.phased -T 8 --burn 10 --prune 10 --main 50 --states 200 --window 2 --effective-size 20000 --seed 123456789" >> phaseCommands.txt
done

# Run SHAPEIT2 with the commands in the command file
cat phaseCommands.txt | xargs -P8 -n8 shapeit_v2 &

# Convert HAPS/SAMPLE to HAPS/LEGEND/SAMPLE formats for IMPUTE2
#shapeit_v2 -convert \
#        --input-haps ${base}.phased \
#        --output-ref ${base}.phased.hap ${base}.phased.leg ${base}.phased.sam
