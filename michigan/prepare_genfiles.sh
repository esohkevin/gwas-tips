#!/bin/bash

eigId_path="$HOME/GWAS/Git/GWAS/popstruct"

plink 
	--bfile merge.filtered-updated \
	--allow-no-sex \
	--recode oxford gen-gz \
	--keep-allele-order \
	--double-id \
        --keep $eigId_path/eig-camgwas.ids \
	--autosome \
	--out merge.filtered-updated \

