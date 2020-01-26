#!/bin/bash

#bcftools roh -G30 -e - -m ../phase/1000GP_Phase3/genetic_map_chr11_combined_b37.txt -o chr11ROH.txt chr11-phased_wref.vcf.gz -O s -S rohSamples.txt -r 11:5200000-5400000

#bcftools roh -G30 -e - -m ../phase/1000GP_Phase3/genetic_map_chr11_combined_b37.txt -o chr11rohRG.txt chr11-phased_wref.vcf.gz -O r -S rohSamples.txt

bcftools roh -G30 -e - -m ../phase/1000GP_Phase3/genetic_map_chr11_combined_b37.txt -o chr11rohST.txt chr11-phased_wref.vcf.gz -O s -S rohSamples.txt
