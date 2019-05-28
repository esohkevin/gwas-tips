#!/bin/bash

for k in {1..5}; do
    Rscript plotQestimate.R adm-data.${k}.Q adm-data.${k}.png
done

echo "K CVE" > adm-k-parameters.txt; grep -h CV log*.out | \
	cut -f3,4 -d' ' | \
	sed 's/(K\=//g' | \
	sed 's/)://g' >> adm-k-parameters.txt

Rscript plotCV.R

mv *.png ../../images/
