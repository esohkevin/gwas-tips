#!/bin/bash

shapeit_v2 \
	-check \
        -B qc-camgwas-updated-chr23 \
        --output-log qc-camgwas-updated-chr23 \
        --chrX

shapeit_v2 \
	-B qc-camgwas-updated-chr23 \
        -M 1000GP_Phase3/genetic_map_chrX_nonPAR_combined_b37.txt \
        -O qc-camgwas-updated-chrX.phased \
        --chrX \
	-T 15 \
	--burn 10 \
	--prune 10 \
	--main 50 \
	--states 200 \
	--window 2 \
	--effective-size 20000 \
	--seed 123456789
