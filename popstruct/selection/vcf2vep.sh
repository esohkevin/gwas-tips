#!/bin/bash

#sort -nr --key=4 camSignals.txt | \
#   awk '{print $1":"$2}' | \
#   sort -n > signals.bp
#grep -f signals.bp ../../analysis/updateName.txt | \
#   sort -n --key=2 > signals.rsids
#rm signals.bp

if [[ $# != 0 ]]; then
   for rsid in $@; do
   plink \
      --vcf ../Phased-pca-filtered.vcf.gz \
      --recode vcf-fid \
      --extract $rsid \
      --keep-allele-order \
      --double-id \
      --allow-no-sex \
      --out ${rsid/.rs*/} \
      --real-ref-alleles \
      --thin-indiv-count 2
   done
#cut -f1-20,22,26 ihs.hg19_multianno.txt | cut -f1-2,4-11,21- | sed 's/chr//g' | sed 's/\t/:/1' | sed 's/Chr:/key\t/' | sed 's/\t\t/\t/' > annv.txt
#
#Rscript signals.R
#
#awk '{print $2"\t"$1"\t"$10"\t"$11"\t"$5"\t"$8"\t"$9"\t"$13"\t"$12}' signals.table | head -1 > ihs.tbl.txt; awk '{print $2"\t"$1"\t"$10"\t"$11"\t"$5"\t"$8"\t"$9"\t"$13"\t"$12}' signals.table | grep -e exonic -e UTR | grep -v ncRNA_exonic | sort -n --key=5 >> ihs.tbl.txt

else 
   echo """
   Usage:./vcf2vep.sh <rsid files [file1.rsids file2.rsids ... filen.rsids]>
       
   	List as many files as possible on one line spearated by a space
   """
fi
