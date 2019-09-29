#!/bin/bash

#vcfcheck() {
#for i in "$@"; do
	ref="human_g1k_v37.fasta"
	vcfbase1="qc-camgwas-updated-chr"
	vcfbase="qc-camgwas-updated"

echo "`tabix -f -p vcf "${vcfbase}".vcf.gz`"
echo "`bcftools sort "${vcfbase}".vcf.gz -Oz -o "${vcfbase}".vcf.gz`"
echo "`checkVCF.py -r ${ref} -o out "${vcfbase}".vcf.gz`"
echo "`bcftools index --tbi "${vcfbase}".vcf.gz`"
#mv "${vcfbase}".vcf.gz ../phase/



#	if [[ "$1" == "0" ]];
#	then
#
#		for i in $(seq 1 23);
#        	do
#                	echo "`tabix -f -p vcf "${vcfbase1}""${i}".vcf.gz`"
#                	echo "`bcftools sort "${vcfbase1}""${i}".vcf.gz -Oz -o "${vcfbase1}""${i}".vcf.gz`"
#        	done
#
#        	for i in $(seq 1 23);
#        	do
#        	        echo "`checkVCF.py -r "$ref" -o out "${vcfbase1}""${i}".vcf.gz`"
#        	done
#	elif [[ "$1" == "1" ]];
#	then
#		echo "`tabix -f -p vcf "${vcfbase}".vcf.gz`"
#		echo "`bcftools sort "${vcfbase}".vcf.gz -Oz -o "${vcfbase}".vcf.gz`"
#		echo "`checkVCF.py -r "$ref" -o out "${vcfbase}".vcf.gz`"
#		echo "`bcftools index "${vcfbase}".vcf.gz`"
#	fi
#done
#}

#mv qc-camgwas-*.vcf.gz* ../phase/
