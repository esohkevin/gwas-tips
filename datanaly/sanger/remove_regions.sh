#!/bin/bash

for i in $(cat regions.txt);
do
	 bcftools view -t ^region1,region2 ori.vcf -o new.vcf
