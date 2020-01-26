#!/bin/bash

#	plink \
#		--bfile cam30 \
#		--freq \
#		--keep-allele-order \
#		--within cam1185.eth \
#		--out cam30

#vcftools \
#	--gzvcf raw-camgwas.vcf.gz \
#	--freq \
#	--stdout | \
#	    gzip -c > raw-camgwas.frq.gz

zcat raw-camgwas.frq.gz | \
    sed '1d' | \
    awk '{print $1"\t"$2"\t"$5"\t"$6}' | \
    sed 's/:/\t/g' | \
    awk '$6!=0 {print $1"\t"$2"\t"$4"\t"$6}' > freqs_camgwas.txt

