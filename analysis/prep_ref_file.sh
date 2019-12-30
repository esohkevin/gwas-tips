#!/bin/bash

#-------- Human Ref -----------#
#bcftools query -f '%CHROM\t%POS\t%ID\t%REF\t%ALT\n' ../1000G/1000GENOMES-phase_3.vcf.gz > ancSites.txt

#bcftools query -f '%CHROM\t%POS\t%ID\t%REF\t%ALT\n' -e 'TSA!="SNV"' ../1000G/1000GENOMES-phase_3.vcf.gz > ancSites.txt

#-------- Chimp Ref -----------#
awk '$3=="A" || $3=="T" || $3=="C" || $3=="G"' ../1000G/dbsnp_chimp_B36.txt | sed 's/chr//g' > chimp.txt

./chimp_dups.perl chimp.txt > chimp_anc.txt

rm chimp.txt
