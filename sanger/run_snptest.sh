#!/bin/bash

# Run SNPTEST Association for entire dataset using casecontrol status (each chr at a time)
for i in $(seq 1 22); do
	snptest_v2.5.4-beta3 \
		-data chr"${i}"-sanger-imputed.gen.gz ../../samples/merge.filtered-updated.sample \
		-frequentist 1 \
		-bayesian 1 \
		-method score \
		-pheno pheno1 \
		-cov_all \
		-o chr"${i}"-imputed-assoc.txt
	cut -f1-6,42,44,46-47 -d' ' chr"${i}"-imputed-assoc.txt | sed s/NA/"${i}"/g > chr"${i}"-imputed-assoc-truncated.txt
done

# Make a file of the header section of heading line of the association result files in order to combine the results 
grep "^#" chr1-imputed-assoc-truncated.txt > auto-imputed-assoc-truncated.txt
grep -v "^#" chr1-imputed-assoc-truncated.txt | head -1 >> auto-imputed-assoc-truncated.txt

# Now combine the association results into a single file (as created above)
for i in $(seq 1 22); do
	grep -v "^#" chr"${i}"-imputed-assoc-truncated.txt | grep -v "alternate_ids" >> auto-imputed-assoc-truncated.txt
done

###########################################################################################################################
# Run association for only SMA Vs Controls (bu including only control+SMA samples from analysis)
for i in $(seq 1 22); do
	snptest_v2.5.4-beta3 \
                -data chr"${i}"-sanger-imputed.gen.gz ../../samples/merge.filtered-updated.sample \
                -frequentist 1 \
                -bayesian 1 \
                -method score \
                -pheno pheno1 \
                -cov_all \
		-include_samples ../../samples/qc-smacon-sample.ids \
                -o chr"${i}"-sma-imputed-assoc.txt
        cut -f1-6,42,44,46-47 -d' ' chr"${i}"-sma-imputed-assoc.txt | sed s/NA/"${i}"/g > chr"${i}"-sma-imputed-assoc-truncated.txt
done

# Make a file of the header section of heading line of the association result files in order to combine the results
grep "^#" chr1-sma-imputed-assoc-truncated.txt > auto-sma-imputed-assoc-truncated.txt
grep -v "^#" chr1-sma-imputed-assoc-truncated.txt | head -1 >> auto-sma-imputed-assoc-truncated.txt

# Now combine the association results into a single file (as created above)
for i in $(seq 1 22); do
        grep -v "^#" chr"${i}"-sma-imputed-assoc-truncated.txt | grep -v "alternate_ids" >> auto-sma-imputed-assoc-truncated.txt
done

############################################################################################################################
# Run association for only CM Vs Controls (by including only control+CM samples from analysis)
for i in $(seq 1 22); do
        snptest_v2.5.4-beta3 \
                -data chr"${i}"-sanger-imputed.gen.gz ../../samples/merge.filtered-updated.sample \
                -frequentist 1 \
                -bayesian 1 \
                -method score \
                -pheno pheno1 \
                -cov_all \
		-include_samples ../../samples/qc-cmcon-sample.ids \
                -o chr"${i}"-cm-imputed-assoc.txt
        cut -f1-6,42,44,46-47 -d' ' chr"${i}"-cm-imputed-assoc.txt | sed s/NA/"${i}"/g > chr"${i}"-cm-imputed-assoc-truncated.txt
done

# Make a file of the header section of heading line of the association result files in order to combine the results
grep "^#" chr1-cm-imputed-assoc-truncated.txt > auto-cm-imputed-assoc-truncated.txt
grep -v "^#" chr1-cm-imputed-assoc-truncated.txt | head -1 >> auto-cm-imputed-assoc-truncated.txt

# Now combine the association results into a single file (as created above)
for i in $(seq 1 22); do
        grep -v "^#" chr"${i}"-cm-imputed-assoc-truncated.txt | grep -v "alternate_ids" >> auto-cm-imputed-assoc-truncated.txt
done

############################################################################################################################
# Run SNPTEST Association for entire dataset using casecontrol status (each chr at a time) testing for all modes of inheritance
for chr in $(seq 1 22); do
        snptest_v2.5.4-beta3 \
                -data chr"${chr}"-sanger-imputed.gen.gz ../../samples/merge.filtered-updated.sample \
                -frequentist 1 2 3 4 5 \
                -bayesian 1 2 3 4 5 \
                -method score \
                -pheno pheno1 \
                -cov_all \
                -o chr"${chr}"-impute-allmodels-assoc.txt
	sed s/NA/"${chr}"/g chr"${chr}"-impute-allmodels-assoc.txt > chr"${chr}"-imputed-allmodels-assoc.txt
	rm chr"${chr}"-impute-allmodels-assoc.txt
done


# Make a file of the header section of heading line of the association result files in order to combine the results
grep "^#" chr1-imputed-allmodels-assoc.txt > auto-imputed-allmodels-assoc.txt
grep -v "^#" chr1-imputed-allmodels-assoc.txt | head -1 >> auto-imputed-allmodels-assoc.txt

# Now combine the association results into a single file (as created above)
for chr in $(seq 1 22); do
        grep -v "^#" chr"${chr}"-imputed-allmodels-assoc.txt | grep -v "alternate_ids" >> auto-imputed-allmodels-assoc.txt
done

# Extract columns that for different tests into separate files
cut -f1-6,42,44 -d' ' auto-imputed-allmodels-assoc.txt > auto-imputed-fadd-assoc.txt
cut -f1-6,46,48 -d' ' auto-imputed-allmodels-assoc.txt > auto-imputed-fdom-assoc.txt
cut -f1-6,50,52 -d' ' auto-imputed-allmodels-assoc.txt > auto-imputed-frec-assoc.txt
cut -f1-6,54,56 -d' ' auto-imputed-allmodels-assoc.txt > auto-imputed-fgen-assoc.txt
cut -f1-6,60,62 -d' ' auto-imputed-allmodels-assoc.txt > auto-imputed-fhet-assoc.txt
cut -f1-6,64,65 -d' ' auto-imputed-allmodels-assoc.txt > auto-imputed-badd-assoc.txt
cut -f1-6,67,68 -d' ' auto-imputed-allmodels-assoc.txt > auto-imputed-bdom-assoc.txt
cut -f1-6,70,71 -d' ' auto-imputed-allmodels-assoc.txt > auto-imputed-brec-assoc.txt
cut -f1-6,73,74 -d' ' auto-imputed-allmodels-assoc.txt > auto-imputed-bgen-assoc.txt
cut -f1-6,78,79 -d' ' auto-imputed-allmodels-assoc.txt > auto-imputed-bhet-assoc.txt

