#!/bin/bash

if [[ $# == 2 ]]; then
   in_vcf="$1"
   #popA="$2"
   #popB="$3"
   #popC="$4"
   out="$2"

   mkdir -p vcfout

   for i in {1..100}; do

        #---- Shuffle samples to get random perm for BA and SB (50 each)
        shuf -n 50 ../sbantu.txt -o sbantu50.txt; awk '{print $1,$1,$2}' sbantu50.txt > sbantu${i}.txt
        shuf -n 50 ../bantu.txt -o bantu50.txt; awk '{print $1,$1,$2}' bantu50.txt > bantu${i}.txt

        #---- Combine subsamples with 28 Fulbe individuals
        awk '{print $1,$1,$2}' ../fulbe.txt > fulbe${i}.txt

       vcftools \
	   --gzvcf ${in_vcf} \
           --weir-fst-pop bantu${i}.txt \
           --weir-fst-pop fulbe${i}.txt \
	   --weir-fst-pop sbantu${i}.txt \
	   --out vcfout/$out-${i}

       cat bantu${i}.txt fulbe${i}.txt sbantu${i}.txt > vcfout/perm${i}.txt
       rm bantu${i}.txt fulbe${i}.txt sbantu${i}.txt

   done

else
   echo """
	Usage:./fst_vcft.sh <in-vcf.gz> <out_name>
   """
fi
