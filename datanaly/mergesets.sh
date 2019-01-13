cut -f2 qc-camgwas.bim > qc.rs.ids

for i in 1000G/ALL.chr*.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz; do
	plink \
		--vcf ${i} \
		--extract qc.rs.ids \
		--mind 0.1 \
		--maf 0.35 \
		--geno 0.01 \
		--biallelic-only \
		--recode \
		--allow-no-sex \
		--out ${i}
done

plink \
	--file 1000G/ALL.chr1.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz \
	--merge 1000G/ALL.chr2.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz \
	--recode \
	--flip-scan \
	--biallelic-only \
	--out merge1

plink \
	--file 1000G/merge1 \
	--merge 1000G/ALL.chr3.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz \
	--recode \
	--biallelic-only \
	--out merge2

plink \
	--file 1000G/merge2 \
	--merge 1000G/ALL.chr4.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz \
	--recode \
	--biallelic-only \
	--out merge3

plink \
	--file 1000G/merge3 \
	--merge 1000G/ALL.chr5.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz \
	--recode \
	--biallelic-only \
	--out merge4

plink \
	--file 1000G/merge4 \
	--merge 1000G/ALL.chr6.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz \
	--recode \
	--biallelic-only \
	--out merge5

plink \
	--file 1000G/merge5 \
	--merge 1000G/ALL.chr7.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz \
	--recode \
	--biallelic-only \
	--out merge6

plink \
	--file 1000G/merge6 \
	--merge 1000G/ALL.chr8.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz \
	--recode \
	--biallelic-only \
	--out merge7

plink \
	--file 1000G/merge7 \
	--merge 1000G/ALL.chr9.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz \
	--recode \
	--biallelic-only \
	--out merge8

plink \
	--file merge8 \
	--merge 1000G/ALL.chr10.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz \
	--recode \
	--biallelic-only \
	--out merge9

plink \
	--file 1000G/merge9 \
	--merge 1000G/ALL.chr11.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz \
	--recode \
	--biallelic-only \
	--out merge10

plink \
	--file 1000G/merge10 \
	--merge 1000G/ALL.chr12.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz \
	--recode \
	--biallelic-only \
	--out merge11

plink \
	--file 1000G/merge11 \
	--merge 1000G/ALL.chr13.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz \
	--recode \
	--biallelic-only \
	--out merge12

plink \
	--file 1000G/merge12 \
	--merge 1000G/ALL.chr14.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz \
	--recode \
	--biallelic-only \
	--out merge13

plink \
	--file 1000G/merge13 \
	--merge 1000G/ALL.chr15.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz \
	--recode \
	--biallelic-only \
	--out merge14

plink \
	--file 1000G/merge14 \
	--merge 1000G/ALL.chr16.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz \
	--recode \
	--biallelic-only \
	--out merge15

plink \
	--file 1000G/merge15 \
	--merge 1000G/ALL.chr17.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz \
	--recode \
	--biallelic-only \
	--out merge16

plink \
	--file 1000G/merge16 \
	--merge 1000G/ALL.chr18.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz \
	--recode \
	--biallelic-only \
	--out merge17

plink \
	--file 1000G/merge17 \
	--merge 1000G/ALL.chr19.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz \
	--recode \
	--biallelic-only \
	--out merge18

plink \
	--file 1000G/merge18 \
	--merge 1000G/ALL.chr20.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz \
	--recode \
	--biallelic-only \
	--out merge19

plink \
	--file merge19 \
	--merge 1000G/ALL.chr21.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz \
	--recode \
	--biallelic-only \
	--out merge20

plink \
	--file 1000G/merge20 \
	--merge 1000G/ALL.chr22.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz \
	--recode \
	--biallelic-only \
	--out merged1kp3
cp 1000G/merged1kp3.* .

plink \
	--file merged1kp3 \
	--thin-indiv-count 780 \
	--recode \
	--out thinned-merged1kp3

plink \
	--bfile qc-camgwas \
	--recode \
	--autosome \
	--allow-no-sex \
	--out raw-camgwas

plink \
	--file qc-camgwas \
	--merge thinned-merged1kp3 \
	--make-bed \	
	--allow-no-sex \
	--out popstruct

plink \
	--bfile merged-qcdata-1kp3 \
	--indep-pairwise 50 5 0.2 \
	--out pruned-merged-set

rm qc.snps.ids qc.rs.ids qc-snps.id

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
