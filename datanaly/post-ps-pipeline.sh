#!/bin/bash

### Association tests including covariats to account for population structure
# With PC1 and PC2
plink \
        --bfile qc-camgwas \
        --covar ../popstruct/ps-data.mds \
        --covar-name C1 C2 \
        --autosome \
        --allow-no-sex \
        --hide-covar \
        --logistic \
        --out ps-qc-camgwas
cat ps-qc-camgwas.log >> all.log

# With PC1, PC5 and PC9 as reported by glm to associate significantly with disease
plink \
        --bfile qc-camgwas \
        --covar ../popstruct/ps-data.mds \
        --covar-name C1 C5 C9 \
        --allow-no-sex \
        --autosome \
        --hide-covar \
        --logistic \
        --out ps1-qc-camgwas
cat ps1-qc-camgwas.log >> all.log

# With all PCs
plink \
        --bfile qc-camgwas \
        --covar ../popstruct/ps-data.mds \
        --covar-name C1 C2 C3 C4 C5 C6 C7 C8 C9 C10 \
        --allow-no-sex \
        --autosome \
        --hide-covar \
        --logistic \
        --out ps2-qc-camgwas
cat ps2-qc-camgwas.log >> all.log

#########################################################################
#                        Plot Association in R                          #
#########################################################################
echo -e "\nNow generating association plots in R. Please wait..."

R CMD BATCH post-ps-assoc.R

# Filter association results to obtain SNPs with p-val 1e-5
for i in ps*-qc-camgwas.assoc.logistic; 
do 
	head -1 ${i} > ${i/-qc-camgwas.assoc.logistic/-assoc.results}; 
	awk '$9<1e-5' ${i} >> ${i/-qc-camgwas.assoc.logistic/-assoc.results}; 
done
