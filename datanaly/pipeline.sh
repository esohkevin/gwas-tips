###### CAMEROON GWAS DATA ANALYSIS PIPELINE ######
# Data: 
#	Genotype:	camgwas_merge.vcf.gz
#			raw-camgwas.gen 
#
#			from: 

#runplink1.9() {
mkdir -p ../images
#read -p 'Please provide your genotype vcf file: ' vcf

plink1.9 \
	--vcf camgwas_merge.vcf.gz \
	--recode oxford \
	--keep-allele-order \
	--allow-no-sex \
	--double-id \
	--out raw-camgwas
cat raw-camgwas.log > all.log
cp ../samples/raw-camgwas.sample .

#	Sample: 	raw-camgwas.sample

# Check for duplicate SNPs
plink1.9 \
	--data raw-camgwas \
	--allow-no-sex \
	--list-duplicate-vars ids-only suppress-first \
	--out dups
cat dups.dupvar.log >> all.log

# Make plink binary files from Oxford .gen + .sample files spliting chrX by the PARs using the b37 coordinates while removing duplicate SNPs
plink1.9 \
	--data raw-camgwas \
	--make-bed \
	--exclude dups.dupvar \
	--split-x b37 \
	--keep-allele-order \
	--allow-no-sex \
	--out raw-camGwas
cat raw-camGwas.log >> all.log

# Update SNPID names with rsIDs
cut -f2 raw-camGwas.bim > all.snps.ids
cut -f1 -d',' all.snps.ids > all.rs.ids
paste all.rs.ids all.snps.ids > allMysnps.txt
plink1.9 \
        --bfile raw-camGwas \
        --update-name allMysnps.txt 1 2 \
        --allow-no-sex \
        --make-bed \
	--keep-allele-order \
        --out raw-camgwas
cat raw-camgwas.log >> all.log

######## Per Individual QC ##########
#
# Check for sex concordance
plink1.9 \
	--bfile raw-camgwas \
	--check-sex \
	--set-hh-missing \
	--allow-no-sex \
	--out raw-camgwas
cat raw-camgwas.log >> all.log

# Extract FIDs and IIDs of individuals flagged with error (PROBLEM) in the .sexcheck file (failed sex check)
grep "PROBLEM" raw-camgwas.sexcheck > fail-checksex.qc

# Compute missing data stats
plink1.9 \
	--bfile raw-camgwas \
	--missing \
	--allow-no-sex \
	--set-hh-missing \
	--out raw-camgwas
cat raw-camgwas.log >> all.log

# Compute heterozygosity stats
plink1.9 \
	--bfile raw-camgwas \
	--het \
	--allow-no-sex \
	--set-hh-missing \
	--out raw-camgwas
cat raw-camgwas.log >> all.log

echo """
#########################################################################
#	    Perform per individual missing rate QC in R			#
#########################################################################
"""
echo -e "\nNow generating plots for per individual missingness in R. Please wait..."

R CMD BATCH indmissing.R

# Extract a subset of frequent individuals to produce an IBD report to check duplicate or related individuals based on autosomes
plink1.9 \
	--bfile raw-camgwas \
	--autosome \
	--maf 0.35 \
	--geno 0.05 \
	--hwe 1e-8 \
	--allow-no-sex \
	--make-bed \
	--out frequent
cat frequent.log >> all.log

# Prune the list of frequent SNPs to remove those that fall within 50bp with r^2 > 0.2 using a window size of 5bp
plink1.9 \
	--bfile frequent \
	--allow-no-sex \
	--indep-pairwise 50 5 0.2 \
	--out prunedsnplist
cat prunedsnplist.log >> all.log

# Now generate the IBD report with the set of pruned SNPs (prunedsnplist.prune.in - IN because they're the ones we're interested in)
plink1.9 \
	--bfile frequent \
	--allow-no-sex \
	--extract prunedsnplist.prune.in \
	--genome \
	--out caseconpruned
cat caseconpruned.log >> all.log

echo """
#########################################################################
#              Perform IBD analysis (relatedness) in R                  #
#########################################################################
"""
echo -e "\nNow generating plots for IBD analysis in R. Please wait..."

R CMD BATCH ibdana.R

# Merge IDs of all individuals that failed per individual qc
cat fail-checksex.qc  fail-het.qc  fail-mis.qc duplicate.ids2 | sort | uniq > fail-ind.qc

# Remove individuals who failed per individual QC
plink1.9 \
	--bfile raw-camgwas \
	--make-bed \
	--allow-no-sex \
	--set-hh-missing \
	--remove fail-ind.qc \
	--out ind-qc-camgwas
cat ind-qc-camgwas.log >> all.log

