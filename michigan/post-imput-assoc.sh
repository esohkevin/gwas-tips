#!/bin/bash

# Run Post Imputation Associations with Covars to account for population structure
# With PC1 and PC2
plink \
        --bfile merge.filtered-updated \
        --covar ../../popstruct/eig-camgwas.pca \
        --covar-name C1-C20 \
        --autosome \
	--maf 0.0001 \
	--geno 0.02 \
	--keep ../../popstruct/eig-camgwas.ids \
        --allow-no-sex \
        --hide-covar \
        --logistic recessive \
	--ci 0.95 \
        --out eagle-post-impc1-c10-rec
#cat eagle-post-impc1c2.log >> post-imp-assoc-all.log

# With PC1, PC5 and PC9 as reported by glm to associate significantly with disease
plink \
        --bfile merge.filtered-updated \
        --covar ../../popstruct/eig-camgwas.pca \
	--keep ../../popstruct/eig-camgwas.ids \
        --covar-name C1 C4 C5 \
        --allow-no-sex \
	--maf 0.0001 \
        --autosome \
	--geno 0.02 \
        --hide-covar \
        --logistic \
	--ci 0.95 \
        --out eagle-post-impc1c4c5-add
#cat eagle-post-impc1c5c9.log >> post-imp-assoc-all.log

# With all PCs
plink \
        --bfile merge.filtered-updated \
        --covar ../../popstruct/eig-camgwas.pca \
        --keep ../../popstruct/eig-camgwas.ids \
	--covar-name C1-C20 \
        --allow-no-sex \
        --autosome \
	--geno 0.02 \
	--maf 0.0001 \
        --hide-covar \
        --logistic \
	--ci 0.95 \
        --out eagle-post-impc1-c10-add
#cat eagle-post-impc1-c10.log >> post-imp-assoc-all.log

# With all PCs and different MOI
plink \
        --bfile merge.filtered-updated \
	--covar ../../popstruct/eig-camgwas.pca \
        --keep ../../popstruct/eig-camgwas.ids \
        --covar-name C1-C20 \
        --allow-no-sex \
        --autosome \
	--maf 0.0001 \
	--geno 0.02 \
        --hide-covar \
        --model \
        --out eagle-post-impc1-c10-model
#cat eagle-post-impc1-c10-model.log >> post-imp-assoc-all.log

# With all PCs and hethom MOI
plink \
        --bfile merge.filtered-updated \
	--covar ../../popstruct/eig-camgwas.pca \
        --keep ../../popstruct/eig-camgwas.ids \
        --covar-name C1-C20 \
        --allow-no-sex \
        --autosome \
	--geno 0.02 \
        --hide-covar \
	--maf 0.0001 \
	--ci 0.95 \
        --logistic hethom \
        --out eagle-post-impc1-c10-hethom
#cat eagle-post-impc1-c10-hethom.log >> post-imp-assoc-all.log

plink \
        --bfile merge.filtered-updated \
        --covar ../../popstruct/eig-camgwas.pca \
        --keep ../../popstruct/eig-camgwas.ids \
        --covar-name C1-C20 \
        --allow-no-sex \
	--maf 0.0001 \
	--geno 0.02 \
        --autosome \
        --hide-covar \
        --logistic dominant \
        --ci 0.95 \
        --out eagle-post-impc1-c10-dom

# Update hethom file by removing all NAs
grep -v "NA" eagle-post-impc1-c10-hethom.assoc.logistic > post-impc1-c10-hethom-noNA.assoc.logistic

echo -e "######################################### Post-Imputation Start ########################################\n" > eagle-post-imp-snpsofinterest.txt
echo "############################################### HETHOM ##############################################" >> eagle-post-imp-snpsofinterest.txt
head -1 eagle-post-impc1-c10-hethom.assoc.logistic >> post-imp-snpsofinterest.txt
awk '$12<1e-05' eagle-post-impc1-c10-hethom.assoc.logistic >> post-imp-snpsofinterest.txt
echo "############################################### ADD ######################################################" >> eagle-post-imp-snpsofinterest.txt
head -1 eagle-post-impc1-c10-add.assoc.logistic >> post-imp-snpsofinterest.txt
awk '$12<1e-05' eagle-post-impc1-c10-add.assoc.logistic >> post-imp-snpsofinterest.txt
echo "######################################################## ADD C1C4C5 ############################################" >> eagle-post-imp-snpsofinterest.txt
head -1 eagle-post-impc1c4c5-add.assoc.logistic >> post-imp-snpsofinterest.txt
awk '$12<1e-05' eagle-post-impc1c4c5-add.assoc.logistic >> post-imp-snpsofinterest.txt
echo "########################################################## DOM ############################################" >> eagle-post-imp-snpsofinterest.txt
head -1 eagle-post-impc1-c10-dom.assoc.logistic >> post-imp-snpsofinterest.txt
awk '$12<1e-05' eagle-post-impc1-c10-dom.assoc.logistic >> post-imp-snpsofinterest.txt
echo "################################################# REC ###########################################################" >> eagle-post-imp-snpsofinterest.txt
head -1 eagle-post-impc1-c10-rec.assoc.logistic >> post-imp-snpsofinterest.txt
awk '$12<1e-05' eagle-post-impc1-c10-rec.assoc.logistic >> post-imp-snpsofinterest.txt
echo "########################################################### MODEL ################################################" >> eagle-post-imp-snpsofinterest.txt
head -1 eagle-post-impc1-c10-model.model >> post-imp-snpsofinterest.txt
awk '$10<1e-05' eagle-post-impc1-c10-model.model >> post-imp-snpsofinterest.txt
echo -e "\n################################################### Post-Imputation End ###############################################\n" >> eagle-post-imp-snpsofinterest.txt

#########################################################################
#                        Plot Association in R                          #
#########################################################################

# Filter association results to obtain SNPs with p-val 1e-5
#for i in ps*-eagle-post-imp.assoc.logistic; 
#do 
#	head -1 ${i} > ${i/-eagle-post-imp.assoc.logistic/-assoc.results}; 
#	awk '$9<1e-5' ${i} >> ${i/-eagle-post-imp.assoc.logistic/-assoc.results}; 
#done

# Produce manhattan plots in R
R CMD BATCH eagle-post-imput-assoc.R

#mv *.png ../../images/

