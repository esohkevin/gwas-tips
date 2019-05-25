#!/bin/bash

# Paths
popstruct="$HOME/GWAS/Git/GWAS/popstruct"
assocResults="$HOME/GWAS/Git/GWAS/assoc_results"
samples="$HOME/GWAS/Git/GWAS/samples"
analysis="$HOME/GWAS/Git/GWAS/analysis"

### Association tests including covariats to account for population structure

# With all PCs - Additive MOI
plink \
        --bfile $assocResults/qc-camgwas-eig-corrected \
        --covar $popstruct/eig-camgwas.pca \
        --covar-name C1-C20 \
        --allow-no-sex \
	--keep $samples/qc-cmcon-sample.ids \
	--remove $samples/exclude_fo.txt \
        --autosome \
        --hide-covar \
        --logistic \
	--ci 0.95 \
        --out eig-qc-camgwas-cmC1-C20-add
cat eig-qc-camgwas-cmC1-C20-add.log >> all-eig-assoc.log

# With all PCs and Dominant MOI
plink \
        --bfile $assocResults/qc-camgwas-eig-corrected \
        --covar $popstruct/eig-camgwas.pca \
        --covar-name C1-C20 \
        --allow-no-sex \
        --autosome \
	--keep $samples/qc-cmcon-sample.ids \
	--remove $samples/exclude_fo.txt \
        --hide-covar \
        --logistic dominant \
        --ci 0.95 \
        --out eig-qc-camgwas-cmC1-C20-dom
cat eig-qc-camgwas-cmC1-C20-dom.log >> all-eig-assoc.log

# With all PCs and different MOI
plink \
        --bfile $assocResults/qc-camgwas-eig-corrected \
        --covar $popstruct/eig-camgwas.pca \
        --covar-name C1-C20 \
	--allow-no-sex \
	--keep $samples/qc-cmcon-sample.ids \
        --autosome \
        --hide-covar \
	--remove $samples/exclude_fo.txt \
        --model \
        --out eig-qc-camgwas-cmC1-C20-model
cat eig-qc-camgwas-cmC1-C20-model.log >> all-eig-assoc.log

# With all PCs and hethom MOI
plink \
        --bfile $assocResults/qc-camgwas-eig-corrected \
        --covar $popstruct/eig-camgwas.pca \
        --covar-name C1-C20 \
        --allow-no-sex \
	--keep $samples/qc-cmcon-sample.ids \
        --autosome \
        --hide-covar \
	--remove $samples/exclude_fo.txt \
        --logistic hethom \
	--ci 0.95 \
        --out eig-qc-camgwas-cmC1-C20-hethom
cat eig-qc-camgwas-cmC1-C20-hethom.log >> all-eig-assoc.log

# With all PCs and Recessive MOI
plink \
        --bfile $assocResults/qc-camgwas-eig-corrected \
        --covar $popstruct/eig-camgwas.pca \
        --covar-name C1-C20 \
        --allow-no-sex \
	--keep $samples/qc-cmcon-sample.ids \
        --autosome \
        --hide-covar \
        --logistic recessive \
        --ci 0.95 \
        --out eig-qc-camgwas-cmC1-C20-rec
cat eig-qc-camgwas-cmC1-C20-rec.log >> all-eig-assoc.log

echo -e "###################### Post-EIG Start ####################\n" >> cm-snpsofinterest.txt
echo "###################### ADD C1C4C5C19 ###########################" >> cm-snpsofinterest.txt
head -1 eig-qc-camgwas-cmC1C4C5C19.assoc.logistic >> cm-snpsofinterest.txt
awk '$12<1e-04' eig-qc-camgwas-cmC1C4C5C19.assoc.logistic >> cm-snpsofinterest.txt
echo "###################### C1-C20 ADD ###########################" >> cm-snpsofinterest.txt
head -1 eig-qc-camgwas-cmC1-C20-add.assoc.logistic >> cm-snpsofinterest.txt
awk '$12<1e-04' eig-qc-camgwas-cmC1-C20-add.assoc.logistic >> cm-snpsofinterest.txt
echo "###################### C1-C20 HETHOM ###########################" >> cm-snpsofinterest.txt
head -1 eig-qc-camgwas-cmC1-C20-hethom.assoc.logistic >> cm-snpsofinterest.txt
awk '$12<1e-04' eig-qc-camgwas-cmC1-C20-hethom.assoc.logistic >> cm-snpsofinterest.txt
echo "###################### C1-C20 REC ###########################" >> cm-snpsofinterest.txt
head -1 eig-qc-camgwas-cmC1-C20-rec.assoc.logistic >> cm-snpsofinterest.txt
awk '$12<1e-04' eig-qc-camgwas-cmC1-C20-rec.assoc.logistic >> cm-snpsofinterest.txt
echo "###################### C1-C20 DOM ###########################" >> cm-snpsofinterest.txt
head -1 eig-qc-camgwas-cmC1-C20-dom.assoc.logistic >> cm-snpsofinterest.txt
awk '$12<1e-04' eig-qc-camgwas-cmC1-C20-dom.assoc.logistic >> cm-snpsofinterest.txt
echo "###################### MODEL ###########################" >> cm-snpsofinterest.txt
head -1 eig-qc-camgwas-cmC1-C20-model.model >> cm-snpsofinterest.txt
awk '$10<1e-04' eig-qc-camgwas-cmC1-C20-model.model >> cm-snpsofinterest.txt
echo -e "\n###################### Post-EIG End #####################\n" >> cm-snpsofinterest.txt

#########################################################################
#                        Plot Association in R                          #
#########################################################################
#echo -e "\nNow generating association plots in R. Please wait..."

#echo "#################### EIG R #####################" >> cm-snpsofinterest.txt
#Rscript post-eig-assoc.R >> cm-snpsofinterest.txt
#echo "#################### EIG R #####################" >> cm-snpsofinterest.txt

# Filter association results to obtain SNPs with p-val 1e-5
#for i in ps*-qc-camgwas.assoc.logistic; 
#do 
#	head -1 ${i} > ${i/-qc-camgwas.assoc.logistic/-assoc.results}; 
#	awk '$9<1e-5' ${i} >> ${i/-qc-camgwas.assoc.logistic/-assoc.results}; 
#done