######### Per SNP QC ###############
#
# Compute missing data rate for ind-qc-camgwas data
plink1.9 \
	--bfile ind-qc-camgwas \
	--allow-no-sex \
	--set-hh-missing \
	--missing \
	--out ind-qc-camgwas
cat ind-qc-camgwas.log >> all.log

# Compute MAF
plink1.9 \
	--bfile ind-qc-camgwas \
	--allow-no-sex \
	--set-hh-missing \
	--freq \
	--out ind-qc-camgwas
cat ind-qc-camgwas.log >> all.log

# Compute differential missing genotype call rates (in cases and controls)
plink1.9 \
	--bfile ind-qc-camgwas \
	--allow-no-sex \
	--set-hh-missing \
	--test-missing \
	--out ind-qc-camgwas
cat ind-qc-camgwas.log >> all.log

echo """
#########################################################################
#                        Perform per SNP QC in R                        #
#########################################################################
"""
echo -e "\nNow generating plots for per SNP QC in R. Please wait..."

R CMD BATCH snpmissing.R

# Remove SNPs that failed per marker QC
plink1.9 \
	--bfile ind-qc-camgwas \
	--exclude fail-diffmiss.qc \
	--allow-no-sex \
	--maf 0.01 \
	--hwe 1e-6 \
	--geno 0.04 \
	--make-bed \
	--biallelic-only \
	--keep-allele-order \
	--merge-x \
	--out qc-camgwas
cat qc-camgwas.log >> all.log

echo """
#########################################################################
#                          ChrX Quality Control                         #
#########################################################################
"""
echo -e "\nNow generating plots for per SNP QC in R. Please wait..."

# Extract only autosomes for subsequently merging with QCed chrX
plink \
	--bfile qc-camgwas \
	--allow-no-sex \
	--make-bed \
	--autosome \
	--out qc-camgwas-autosome
cat qc-camgwas-autosome.log >> all.log

# Extract only chrX for QC
plink \
	--bfile qc-camgwas \
	--allow-no-sex \
	--make-bed \
	--chr X \
	--out qc-camgwas-chrX \
	--set-hh-missing
cat qc-camgwas-chrX.log >> all.log

# Compute differential missingness
plink1.9 \
        --bfile qc-camgwas-chrX \
        --allow-no-sex \
        --set-hh-missing \
        --test-missing \
        --out qc-camgwas-chrX
cat qc-camgwas-chrX.log >> all.log

echo """
#########################################################################
#                          chrX per SNP QC in R                         #
#########################################################################
"""
echo -e "\nPerforming ChrX per SNP QC in R. Please wait..."

R CMD BATCH xsnpmissing.R

# Now remove SNPs that failed chrX QC
plink1.9 \
        --bfile qc-camgwas-chrX \
        --exclude fail-Xdiffmiss.qc \
        --allow-no-sex \
        --maf 0.01 \
        --hwe 1e-6 \
        --geno 0.04 \
        --make-bed \
        --biallelic-only \
        --keep-allele-order \
	--out qc-camgwas-chr23 

# Merge autosome and chrX data sets again
plink \
	--bfile qc-camgwas-autosome \
	--allow-no-sex \
	--bmerge qc-camgwas-chr23 \
	--set-hh-missing \
	--out qc-camgwas

# Run Association test with adjustment to assess the genomic control inflation factor (lambda)
plink1.9 \
	--bfile qc-camgwas \
	--autosome \
	--allow-no-sex \
	--assoc \
	--adjust \
	--out qc-camgwas
cat qc-camgwas.log >> all.log

# Run Association test on QCed data (logistic beta)
plink1.9 \
	--bfile qc-camgwas \
	--autosome \
	--allow-no-sex \
	--logistic beta \
	--set-hh-missing \
	--ci 0.95 \
	--out qc-camgwas
cat qc-camgwas.log >> all.log

# Run Association tests fitting different X-chromosome models
# Add sex as a covariate on X chr
s=`seq 1 1 3`
for i in $s
do
	plink1.9 \
		--bfile qc-camgwas \
		--xchr-model $i \
		--allow-no-sex \
		--logistic beta \
		--ci 0.95 \
		--set-hh-missing \
		--out xchr$i
cat xchr$i.log >> all.log
done

plink1.9 \
	--bfile qc-camgwas \
	--autosome-xy \
	--allow-no-sex \
	--assoc \
	--adjust \
	--set-hh-missing \
	--out autopseudo
cat autopseudo.log >> all.log
echo """
#########################################################################
#                        Plot Association in R                          #
#########################################################################
"""
echo -e "\nNow generating association plots in R. Please wait..."

R CMD BATCH assocplot.R


#done

mv *.png ../images/
rm -r raw-camGwas.*

echo """
#########################################################################
#                     Run Imputation Prep Script                        #
#########################################################################
"""
./imputePrep.sh

#}
