#!/bin/bash

# Convert merged filtered and updated imputed file to Oxford .gen + .sample
plink \
	--bfile merge.filtered-updated \
        --allow-no-sex \
        --recode oxford gen-gz \
        --keep-allele-order \
        --double-id \
        --out merge.filtered-updated	
