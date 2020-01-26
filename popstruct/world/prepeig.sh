#!/bin/bash

analysis="../../analysis/"
samples="../../samples/"
kgp="../../1000G/"
imput="../../assoc_results/"
maf="$1"


if [[ $# == 1 ]]; then
    # Prune to get only SNPs at linkage equilibrium (independent SNPs - no LD between them)
    plink \
    	--bfile worldPops/merge-set \
    	--indep-pairwise 50kb 1 0.2 \
    	--allow-no-sex \
    	--out prune
    
    plink \
    	--bfile worldPops/merge-set \
    	--autosome \
    	--extract prune.prune.in \
    	--maf ${maf} \
	--geno 0.05 \
    	--make-bed \
    	--out merged-data-pruned
    
    # Convert bed to ped required for CONVERTF
    plink \
    	--bfile merged-data-pruned \
    	--recode \
    	--allow-no-sex \
    	--keep-allele-order \
    	--double-id \
    	--out CONVERTF/qc-world
    
    # Prepare ethnicity template file
    grep "_" worldPops/merge-set.fam | awk '{print $1}' > cam.ids
    grep -f cam.ids ${samples}1471-eth_template.txt > cam.eth
    sort --key=2 cam.eth > camAll.eth
    cat camAll.eth worldPops/2504world.eth > merged-data-eth_template.txt
    
    #Rscript prepPopList.R
    #sed '1d' poplist.txt > CONVERTF/ethlist.txt
    
    for file in phase* cam.eth cam.ids updatePhaseName.txt prune.*; do
        if [[ -f $file ]]; then
            rm $file
        fi
    done

else
    echo """
	Usage: ./prepeig.sh <maf-thresh>
    """
fi
