#!/bin/bash

if [[ $# == 3 ]]; then
   
    in_vcf="$1"
    maf="$2"
    outname="$3"

    for i in {1..30}; do
        #---- Shuffle samples to get random perm for BA and SB (50 each)
        shuf -n 50 sbantu.txt -o sbantu50.txt; awk '{print $1,$1,$2}' sbantu50.txt > perm${i}.txt
        shuf -n 50 bantu.txt -o bantu50.txt; awk '{print $1,$1,$2}' bantu50.txt >> perm${i}.txt
    
        #---- Combine subsamples with 28 Fulbe individuals
        awk '{print $1,$1,$2}' fulbe.txt >> perm${i}.txt

            #-------- LD-prune the raw data
            plink \
                --vcf ${in_vcf} \
                --allow-no-sex \
        	--keep-allele-order \
        	--aec \
        	--threads 4 \
                --indep-pairwise 5k 50 0.2 \
                --out pruned
        
            #-------- Now extract the pruned SNPs to perform check-sex on
            plink \
                --vcf ${in_vcf} \
                --allow-no-sex \
        	--keep-allele-order \
        	--maf ${maf} \
        	--aec \
		--make-bed \
        	--keep perm${i}.txt \
        	--threads 4 \
        	--double-id \
                --out ${outname}-${i}
        
            #-------- Run Fst with the current shuffle 
            plink \
        	--bfile ${outname}-${i} \
		--fst \
        	--within perm${i}.txt \
		--keep-allele-order \
		--out ${outname}-${i} \
            
            rm pruned* ${outname}-${i}.nosex ${outname}-${i}.bed ${outname}-${i}.fam ${outname}-${i}.bim
        done

else
    echo """
    Usage:./fst_prep.sh <in-vcf(plus path)> <maf> <bfile-outname>
    """
fi
