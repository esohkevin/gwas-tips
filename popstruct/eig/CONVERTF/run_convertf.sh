#!/bin/bash

analysis="../../../analysis/"

# Prune the qc-dataset for SNPs within 50bp with r^2 < 0.2 using a window of 5 SNPs
plink \
        --bfile "${analysis}"qc-camgwas-updated \
        --indep-pairwise 50 5 0.2 \
        --allow-no-sex \
	--keep-allele-order \
	--hwe 1e-8 \
        --autosome \
        --biallelic-only \
        --out qc-ldPruned
cat qc-ldPruned.log > convertf.log

plink \
        --bfile "${analysis}"qc-camgwas-updated \
        --extract qc-ldPruned.prune.in \
        --allow-no-sex \
        --autosome \
        --make-bed \
        --out qc-camgwas-ldPruned
cat qc-camgwas-ldPruned.log >> convertf.log

plink \
	--bfile qc-camgwas-ldPruned \
	--recode \
	--allow-no-sex \
	--keep-allele-order \
	--double-id \
	--out qc-camgwas
cat qc-camgwas.log >> convertf.log

rm qc-ldPruned* qc-camgwas-ldPruned*

# Convert files into eigensoft compartible formats

echo -e "\n### PED to PACKEDPED ###" >> convertf.log
convertf -p par.PED.PACKEDPED >>convertf.log

echo -e "\n### PACKEDPED to PACKEDANCESTRYMAP ###" >> convertf.log
convertf -p par.PACKEDPED.PACKEDANCESTRYMAP >>convertf.log	

echo -e "\n### PACKEDANCESTRYMAP to ANCESTRYMAP ###" >> convertf.log
convertf -p par.PACKEDANCESTRYMAP.ANCESTRYMAP >>convertf.log

echo -e "\n### ANCESTRYMAP to EIGENSTRAT ###" >> convertf.log
convertf -p par.ANCESTRYMAP.EIGENSTRAT >>convertf.log

#convertf -p par.PED.EIGENSTRAT
