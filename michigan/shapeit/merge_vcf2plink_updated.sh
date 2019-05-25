################# Post Imputation GWAS Analysis ###################

# Chech duplicate positions (snps) to exclude from downstream analyses
zgrep -v "^#" merge.filtered.vcf.gz | cut -f3 | sort | uniq -d > merge.filtered.dups
zgrep -v "^#" chrX.auto.filtered.vcf.gz | cut -f3 | sort | uniq -d > chrX.auto.filtered.dups
zgrep -v "^#" chrX.no.auto_female.filtered.vcf.gz | cut -f3 | sort | uniq -d > chrX.no.auto_female.filtered.dups

# Covert autosomal imputed and filtered genotypes to plink binary format 
plink \
	--vcf merge.filtered.vcf.gz \
	--exclude merge.filtered.dups \
        --allow-no-sex \
        --make-bed \
	--vcf-min-gp 0.9 \
        --biallelic-only \
	--keep-allele-order \
	--double-id \
        --out merge.filtered

# Convert non-autosomal imputed and filtered genotypes to plink binary format
plink \
        --vcf chrX.auto.filtered.vcf.gz \
        --allow-no-sex \
	--exclude chrX.auto.filtered.dups \
        --make-bed \
	--keep-allele-order \
        --double-id \
	--vcf-min-gp 0.9 \
        --biallelic-only \
        --out chrX.auto.filtered

plink \
	--vcf chrX.no.auto_female.filtered.vcf.gz \
	--allow-no-sex \
	--exclude chrX.no.auto_female.filtered.dups \
	--make-bed \
	--keep-allele-order \
        --double-id \
	--vcf-min-gp 0.9 \
	--biallelic-only \
	--out chrX.no.auto_female.filtered

# Update the dataset with casecontrol status from sample files
plink \
	--bfile merge.filtered \
	--allow-no-sex \
	--pheno update-camgwas.phe \
	--1 \
	--update-name update-ucsc.ids 2 1 \
	--update-sex update-camgwas.sex \
	--maf 0.01 \
	--geno 0.1 \
	--hwe 1e-6 \
	--make-bed \
	--out merge.filtered-updated

plink \
        --bfile chrX.auto.filtered \
        --allow-no-sex \
	--pheno update-camgwas.phe \
	--1 \
        --update-name update-ucsc.ids 2 1 \
        --update-sex update-camgwas.sex \
        --maf 0.01 \
        --geno 0.1 \
        --hwe 1e-6 \
        --make-bed \
        --out chrX.auto.filtered-updated

plink \
        --bfile chrX.no.auto_female.filtered \
        --allow-no-sex \
	--pheno update-camgwas.phe \
	--1 \
        --update-name update-ucsc.ids 2 1 \
        --update-sex update-camgwas.sex \
        --maf 0.01 \
        --geno 0.1 \
        --hwe 1e-6 \
        --make-bed \
        --out chrX.no.auto_female.filtered-updated


