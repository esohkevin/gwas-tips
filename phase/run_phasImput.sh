#!/bin/bash

############################ Run Phasing and Imputation Pipeline ##########################

# Phasing
./run_wphase_ref.sh


# Convert Phased VCF to IMPUTE2 .haps and .sample
./vcf2impute2.sh


# Imputation
./run_imput2.sh


# Concatenate Chunks into full chromosomes
./concatChunks.sh


