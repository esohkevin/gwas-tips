###### CAMEROON GWAS DATA ANALYSIS PIPELINE ######
# Data: 
#	Genotype:	camgwas_merged.vcf.gz
#			raw-camgwas.gen 
#
#			from: 

runplink1.9() {
mkdir -p images
read -p 'Please provide your genotype vcf file: ' vcf

for i in $vcf
do
plink1.9 \
--vcf $vcf \
--recode oxford \
--allow-no-sex \
--double-id \
--id-delim '_' \
--out raw-camgwas
sleep 1

cat *.log > all.log
sleep 1

cp tmp/raw-camgwas.sample .
sleep 1

#	Sample: 	raw-camgwas.sample

# Make plink binary files from Oxford .gen + .sample files spliting chrX by the PARs using the b37 coordinates
plink1.9 \
--data raw-camgwas \
--make-bed \
--split-x b37 \
--allow-no-sex \
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

#########################################################################
#	    Perform per individual missing rate QC in R			#
#########################################################################
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

#########################################################################
#              Perform IBD analysis (relatedness) in R                  #
#########################################################################
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

#########################################################################
#                        Perform per SNP QC in R                        #
#########################################################################
echo -e "\nNow generating plots for per SNP QC in R. Please wait..."

R CMD BATCH snpmissing.R

# Remove SNPs that failed per marker QC
plink1.9 --bfile ind-qc-camgwas \
--exclude fail-diffmiss.qc \
--allow-no-sex \
--maf 0.01 \
--hwe 1e-6 \
--geno 0.04 \
--make-bed \
--set-hh-missing \
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

#########################################################################
#                        Plot Association in R                          #
#########################################################################
echo -e "\nNow generating association plots in R. Please wait..."

R CMD BATCH assocplot.R

done

mv *.png images/
}
