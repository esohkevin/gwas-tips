#!/bin/bash

imputed_path="imputed/"

for chr in {1..22}; do

   rm concat_chr"${chr}"_Chunks.txt
   rm chr"${chr}"_imputed.gen*
   `touch chr"${chr}"_imputed.gen`


  if [[ -f "chr${chr}-phased_wref.haps" ]]; then

     for interval in `cat chr${chr}intervals.txt`; do

          echo """chr"${chr}"_"${interval/=*/_imputed.gen}"""" >> concat_chr"${chr}"_Chunks.txt

     done

  for chunk in `cat concat_chr"${chr}"_Chunks.txt`; do
      
      cat ${chunk} >> chr"${chr}"_imputed.gen

  done

      bgzip -i chr"${chr}"_imputed.gen

   fi

done

