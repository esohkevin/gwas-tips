#!/bin/bash

analysis="../../analysis/"
samples="../../samples/"
kgp="../../1000G/"
world="../world/"
phase="../../phase/"

# Extract only a subset of world Pops to use (YRI+LWK+GWD+GBR+CHS+BEB+PUR). 
# The ids are stored in worldPops.ids
#cat cam.ids yri.ids adm.txt > adm.pops
#cut -f2 ${world}yri.bim > yri.rsids

if [[ $# == 5 ]]; then

    in_vcf="$1"
    snps="$2"
    maf="$3"
    out="$4"
    inord="$5"
    
    plink \
        --vcf ${in_vcf} \
        --allow-no-sex \
        --autosome \
	--double-id \
	--extract ${snps} \
    	--indiv-sort f ${inord} \
    	--make-bed \
        --out temp
    
    # Prune to get only SNPs at linkage equilibrium (independent SNPs - no LD between them)
    plink \
    	--bfile temp \
    	--indep-pairwise 50 10 0.2 \
    	--allow-no-sex \
    	--out prune
    cat prune.log >> log.file
    
    plink \
    	--bfile temp \
    	--autosome \
    	--maf $maf \
    	--extract prune.prune.in \
    	--make-bed \
    	--out $out
    
    rm temp*

# Prepare .pop file
Rscript prep-adm.R

else
    echo """
	Usage:./prep-adm.sh <in_vcf> <fst-snp-file> (specify paths) <MAF> <outname> <list [indiv-sort-order]>
    """

fi

