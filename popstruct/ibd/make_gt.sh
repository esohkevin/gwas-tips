#!/bin/bash

#--Make Genotype file (Derived allele haplotype)
for i in SB BA FO; do
  bcftools query \
     -H \
     -S $i.id \
     -f '%CHROM\t%POS\t[ %GT]\n' ../Phased-pca-filtered.vcf.gz | \
  	sed 's/0|0/0/g' | \
  	sed 's/1|0/0/g' | \
  	sed 's/0|1/1/g' | \
  	sed 's/1|1/1/g' | \
  	sed 's/#//g' | \
  	sed 's/:GT//g' | \
        sed 's/ /\t/g' | \
  	sed 's/\[[[:alnum:]]*\]//g' | \
	sed 's/\tCHROM/CHROM/g' | \
	sed 's/ CHROM/CHROM/g' | \
        sed 's/\t\t/\t/g' > $i.gt
done

#sed 's/ /\t/g' | \

#--Make frequency files
for i in SB BA FO; do cut -f1-2 $i.gt | sed '1d' > $i.sites;
  echo $i; done | parallel vcftools --gzvcf ../../analysis/raw-camgwas.vcf.gz --positions {}.sites --freq --keep ../selection/{}.txt --out {}
for i in SB BA FO; do \
  sed '1d' $i.frq | \
      cut -f1-2,5-6 | \
      sed 's/:/\t/g' | \
      cut -f1-2,4,6 | \
      sed 's/nan/1/g' > frq.$i.txt;
      rm $i.frq $i.sites
done
