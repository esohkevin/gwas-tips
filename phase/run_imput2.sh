#!/bin/bash

home="$HOME/Git/GWAS/"
ref_path="${home}phase/1000GP_Phase3/"
imputed_path="${home}phase/imputed/"

run_impute2() {
   if [[ $# == 3 ]]; then   
      nj="$1"
      nl="$2"
      nh="$3"

      for chr in $(seq $nl $nh); do
        if [[ -f "chr${chr}-phased_wref.haps" ]]; then
           if [[ ! -f "chr${chr}intervals.txt" ]]; then
              echo -e "\nFound no chunk interval file for chr${chr}! Please run 'makeChunkIntervals'"
           else 
              if [[ -f "chr${chr}_chunks.txt" ]]; then
                 rm chr${chr}_chunks.txt
              fi
              for interval in `cat chr${chr}intervals.txt`; do
                if [[ ! -f "chr${chr}_${interval/=*/_imputed.gen.gz}" && ! -f "${imputed_path}chr${chr}_${interval/=*/_imputed.gen.gz}" ]]; then
   	           echo -e "-use_prephased_g -known_haps_g chr"${chr}"-phased_wref.haps -m "$ref_path"genetic_map_chr"${chr}"_combined_b37.txt -h "$ref_path"1000GP_Phase3_chr"${chr}".hap.gz -l "$ref_path"1000GP_Phase3_chr"${chr}".legend.gz  -int "${interval}" -Ne 20000 -os 0 1 2 3 -buffer 1000 -filt_rules_l 'TYPE==\"Biallelic_INDEL\"' 'TYPE==\"Biallelic_DEL\"' 'TYPE==\"Multiallelic_SNP\"' 'TYPE==\"Multiallelic_INDEL\"' 'TYPE==\"Multiallelic_CNV\"' 'TYPE==\"Biallelic_INV\"' 'TYPE==\"Biallelic_INS:MT\"' 'TYPE==\"Biallelic_INS:ME:SVA\"' 'TYPE==\"Biallelic_INS:ME:LINE1\"' 'TYPE==\"Biallelic_INS:ME:ALU\"' 'TYPE==\"Biallelic_DUP\"' 'AFR==0' -o_gz -o chr"${chr}"_"${interval/=*/_imputed.gen}"" >> chr${chr}_imput_chunks.txt
                else
                   echo "chr"${chr}"_"${interval/=*/_imputed.gen}" already exists! Its command line has not been included in chr${chr}_chunks.txt file! "
                fi
              done
              sed 's/1=/1 /g' chr${chr}_imput_chunks.txt > chr${chr}_chunks.txt; 		# Primary aim is to create this file for all chrs to use for parallele jod execution
              rm chr${chr}_imput_chunks.txt
   	      cat chr${chr}_chunks.txt | xargs -P$nj -n37 impute_v2.3.2 &			# Run IMPUTE2 with the commands in the files previously created
           fi
        else
           echo "chr"${chr}"-phased_wref.haps could not be found!"     
        fi
      done
        if [[ -f "*.warnings" ]]; then
           rm *.warnings
        fi
   else
      	echo """
      	Usage: ./run_impute2.sh <NJ> <NL> <NH>
      	
      		NJ: Number of jobs to run per chromosome
   		NL: Lower chrom number. CHROM to start with
                   NH: Higher chrom number. CHROM to end with
        """
   fi
}

#################################################################################################
#												#
#		Original script to run chunks on chromosomes one at a time			#
#		    Should be useful when parallel jobs are impossible				#
#												#
#################################################################################################
#for chr in {1..22}; do
#  if [[ -f "chr${chr}-phased_wref.haps" ]]; then
#   impute_v2.3.2 \
#      -use_prephased_g \
#      -known_haps_g chr"${chr}"-phased_wref.haps \
#      -m "$ref_path"genetic_map_chr"${chr}"_combined_b37.txt \
#      -h "$ref_path"1000GP_Phase3_chr"${chr}".hap.gz \
#      -l "$ref_path"1000GP_Phase3_chr"${chr}".legend.gz \
#      -int '160000000 162000000' \
#      -Ne 17469 \
#      -buffer 1000 \
#      -o chr"${chr}"_imputed2.gen
#  else
#    echo "chr"${chr}"-phased_wref.haps could not be found!"
#  fi
#done
