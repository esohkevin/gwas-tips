#for i in ~/GWAS/1000G/ALL.chr*.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz; do
#       plink1.9 \
#               --vcf ${i} \
#               --allow-no-sex \
#               --recode \
#               --out ${i}
#done
#cut -f2 ../analysis/qc-camgwas.bim > qc-rs.ids

#for i in ALL.chr*.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz; do
#	plink1.9 \
#		--vcf ${i} \
#		--extract qc-rs.ids \
#		--mind 0.1 \
#		--maf 0.35 \
#		--geno 0.01 \
#		--biallelic-only \
#		--recode vcf \
#		--allow-no-sex \
#		--out ${i/.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz/.myp3};
#done

#for i in ALL.chr*.myp3.vcf.gz; do
#	bgzip -f ${i}
#	tabix -f -p vcf ${i};
#done

bcftools concat -a -d snps -Oz ALL.chr1.myp3.vcf.gz \
ALL.chr2.myp3.vcf.gz \
ALL.chr3.myp3.vcf.gz \
ALL.chr4.myp3.vcf.gz \
ALL.chr5.myp3.vcf.gz \
ALL.chr6.myp3.vcf.gz \
ALL.chr7.myp3.vcf.gz \
ALL.chr8.myp3.vcf.gz \
ALL.chr9.myp3.vcf.gz \
ALL.chr10.myp3.vcf.gz \
ALL.chr11.myp3.vcf.gz \
ALL.chr12.myp3.vcf.gz \
ALL.chr13.myp3.vcf.gz \
ALL.chr14.myp3.vcf.gz \
ALL.chr15.myp3.vcf.gz \
ALL.chr16.myp3.vcf.gz \
ALL.chr17.myp3.vcf.gz \
ALL.chr18.myp3.vcf.gz \
ALL.chr19.myp3.vcf.gz \
ALL.chr20.myp3.vcf.gz \
ALL.chr21.myp3.vcf.gz \
ALL.chr22.myp3.vcf.gz \
-o my-merged-p3.vcf.gz


#plink1.9 \
#--file ALL.chr1.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz \
#--merge ALL.chr2.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz \
#--recode \
#--flip-scan \
#--biallelic-only \
#--out merge1
#
#plink1.9 \
#--file merge1 \
#--merge ALL.chr3.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz \
#--recode \
#--biallelic-only \
#--out merge2
#
#plink1.9 \
#--file merge2 \
#--merge ALL.chr4.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz \
#--recode \
#--biallelic-only \
#--out merge3
#
#plink1.9 \
#--file merge3 \
#--merge ALL.chr5.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz \
#--recode \
#--biallelic-only \
#--out merge4
#
#plink1.9 \
#--file merge4 \
#--merge ALL.chr6.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz \
#--recode \
#--biallelic-only \
#--out merge5
#
#plink1.9 \
#--file merge5 \
#--merge ALL.chr7.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz \
#--recode \
#--biallelic-only \
#--out merge6
#
#plink1.9 \
#--file merge6 \
#--merge ALL.chr8.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz \
#--recode \
#--biallelic-only \
#--out merge7
#
#plink1.9 \
#--file merge7 \
#--merge ALL.chr9.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz \
#--recode \
#--biallelic-only \
#--out merge8
#
#plink1.9 \
#--file merge8 \
#--merge ALL.chr10.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz \
#--recode \
#--biallelic-only \
#--out merge9
#
#plink1.9 \
#--file merge9 \
#--merge ALL.chr11.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz \
#--recode \
#--biallelic-only \
#--out merge10

#plink1.9 \
#--file merge10 \
#--merge ALL.chr12.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz \
#--recode \
#--biallelic-only \
#--out merge11
#
#plink1.9 \
#--file merge11 \
#--merge ALL.chr13.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz \
#--recode \
#--biallelic-only \
#--out merge12
#
#plink1.9 \
#--file merge12 \
#--merge ALL.chr14.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz \
#--recode \
#--biallelic-only \
#--out merge13
#
#plink1.9 \
#--file merge13 \
#--merge ALL.chr15.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz \
#--recode \
#--biallelic-only \
#--out merge14
#
#plink1.9 \
#--file merge14 \
#--merge ALL.chr16.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz \
#--recode \
#--biallelic-only \
#--out merge15
#
#plink1.9 \
#--file merge15 \
#--merge ALL.chr17.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz \
#--recode \
#--biallelic-only \
#--out merge16

#plink1.9 \
#--file merge16 \
#--merge ALL.chr18.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz \
#--recode \
#--biallelic-only \
#--out merge17
#
#plink1.9 \
#--file merge17 \
#--merge ALL.chr19.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz \
#--recode \
#--biallelic-only \
#--out merge18
#
#plink1.9 \
#--file merge18 \
#--merge ALL.chr20.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz \
#--recode \
#--biallelic-only \
#--out merge19
#
#plink1.9 \
#--file merge19 \
#--merge ALL.chr21.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz \
#--recode \
#--biallelic-only \
#--out merge20
#
#plink1.9 \
#--file merge20 \
#--merge ALL.chr22.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz \
#--recode \
#--biallelic-only \
#--out merged1kp3
#

#data="qc-camgwas merge21"
#for i in $data; do
#plink1.9 \
#--bfile ${i} \
#--mind 0.1 \
#--geno 0.05 \
#--indep-pairwise 50 5 0.2 \
#--autosome \
#--recode \
#--maf 0.35 \
#--out ${i}
#done

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
