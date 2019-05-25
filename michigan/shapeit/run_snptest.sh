#!/bin/bash

# Run SNPTEST Association for Severe Malaria cases only SMA + CM
snptest_v2.5.4-beta3 \
	-data merge.filtered-updated.gen.gz merge.filtered-updated.sample \
	-frequentist 1 2 3 4 5 \
	-bayesian 1 2 3 4 5 \
        -include_samples ../../samples/qc-smcon-sample.ids \
	-method score \
	-pheno pheno1 \
	-cov_all \
	-o snptest-sm-assoc.txt
#cut -f1-6,42,44,46-47 -d' ' snptest-assoc.txt | sed s/NA/"${i}"/g > snptest-assoc1.txt

###########################################################################################################################
# Run association for only CM Vs Controls (by including only control+CM samples from analysis)
snptest_v2.5.4-beta3 \
        -data merge.filtered-updated.gen.gz merge.filtered-updated.sample \
        -frequentist 1 2 3 4 5 \
        -bayesian 1 2 3 4 5 \
        -method score \
        -pheno pheno1 \
	-include_samples ../../samples/qc-cmcon-sample.ids \
        -cov_all \
        -o snptest-cm-assoc.txt
#cut -f1-6,42,44,46-47 -d' ' snptest-assoc.txt | sed s/NA/"${i}"/g > snptest-assoc1.txt


# Run association for only SMA Vs Controls (bu including only control+SMA samples from analysis)
snptest_v2.5.4-beta3 \
        -data merge.filtered-updated.gen.gz merge.filtered-updated.sample \
        -frequentist 1 2 3 4 5 \
        -bayesian 1 2 3 4 5 \
        -method score \
        -pheno pheno1 \
        -cov_all \
	-include_samples ../../samples/qc-smacon-sample.ids \
        -o snptest-sma-assoc.txt
#cut -f1-6,42,44,46-47 -d' ' chr"${i}"-sma-imputed-assoc.txt | sed s/NA/"${i}"/g > chr"${i}"-sma-imputed-assoc-truncated.txt

# Extract columns for different tests into separate files for snptest-assoc.txt
cut -f1-6,42,44 -d' ' snptest-sm-assoc.txt > snptest-sm-assoc-fadd.txt
cut -f1-6,46,48 -d' ' snptest-sm-assoc.txt > snptest-sm-assoc-fdom.txt
cut -f1-6,50,52 -d' ' snptest-sm-assoc.txt > snptest-sm-assoc-frec.txt
cut -f1-6,54,56 -d' ' snptest-sm-assoc.txt > snptest-sm-assoc-fgen.txt
cut -f1-6,60,62 -d' ' snptest-sm-assoc.txt > snptest-sm-assoc-fhet.txt
cut -f1-6,64,65 -d' ' snptest-sm-assoc.txt > snptest-sm-assoc-badd.txt
cut -f1-6,67,68 -d' ' snptest-sm-assoc.txt > snptest-sm-assoc-bdom.txt
cut -f1-6,70,71 -d' ' snptest-sm-assoc.txt > snptest-sm-assoc-brec.txt
cut -f1-6,73,74 -d' ' snptest-sm-assoc.txt > snptest-sm-assoc-bgen.txt
cut -f1-6,78,79 -d' ' snptest-sm-assoc.txt > snptest-sm-assoc-bhet.txt

# Extract columns for different tests into separate files for snptest-cm-assoc.txt
cut -f1-6,42,44 -d' ' snptest-cm-assoc.txt > snptest-cm-assoc-fadd.txt
cut -f1-6,46,48 -d' ' snptest-cm-assoc.txt > snptest-cm-assoc-fdom.txt
cut -f1-6,50,52 -d' ' snptest-cm-assoc.txt > snptest-cm-assoc-frec.txt
cut -f1-6,54,56 -d' ' snptest-cm-assoc.txt > snptest-cm-assoc-fgen.txt
cut -f1-6,60,62 -d' ' snptest-cm-assoc.txt > snptest-cm-assoc-fhet.txt
cut -f1-6,64,65 -d' ' snptest-cm-assoc.txt > snptest-cm-assoc-badd.txt
cut -f1-6,67,68 -d' ' snptest-cm-assoc.txt > snptest-cm-assoc-bdom.txt
cut -f1-6,70,71 -d' ' snptest-cm-assoc.txt > snptest-cm-assoc-brec.txt
cut -f1-6,73,74 -d' ' snptest-cm-assoc.txt > snptest-cm-assoc-bgen.txt
cut -f1-6,78,79 -d' ' snptest-cm-assoc.txt > snptest-cm-assoc-bhet.txt

# Extract columns for different tests into separate files for snptest-sma-assoc.txt
cut -f1-6,42,44 -d' ' snptest-sma-assoc.txt > snptest-sma-assoc-fadd.txt
cut -f1-6,46,48 -d' ' snptest-sma-assoc.txt > snptest-sma-assoc-fdom.txt
cut -f1-6,50,52 -d' ' snptest-sma-assoc.txt > snptest-sma-assoc-frec.txt
cut -f1-6,54,56 -d' ' snptest-sma-assoc.txt > snptest-sma-assoc-fgen.txt
cut -f1-6,60,62 -d' ' snptest-sma-assoc.txt > snptest-sma-assoc-fhet.txt
cut -f1-6,64,65 -d' ' snptest-sma-assoc.txt > snptest-sma-assoc-badd.txt
cut -f1-6,67,68 -d' ' snptest-sma-assoc.txt > snptest-sma-assoc-bdom.txt
cut -f1-6,70,71 -d' ' snptest-sma-assoc.txt > snptest-sma-assoc-brec.txt
cut -f1-6,73,74 -d' ' snptest-sma-assoc.txt > snptest-sma-assoc-bgen.txt
cut -f1-6,78,79 -d' ' snptest-sma-assoc.txt > snptest-sma-assoc-bhet.txt

