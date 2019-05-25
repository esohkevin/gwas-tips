#!/bin/bash

analysis="../../../analysis/"
samples="../../../samples/"
kgp="../../../1000G/"

cut -f2 ../../../analysis/qc-camgwas-updated.bim | grep "rs" > extract-qc.rsids

# --thin-indiv-count 1500 \ add this line to get only 1500 individuals from 1KGP

# Get 1kgp individuals limiting to only common SNPs that are found in qc-camgwas data
plink \
       --vcf ${kgp}Phase3_merged.vcf.gz \
       --autosome \
       --extract extract-qc.rsids \
       --keep-allele-order \
       --mind 0.1 \
       --maf 0.35 \
       --geno 0.01 \
       --pheno update-1kgp.phe \
       --mpheno 1 \
       --update-sex update-1kgp.sex 1 \
       --allow-no-sex \
       --make-bed \
       --exclude-snp rs16959560 \
       --biallelic-only \
       --out worldPops/world-pops

#cut -f2 worldPops/qc-rsids-world-pops.bim > 1kgp.rsid

echo """
#########################################################################
#                          Updating QC rsids                            #
#########################################################################
"""
cut -f1,4 worldPops/world-pops.bim | \
        sed 's/\t/:/g' > qc-rsids-world.pos
cut -f2 worldPops/world-pops.bim > qc-rsids-world.ids
paste qc-rsids-world.ids qc-rsids-world.pos > qc-rsids-world-ids-pos.txt

plink \
        --bfile worldPops/world-pops \
        --update-name  qc-rsids-world-ids-pos.txt 2 1 \
        --allow-no-sex \
        --make-bed \
        --out worldPops/qc-rsids-world-pops
cat qc-rsids-world.log >> log.file

plink \
        --bfile worldPops/qc-rsids-world-pops \
        --update-name ${analysis}updateName.txt 1 2 \
        --allow-no-sex \
        --make-bed \
        --out worldPops/qc-rsids-world-pops
cat qc-rsids-world.log >> log.file

rm worldPops/qc-rsids-world-pops.bim~ worldPops/qc-rsids-world-pops.bed~ worldPops/qc-rsids-world-pops.fam~

