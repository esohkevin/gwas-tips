#!/bin/bash

imputConcordance() {
   for chr in {1..22}; do
       echo "snp_id rs_id position a0 a1 exp_freq_a1 info certainty type info_type0 concord_type0 r2_type0" > chr${chr}.snp.concord.txt;
       echo "concord_type0 r2_type0" > chr${chr}.sample.concord.txt;

       for chunk in chr${chr}_*_imputed.gen_info; do
           awk '$12>0' ${chunk} | grep -v "snp_id" >> chr${chr}.snp.concord.txt
       done

       for chunk in chr${chr}_*_imputed.gen_info_by_sample; do
           awk '$1>0' ${chunk} | grep -v "concord_type0" >> chr${chr}.sample.concord.txt
       done
   done
   
   cp  chr1.snp.concord.txt snp.concord.txt
   cp  chr1.sample.concord.txt sample.concord.txt

   for chr in {2..22}; do sed '1d' chr${chr}.snp.concord.txt >> snp.concord.txt; done
   for chr in {2..22}; do sed '1d' chr${chr}.sample.concord.txt >> sample.concord.txt; done

}
