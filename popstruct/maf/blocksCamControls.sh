#!/bin/bash

if [[ $# -lt 5 || $# -gt 5 ]]; then
    echo """    Usage: ./blocksCam.sh <chr#> <from-kb> <to-kb> <gene-name> <blocks-min-maf>
                where 'blocks-min-maf' is the value for the minimum MAF you wish to use
"""
else
    if [[ -f "all$4.blocks$5.det" ]]; then
       rm all$4.blocks$5.det
    fi

    for pop in bantu semibantu fulbe; do

        plink \
            --bfile ../eig/world/cam-controls \
            --blocks no-pheno-req \
            --blocks-min-maf $5 \
            --chr $1 \
            --geno 0.00001 \
	    --filter-controls \
            --from-kb $2 \
            --blocks-strong-lowci 0.80 \
            --blocks-strong-highci 0.98 \
            --to-kb $3 \
            --keep ${pop}.txt \
            --out ${pop}"$4"

    echo -e "\n############ <<<<< ${pop} >>>>> #############" >> all$4.blocks$5.det
    cat ${pop}"$4".blocks.det >> all$4.blocks$5.det
    rm ${pop}"$4".blocks*
    done
#rm *.log
fi

#--blocks-max-kb 94 \

