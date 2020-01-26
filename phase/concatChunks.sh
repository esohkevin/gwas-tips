#!/bin/bash

home="$HOME/Git/GWAS/"
imputed_path="${home}allimp/"

concatChunks() {
   for chr in {1..22}; do
     for interval in $(cat chr${chr}intervals.txt); do
      if [[ -f "chr"${chr}"_"${interval/=*/_imputed.gen.gz}"" ]]; then
         if [[ -f "concat_chr"${chr}"_Chunks.txt" || -f "chr"${chr}"_imputed.gen.gz" ]]; then
            rm concat_chr"${chr}"_Chunks.txt chr"${chr}"_imputed.gen.gz
         fi
         echo """chr"${chr}"_"${interval/=*/_imputed.gen.gz}"""" >> concat_chr"${chr}"_Chunks.txt
         for chunk in $(cat concat_chr"${chr}"_Chunks.txt); do
               zcat $chunk | \
                 awk '$4=="A" || $4=="T" || $4=="G" || $4=="C"' | \
                 awk '$5=="A" || $5=="T" || $5=="G" || $5=="C"' | bgzip -c >> chr"${chr}"_imputed.gen.gz
               cat ${chunk/.gz/_info} | \
                 awk '$4=="A" || $4=="T" || $4=="C" || $4=="G"' | \
                 awk '$5=="A" || $5=="T" || $5=="C" || $5=="G"' | \
                 awk '$7>=0.75 {print $2}' > chr${chr}_imputed.gen.include
         done
      else 
         echo -e "\nChunk "chr"${chr}"_"${interval/=*/_imputed.gen.gz}"" could not be found! Skipping..."
      fi
     done
   done
}
