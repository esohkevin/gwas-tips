#!/bin/bash
home="$HOME/Git/GWAS/"
phase="${home}phase/"
sam="${home}samples/"

############################ Run Phasing and Imputation Pipeline ##########################
# Phasing
#./run_wphase_ref.sh

source ${phase}vcf2impute2.sh 
source ${phase}makeChunkIntervals.sh
source ${phase}concatChunks.sh 
source ${phase}run_imput2.sh 
source ${phase}qct2gen.sh

# Convert Phased VCF to IMPUTE2 .haps and .sample
vcf2impute2 ${sam}exclude_fo.txt		# include_semibantu.txt include_bantu.txt exclude_fo.txt

makeChunkIntervals 1000000

# Imputation
run_impute2 2 1 22

# Concatenate Chunks into full chromosomes
#concatChunks


# Convert GEN file to VCF and PLINK format using qctool and PLINK2
#qct2gen
