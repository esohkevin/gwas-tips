#!/bin/bash

if [[ $# == 4 ]]; then
   
    in_vcf="$1"
    maf="$2"
    outname="$3"

    for i in {1..10}; do
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
    	    --autosome \
    	    --threads $4 \
            --indep-pairwise 5k 100 0.1 \
            --out pruned
    
        #-------- Now extract the pruned SNPs to perform check-sex on
        plink \
            --vcf ${in_vcf} \
            --allow-no-sex \
    	    --keep-allele-order \
    	    --maf ${maf} \
    	    --aec \
    	    --keep perm${i}.txt \
    	    --autosome \
    	    --threads $4 \
    	    --double-id \
            --extract pruned.prune.in \
            --recode vcf-fid bgz \
    	    --real-ref-alleles \
            --out ${outname}-${i}
    
        #-------- Get 
        #plink \
    	#--bfile fst-ready
    	#--out fst-ready
    	#--recode 12
    
        
        #-------- Pull sample IDs based on column number
        #awk '{print $1, $1, $17}' ../eig/EIGENSTRAT/merged.pca.evec | sed '1d' | grep -v NA > stat.txt
        #awk '{print $1, $1, $15}' ../eig/EIGENSTRAT/merged.pca.evec | sed '1d' | grep -v NA > dsex.txt
        #awk '{print $1, $1, $19}' ../eig/EIGENSTRAT/merged.pca.evec | sed '1d' | grep -v NA > alt.txt
        #awk '{print $1, $1, $20}' ../eig/EIGENSTRAT/merged.pca.evec | sed '1d' | grep -v NA > age.txt
        #awk '{print $1, $1, $21}' ../eig/EIGENSTRAT/merged.pca.evec | sed '1d' | grep -v NA > para.txt
    
        #awk '{print $1,$4}' ${outname}.bim | sed 's/ /:/' > temp.txt
        #tr "\n" "," < temp.txt | sed 's/,$//' > snps.txt
        #snps=$(cat snps.txt)
        #echo "bcftools view -t ${snps} --threads 4 -Oz -o hier.vcf.gz ${in_vcf}" > get_hier.sh
        #chmod 755 get_hier.sh
    
        #./get_hier.sh
    
        rm pruned* *.nosex
    
    done

else
    echo """
    Usage:./fst_prep.sh <in-vcf(plus path)> <maf> <bfile-outname> <threads>
    """
fi
