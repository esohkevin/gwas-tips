#!/bin/bash

plink \
	--allow-no-sex \
	--autosome \
	--bfile merge.filtered-updated \
	--ci 0.95 \
	--covar ../../popstruct/eig-camgwas.pca \
	--covar-name C1-C20 \
	--geno 0.05 \
	--hide-covar \
	--keep ../../popstruct/eig-camgwas.ids \
	--logistic perm \
	--maf 0.0001 \
	--out perm
