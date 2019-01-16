#cut -f2 qc-camgwas.bim > qc.rs.ids

#for i in 1000G/ALL.chr*.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz; do
#	plink \
#		--vcf ${i} \
#		--extract qc.rs.ids \
#		--mind 0.1 \
#		--maf 0.35 \
#		--geno 0.01 \
#		--biallelic-only \
#		--make-bed \
#		--allow-no-sex \
#		--out ${i}
#done

plink \
	--bfile 1000G/ALL.chr1.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz \
	--bmerge 1000G/ALL.chr2.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz \
	--make-bed \
	--biallelic-only \
	--out merge1

plink \
	--bfile merge1 \
	--bmerge 1000G/ALL.chr3.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz \
	--make-bed \
	--biallelic-only \
	--out merge2

plink \
	--bfile merge2 \
	--bmerge 1000G/ALL.chr4.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz \
	--make-bed \
	--biallelic-only \
	--out merge3

plink \
	--bfile merge3 \
	--bmerge 1000G/ALL.chr5.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz \
	--make-bed \
	--biallelic-only \
	--out merge4

plink \
	--bfile merge4 \
	--bmerge 1000G/ALL.chr6.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz \
	--make-bed \
	--biallelic-only \
	--out merge5

plink \
	--bfile merge5 \
	--bmerge 1000G/ALL.chr7.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz \
	--make-bed \
	--biallelic-only \
	--out merge6

plink \
	--bfile merge6 \
	--bmerge 1000G/ALL.chr8.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz \
	--make-bed \
	--biallelic-only \
	--out merge7

plink \
	--bfile merge7 \
	--bmerge 1000G/ALL.chr9.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz \
	--make-bed \
	--biallelic-only \
	--out merge8

plink \
	--bfile merge8 \
	--bmerge 1000G/ALL.chr10.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz \
	--make-bed \
	--biallelic-only \
	--out merge9

plink \
	--bfile merge9 \
	--bmerge 1000G/ALL.chr11.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz \
	--make-bed \
	--biallelic-only \
	--out merge10

plink \
	--bfile merge10 \
	--bmerge 1000G/ALL.chr12.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz \
	--make-bed \
	--biallelic-only \
	--out merge11

plink \
	--bfile merge11 \
	--bmerge 1000G/ALL.chr13.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz \
	--make-bed \
	--biallelic-only \
	--out merge12

plink \
	--bfile merge12 \
	--bmerge 1000G/ALL.chr14.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz \
	--make-bed \
	--biallelic-only \
	--out merge13

plink \
	--bfile merge13 \
	--bmerge 1000G/ALL.chr15.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz \
	--make-bed \
	--biallelic-only \
	--out merge14

plink \
	--bfile merge14 \
	--bmerge 1000G/ALL.chr16.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz \
	--make-bed \
	--biallelic-only \
	--out merge15

plink \
	--bfile merge15 \
	--bmerge 1000G/ALL.chr17.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz \
	--make-bed \
	--biallelic-only \
	--out merge16

plink \
	--bfile merge16 \
	--bmerge 1000G/ALL.chr18.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz \
	--make-bed \
	--biallelic-only \
	--out merge17

plink \
	--bfile merge17 \
	--bmerge 1000G/ALL.chr19.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz \
	--make-bed \
	--biallelic-only \
	--out merge18

plink \
	--bfile merge18 \
	--bmerge 1000G/ALL.chr20.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz \
	--make-bed \
	--biallelic-only \
	--out merge19

plink \
	--bfile merge19 \
	--bmerge 1000G/ALL.chr21.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz \
	--make-bed \
	--biallelic-only \
	--out merge20

plink \
	--bfile merge20 \
	--bmerge 1000G/ALL.chr22.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz \
	--make-bed \
	--biallelic-only \
	--out merged1kp3
#mv merged1kp3.* .

plink \
	--bfile merged1kp3 \
	--thin-indiv-count 360 \
	--autosome \
	--exclude-snp rs16959560 \
	--keep-allele-order \
	--biallelic-only \
	--out 1kGp3

cut -f2 1kGp3.bim > thinned.rs.ids

plink \
	--bfile qc-camgwas \
	--make-bed \
	--biallelic-only \
	--extract thinned.rs.ids \
	--autosome \
	--allow-no-sex \
	--out psdata

plink \
	--bfile psdata \
	--bmerge 1kGp3 \
	--make-bed \
	--autosome \
	--biallelic-only \
	--allow-no-sex \
	--out merge

plink \
	--bfile merge \
	--indep-pairwise 50 5 0.2 \
	--allow-no-sex \
	--biallelic-only \
	--out merge

plink \
	--bfile merge \
	--extract merge.prune.in \
	--allow-no-sex \
	--genome \
	--biallelic-only \
	--out merge

plink \
	--bfile merge \
	--read-genome merge.genome \
	--cluster --mds-plot 2 \
	--out merge

# Retrieve the 1000Genome Phase sample bfile from the website by visiting
# http://www.internationalgenome.org/data-portal/sample
# Then click on Phase 3 to filter and then hit the button to download the list

# Replace gaps in the list with underscore '_'
sed 's/ /_/g' igsr_samples.tsv > igsr_phase3.samples

# Extract ids of the 360 randomly generated phase 3 samples
cut -f1 -d' ' 1kGp3.fam > 3601kGp3.ids

# Now obtain the ids and their corresponding populations in the igsr_phase3.samples bfile
echo "IID Status" > merge.txt
grep -f 3601kGp3.ids igsr_phase3.samples | cut -f1,4 >> merge.txt

# Also obtain the ids of the remaining dataset in psdata.fam and corresponding status in the large sample bfile
cut -f1 -d' ' psdata.fam > psdata.ids
grep -f psdata.ids tmp/Cameroon_GWAS-2.5M_b37_release.sample | cut -f1,9 -d' ' >> merge.txt

# Now Compute 10 axes of genetic variation to determine pop structure
plink \
	--bfile qc-camgwas \
	--autosome \
	--indep-pairwise 50 5 0.2 \
	--out ps2data

plink \
	--bfile qc-camgwas \
	--autosome \
	--extract ps2data.prune.in \
	--genome \
	--out ps2data

plink \
	--bfile qc-camgwas \
	--read-genome ps2data.genome \
	--cluster \
	--mds-plot 10 \
	--out ps2data

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

