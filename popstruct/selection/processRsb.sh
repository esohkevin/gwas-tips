#!/bin/bash

for i in sbbRsb.txt sbfuRsb.txt bfuRsb.txt; do 
    sed 's/\t/:/1' ${i} > ${i/.txt/.updated.txt}

    awk '$2>4' ${i/.txt/.updated.txt} | \
	    sort -nr --key=3 > ${i/.txt/.POSITIVE}; 

    awk '$2<-4' ${i/.txt/.updated.txt} | \
	    sort -nr --key=3 > ${i/.txt/.NEGATIVE};
done

for i in ./*.POSITIVE ./*.NEGATIVE; do 
    cut -f1 $i > ${i}.pos; 
    grep -w -f ${i}.pos ../../analysis/updateName.txt > ${i}.rsids 

  plink \
   --vcf ../Phased-pca-filtered.vcf.gz \
   --recode vcf-fid \
   --extract ${i}.rsids \
   --keep-allele-order \
   --double-id \
   --allow-no-sex \
   --out ${i}.signals \
   --real-ref-alleles \
   --thin-indiv-count 2
done


