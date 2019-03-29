#!/usr/bin/env bash

base="qc-camgwas-updated-chr"

### Separate job into into rounds
# First round from chr1 to chr11
rm phaseCommands.txt
for i in $(seq 1 11); do

	echo "-B ${base}${i} -M 1000GP_Phase3/genetic_map_chr${i}_combined_b37.txt -O ../phase/${base}${i}.phased -T 12 --burn 10 --prune 10 --main 50 --states 200 --window 2 --effective-size 20000 --seed 123456789" >> phaseCommands.txt
done

# Run SHAPEIT2 with the commands in the command file
cat phaseCommands.txt | xargs -P12 -n12 shapeit_v2 &

# Second round from chr12 to chr22
rm phaseCommands.txt
for i in $(seq 12 22); do

        echo "-B ${base}${i} -M 1000GP_Phase3/genetic_map_chr${i}_combined_b37.txt -O ../phase/${base}${i}.phased -T 12 --burn 10 --prune 10 --main 50 --states 200 --window 2 --effective-size 20000 --seed 123456789" >> phaseCommands.txt
done

# Run SHAPEIT2 with the commands in the command file
cat phaseCommands.txt | xargs -P12 -n12 shapeit_v2 &

# Convert HAPS/SAMPLE to HAPS/LEGEND/SAMPLE formats for IMPUTE2
#shapeit_v2 -convert \
#        --input-haps ${base}${i}.phased \
#        --output-ref ${base}${i}.phased.hap ${base}${i}.phased.leg ${base}${i}.phased.sam
