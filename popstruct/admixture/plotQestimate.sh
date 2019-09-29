#!/bin/bash

for k in {1..8}; do
    Rscript plotQestimate.R afr-data.${k}.Q afr-data.${k}.png
done

echo "K CVE" > adm-k-parameters.txt; grep -h CV $1 | \
	cut -f3,4 -d' ' | \
	sed 's/(K\=//g' | \
	sed 's/)://g' | sort >> adm-k-parameters.txt

Rscript plotCV.R

#mv *.png ../../images/

#rm prune*
