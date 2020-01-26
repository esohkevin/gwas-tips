#!/bin/bash

for chr in {1..22}; do echo ../../phase/chr${chr}-phased_wref.vcf.gz 10 \'\\t\'; done > arg_file.txt

cat arg_file.txt | xargs -P22 -n3 ./prep_ldhat.sh

rm chr*-phased_wref.sites
