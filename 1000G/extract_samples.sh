#!/usr/bin/env bash

sed 's/ /_/g' igsr_phase3.samples.tsv > igsr_phase3.samples
head -1 igsr_phase3.samples > selectedPh3.sample
grep "1000_Genomes_phase_3_release"  igsr_phase3.samples | \
cut -f4 | sort | uniq > pop.code

for i in $(cat pop.code)
do
	grep $i igsr_phase3.samples | head -30 >> selectedPh3.sample
done
cut -f1 selectedPh3.sample | \
grep -v "Sample" > id
paste id id > selected.sample.ids
rm id
echo "Done!"
