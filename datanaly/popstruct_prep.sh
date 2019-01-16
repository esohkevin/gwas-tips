#!/usr/bin/env bash

cut -f2 ../qc-camgwas.bim > qc.rs.ids

for i in ALL.chr*.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz; do
	plink \
		--vcf ${i} \
		--extract qc.rs.ids \
		--mind 0.1 \
		--maf 0.35 \
		--geno 0.01 \
		--biallelic-only \
		--make-bed \
		--allow-no-sex \
		--out ${i}
done

plink \
	--bfile ALL.chr1.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz \
	--bmerge ALL.chr2.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz \
	--make-bed \
	--biallelic-only \
	--out merge1

plink \
	--bfile merge1 \
	--bmerge ALL.chr3.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz \
	--make-bed \
	--biallelic-only \
	--out merge2

plink \
	--bfile merge2 \
	--bmerge ALL.chr4.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz \
	--make-bed \
	--biallelic-only \
	--out merge3

plink \
	--bfile merge3 \
	--bmerge ALL.chr5.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz \
	--make-bed \
	--biallelic-only \
	--out merge4

plink \
	--bfile merge4 \
	--bmerge ALL.chr6.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz \
	--make-bed \
	--biallelic-only \
	--out merge5

plink \
	--bfile merge5 \
	--bmerge ALL.chr7.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz \
	--make-bed \
	--biallelic-only \
	--out merge6

plink \
	--bfile merge6 \
	--bmerge ALL.chr8.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz \
	--make-bed \
	--biallelic-only \
	--out merge7

plink \
	--bfile merge7 \
	--bmerge ALL.chr9.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz \
	--make-bed \
	--biallelic-only \
	--out merge8

plink \
	--bfile merge8 \
	--bmerge ALL.chr10.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz \
	--make-bed \
	--biallelic-only \
	--out merge9

plink \
	--bfile merge9 \
	--bmerge ALL.chr11.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz \
	--make-bed \
	--biallelic-only \
	--out merge10

plink \
	--bfile merge10 \
	--bmerge ALL.chr12.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz \
	--make-bed \
	--biallelic-only \
	--out merge11

plink \
	--bfile merge11 \
	--bmerge ALL.chr13.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz \
	--make-bed \
	--biallelic-only \
	--out merge12

plink \
	--bfile merge12 \
	--bmerge ALL.chr14.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz \
	--make-bed \
	--biallelic-only \
	--out merge13

plink \
	--bfile merge13 \
	--bmerge ALL.chr15.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz \
	--make-bed \
	--biallelic-only \
	--out merge14

plink \
	--bfile merge14 \
	--bmerge ALL.chr16.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz \
	--make-bed \
	--biallelic-only \
	--out merge15

plink \
	--bfile merge15 \
	--bmerge ALL.chr17.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz \
	--make-bed \
	--biallelic-only \
	--out merge16

plink \
	--bfile merge16 \
	--bmerge ALL.chr18.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz \
	--make-bed \
	--biallelic-only \
	--out merge17

plink \
	--bfile merge17 \
	--bmerge ALL.chr19.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz \
	--make-bed \
	--biallelic-only \
	--out merge18

plink \
	--bfile merge18 \
	--bmerge ALL.chr20.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz \
	--make-bed \
	--biallelic-only \
	--out merge19

plink \
	--bfile merge19 \
	--bmerge ALL.chr21.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz \
	--make-bed \
	--biallelic-only \
	--out merge20

plink \
	--bfile merge20 \
	--bmerge ALL.chr22.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz \
	--make-bed \
	--biallelic-only \
	--out merged1kp3
#mv merged1kp3.* .


#bcftools concat -Oz 1000G/ALL.chr1.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz \
#1000G/ALL.chr2.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz \
#1000G/ALL.chr3.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz \
#1000G/ALL.chr4.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz \
#1000G/ALL.chr5.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz \
#1000G/ALL.chr6.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz \
#1000G/ALL.chr7.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz \
#1000G/ALL.chr8.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz \
#1000G/ALL.chr9.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz \
#1000G/ALL.chr10.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz \
#1000G/ALL.chr11.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz \
#1000G/ALL.chr12.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz \
#1000G/ALL.chr13.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz \
#1000G/ALL.chr14.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz \
#1000G/ALL.chr15.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz \
#1000G/ALL.chr16.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz \
#1000G/ALL.chr17.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz \
#1000G/ALL.chr18.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz \
#1000G/ALL.chr19.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz \
#1000G/ALL.chr20.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz \
#1000G/ALL.chr21.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz \
#1000G/ALL.chr22.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz \
#1000G/ALL.chrX.phase3_shapeit2_mvncall_integrated_v1b.20130502.genotypes.vcf.gz \
#1000G/ALL.chrY.phase3_integrated_v2a.20130502.genotypes.vcf.gz > allPhase3_merged.vcf.gz

