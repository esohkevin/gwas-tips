#!/bin/bash

#echo 'If pulling from github, change --geneticMapFile to ../tables/genetic_map_hg19_example.txt.gz'
#echo

ref_path="../1000G"
data_set="$2"
base="${data_set/.vcf*/}"
Kpbwt="$3"

if [[ $1 == "1" ]]; then
   
   if [[ $1 == "1" && $# == "3" ]]; then

#      echo "`tabix -f -p vcf ${base}.vcf.gz`"
      
      for chr in {1..22}; do
        eagle \
          --vcfRef=${ref_path}/ALL.chr${chr}.phase3_integrated.20130502.genotypes.bcf \
          --vcfTarget=${base}.vcf.gz \
          --geneticMapFile=tables/genetic_map_hg19_withX.txt.gz \
          --outPrefix=chr${chr}-phased_wref \
          --chrom=${chr} \
          --pbwtIters=10 \
          --numThreads=90 \
          --Kpbwt=${Kpbwt} \
          --vcfOutFormat=z \
          2>&1 | tee chr${chr}-phased_wref.log
      
        echo "`tabix -f -p vcf chr${chr}-phased_wref.vcf.gz`"
      
      done
      
      # --vcfOutFormat: Specify output format (.vcf, .vcf.gz, or .bcf)
      # --noImpMissing: Turn off imputation of missing genotypes
      # --bpStart=50e6, --bpEnd=100e6, and --bpFlanking=1e6: Impute genotypes to specific regions
      # --Kpbwt=10000: Adjust speed and accuracy of impuatation. Increase value to improve accuracy
   
      else
   	  echo """
   		Usage: ./run_wphase_ref.sh 1 <in-vcf> <Kpbwt[10000]>
   	  """
      fi


elif [[ $1 == "2" ]]; then

     # Phasing imputed data
     if [[ $1 == "2" && $# == "3" ]]; then     

     for chr in 11; do
     
         tabix -f -p vcf ${base}_chr${chr}-imputed.vcf.gz
         
         eagle \
             --vcfRef=${ref_path}/ALL.chr${chr}.phase3_integrated.20130502.genotypes.bcf \
             --vcfTarget=${base} \
             --geneticMapFile=tables/genetic_map_hg19_withX.txt.gz \
             --outPrefix=${base}_chr${chr}-imp-phased_wref \
             --chrom=${chr} \
             --pbwtIters=10 \
             --numThreads=90 \
             --Kpbwt=${Kpbwt} \
             --vcfOutFormat=z \
             2>&1 | tee ${base}_chr${chr}-imp-phased_wref.log
         
           echo "`tabix -f -p vcf ${base}_chr${chr}-imp-phased_wref.vcf.gz`"
     
     done

     else
	 echo """
                Usage: ./run_wphase_ref.sh 2 <in-vcf> <Kpbwt[10000]>
          """
     fi

else
    echo """
	Usage: ./run_wphase_ref.sh [1|2]
	
	Please enter '1' or '2' for either unimputed or imputed data respectively
    """

fi
