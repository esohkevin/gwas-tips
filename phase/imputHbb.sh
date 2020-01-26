#!/bin/bash

impute_v2.3.2 Command-line input: impute_v2.3.2 -use_prephased_g -known_haps_g chr11-phased_wref.haps -m 1000GP_Phase3/genetic_map_chr11_combined_b37.txt -h 1000GP_Phase3/1000GP_Phase3_chr11.hap.gz -l 1000GP_Phase3/1000GP_Phase3_chr11.legend.gz -int 4000001 6000000 -Ne 20000 -os 0 1 2 3 -buffer 500 -filt_rules_l 'TYPE==\"Biallelic_SNP\"' 'TYPE==\"Biallelic_INDEL\"' -phase -o_gz -o chr11_4000001_imputed.gen -use_prephased_g -known_haps_g chr11-phased_wref.haps
