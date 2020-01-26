#!/bin/bash

shapeit="../michigan/shapeit/"
sample="../samples/"
analysis="../analysis/"

plink \
	--vcf Phased_wref.vcf.gz \
	--allow-no-sex \
	--pheno "$analysis"raw-camgwas.fam \
	--update-sex "$analysis"raw-camgwas.fam 3 \
	--mpheno 4 \
	--make-bed \
	--double-id \
	--keep-allele-order \
	--out phasedCamgwasAutosome


# for chr in {1..22}; do
#     plink \
# 	--vcf Phased_wref.vcf.gz \
# 	--allow-no-sex \
#         --pheno "$analysis"raw-camgwas.fam \
#         --update-sex "$analysis"raw-camgwas.fam 3 \
#         --mpheno 4 \
#         --recode12 \
# 	--chr ${chr} \
#         --double-id \
# 	--biallelic-only \
#         --keep-allele-order \
#         --out chr${chr}_phasedWref
# done
