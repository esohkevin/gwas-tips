#!/bin/bash

 imputed_path="imputed/"
 
# for chr in 11; do
# 
#    if [[ -f "concat_chr"${chr}"_Chunks.txt" || -f "chr"${chr}"_imputed.gen.gz" ]]; then
#       rm concat_chr"${chr}"_Chunks.txt chr"${chr}"_imputed.gen.gz chr"${chr}"_imputed.gen
#    fi
# 
#    touch chr"${chr}"_imputed.gen
# 
#   if [[ -f "chr${chr}-phased_wref.haps" ]]; then
# 
#      for interval in $(cat chr${chr}intervals.txt); do
#           echo """chr"${chr}"_"${interval/=*/_imputed.gen.gz}"""" >> concat_chr"${chr}"_Chunks.txt
#      done
# 
#      for chunk in $(cat concat_chr"${chr}"_Chunks.txt); do
#          zcat $chunk | \
#            awk '$4=="A" || $4=="T" || $4=="G" || $4=="C"' | \
#            awk '$5=="A" || $5=="T" || $5=="G" || $5=="C"' | \
#            awk -v chr="$chr" '$1=$2=""; {print "---",chr":"$3,"_"$4,"_"$5,$0}' | \
#            sed 's/  //g' | \
#            sed 's/ _A/_A/g' | \
#            sed 's/ _T/_T/g' | \
#            sed 's/ _C/_C/g' | \
#            sed 's/ _G/_G/g' | uniq >> chr"${chr}"_imputed.gen
#      done
#      bgzip -i chr"${chr}"_imputed.gen
#    fi
# 
# done
# 
# #--- Check all chunks per chr with successful imputation
# for chr in 11; do 
#     for chunk in chr${chr}_*_imputed.gen_info; do 
#         cat $chunk; 
#     done > chr${chr}ImputSuccessful.txt; 
# done

##--- Make file of SNPs with info >= 0.75 to include in VCF file
#for i in {1..22}; do 
#    sed '1d' chr${i}ImputSuccessful.txt | \
#	awk '$7>=0.75' | \
#	awk -v chr="$i" '$1=$2=""; {print chr"\t"$3}' | \
#	sort -n --key=2 | \
#	grep -v position | uniq > chr$i.info75.txt; 
#done

#--- Convert the IMPUTE2 output to VCF
#for i in $(seq 1 22); do echo $i; done | parallel echo convert --threads 10 -G chr{}_imputed.gen.gz,phasedWref.sample -Oz -o chr{}_imputed.vcf.gz | xargs -P22 -n8 bcftools

# for chr in {1..22} X Y; do
#   bcftools view --no-version -Ou -c 2 chr{}_imputed.vcf.gz | \
#   bcftools norm --no-version -Ou -m -any | \
#   bcftools norm --no-version -Ob -o chr{}_imputed.bcf -d none -f ${ref_path}/human_g1k_v37.fasta && \
#   bcftools index -f chr{}_imputed.bcf
# done


# seq 22 | parallel echo "view -h chr{}_imputed.vcf.gz -o chr{}_imputed_updated.vcf" | xargs -P5 -n5 bcftools
# for chr in {1..22}; do 
#     bcftools query -f '%CHROM\t%POS\t%CHROM:%POS\t%REF\t%ALT\t%QUAL\t%FILTER\t.\tGT:GP\t[ %GT:%GP\t]\n' -i 'MAF[0]>0.001' chr${chr}_imputed.vcf.gz >> chr${chr}_imputed_updated.vcf
# done
# seq 22 | parallel echo "-f -@ 10 chr{}_imputed_updated.vcf" | xargs -P5 -n4 bgzip
#seq 22 | parallel echo "-f -p vcf chr{}_imputed_updated.vcf.gz" | xargs -P5 -n4 tabix
#seq 22 | parallel echo "sort -m 1000M -Ou -o chr{}_imputed.bcf chr{}_imputed_updated.vcf.gz" | xargs -P5 -n7 bcftools
#seq 22 | parallel echo "index -f --threads 10 chr{}_imputed.bcf" | xargs -P5 -n5 bcftools

#--- Extract SNPs with infor >= 0.75
#seq 22 | parallel echo view --threads 5 -R chr{}.info75.txt -Oz -o chr{}_imputed075.vcf.gz chr{}_imputed_updated.vcf.gz | xargs -P5 -n9 bcftools 
#bcftools concat -a -d all --threads 10 chr{1..22}_imputed_updated.vcf.gz -Oz -o camgwas_imputed.vcf.gz
vcftools --gzvcf camgwas_imputed.vcf.gz --positions allinfo75.txt --recode --stdout | bgzip -c > imputed.vcf.gz

for chr in {1..22}; do awk '$4=="A" || $4=="T" || $4=="G" || $4=="C"' chr${chr}ImputSuccessful.txt | awk '$5=="A" || $5=="T" || $5=="G" || $5=="C"' | awk -v chr="$chr" '$1=$2=""; {print "---",chr":"$3,"_"$4,"_"$5,$0}' | sed 's/  //g' | sed 's/ _A/_A/g' | sed 's/ _T/_T/g' | sed 's/ _C/_C/g' | sed 's/ _G/_G/g' | uniq > chr${chr}.info; done

for i in {1..22}; do awk '$7>=0.75' chr${i}.info | cut -f2 -d' ' > extractchr${i}info75.txt; done


