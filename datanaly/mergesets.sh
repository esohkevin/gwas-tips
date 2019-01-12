
for i in 1000G/ALL.chr*.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz; do
	plink1.9 \
		--vcf ${i} \
		--extract allMysnps.txt \
		--mind 0.1 \
		--maf 0.35 \
		--geno 0.01 \
		--biallelic-only \
		--recode \
		--allow-no-sex \
		--out ${i}
done

plink1.9 \
--file ALL.chr1.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz \
--merge ALL.chr2.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz \
--recode \
--flip-scan \
--biallelic-only \
--out merge1

plink1.9 \
--file merge1 \
--merge ALL.chr3.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz \
--recode \
--biallelic-only \
--out merge2

plink1.9 \
--file merge2 \
--merge ALL.chr4.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz \
--recode \
--biallelic-only \
--out merge3

plink1.9 \
--file merge3 \
--merge ALL.chr5.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz \
--recode \
--biallelic-only \
--out merge4

plink1.9 \
--file merge4 \
--merge ALL.chr6.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz \
--recode \
--biallelic-only \
--out merge5

plink1.9 \
--file merge5 \
--merge ALL.chr7.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz \
--recode \
--biallelic-only \
--out merge6

plink1.9 \
--file merge6 \
--merge ALL.chr8.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz \
--recode \
--biallelic-only \
--out merge7

plink1.9 \
--file merge7 \
--merge ALL.chr9.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz \
--recode \
--biallelic-only \
--out merge8

plink1.9 \
--file merge8 \
--merge ALL.chr10.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz \
--recode \
--biallelic-only \
--out merge9

plink1.9 \
--file merge9 \
--merge ALL.chr11.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz \
--recode \
--biallelic-only \
--out merge10

plink1.9 \
--file merge10 \
--merge ALL.chr12.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz \
--recode \
--biallelic-only \
--out merge11

plink1.9 \
--file merge11 \
--merge ALL.chr13.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz \
--recode \
--biallelic-only \
--out merge12

plink1.9 \
--file merge12 \
--merge ALL.chr14.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz \
--recode \
--biallelic-only \
--out merge13

plink1.9 \
--file merge13 \
--merge ALL.chr15.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz \
--recode \
--biallelic-only \
--out merge14

plink1.9 \
--file merge14 \
--merge ALL.chr16.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz \
--recode \
--biallelic-only \
--out merge15

plink1.9 \
--file merge15 \
--merge ALL.chr17.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz \
--recode \
--biallelic-only \
--out merge16

plink1.9 \
--file merge16 \
--merge ALL.chr18.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz \
--recode \
--biallelic-only \
--out merge17

plink1.9 \
--file merge17 \
--merge ALL.chr19.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz \
--recode \
--biallelic-only \
--out merge18

plink1.9 \
--file merge18 \
--merge ALL.chr20.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz \
--recode \
--biallelic-only \
--out merge19

plink1.9 \
--file merge19 \
--merge ALL.chr21.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz \
--recode \
--biallelic-only \
--out merge20

plink1.9 \
--file merge20 \
--merge ALL.chr22.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz \
--recode \
--biallelic-only \
--out merged1kp3


data="qc-camgwas merge21"
for i in $data; do
plink1.9 \
--bfile ${i} \
--mind 0.1 \
--geno 0.05 \
--indep-pairwise 50 5 0.2 \
--autosome \
--recode \
--maf 0.35 \
--out ${i}
done

#for i in ALL.chr*.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz; do
#	plink1.9 \
#		--vcf ${i} \
#		--allow-no-sex \
#		--recode \
#		--out ${i}
#done

#for i in chr*; do
#	plink1.9 \
#		--bfile ${i} \
#		--merge ${i+1} \
#		--allow-no-sex \
#		--indep-pairwise 50 5 0.2 \
#		--out 1000G_Phase3_merged_set
#done


#bcftools concat -Oz ALL.chr1.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz \
#ALL.chr2.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz \
#ALL.chr3.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz \
#ALL.chr4.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz \
#ALL.chr5.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz \
#ALL.chr6.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz \
#ALL.chr7.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz \
#ALL.chr8.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz \
#ALL.chr9.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz \
#ALL.chr10.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz \
#ALL.chr11.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz \
#ALL.chr12.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz \
#ALL.chr13.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz \
#ALL.chr14.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz \
#ALL.chr15.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz \
#ALL.chr16.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz \
#ALL.chr17.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz \
#ALL.chr18.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz \
#ALL.chr19.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz \
#ALL.chr20.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz \
#ALL.chr21.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz \
#ALL.chr22.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz \
#ALL.chrX.phase3_shapeit2_mvncall_integrated_v1b.20130502.genotypes.vcf.gz \
#ALL.chrY.phase3_integrated_v2a.20130502.genotypes.vcf.gz > allPhase3_merged.vcf.gz
