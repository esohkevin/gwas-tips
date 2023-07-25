#!/usr/bin/env bash


#--------------------------------------------------------------------------------#
#      We will create separate directories at each stage of the pipeline         #
#--------------------------------------------------------------------------------#

# --- PREPARING THE PHENOTYPE DATA AND NON-GENETIC COVARIATES --- #
: <<'PROCEDURE'
 ~ Check the 'samples' folder for properly formatted sample files that we will be using
 ~ Check the 'ETHNICITY' column in 'samples/malariagwas_template_sample.txt'
 ~ Make a list of individuals labled 'NON_CAMEROONIAN' or 'NA'
PROCEDURE

awk '($6 == "NON_CAMEROONIAN") || ($6 == "NA") {print $1,$2,$6}' samples/malariagwas_template_sample.txt | sort | uniq > samples/ethnicity_missing_and_noncameroonians.txt    

#--------------------------------------------------------------------------------#
#                       PREPARING THE RAW GENOTYPE DATA                          #
#--------------------------------------------------------------------------------#
mkdir -p rawdata

: <<'PROCEDURE'
 ~ Convert per chromosome VCF to PLINK binary (pgen) and store in 'rawdata'
 ~ Remove samples with missing ethnicity and non-Cameroonians in the process
 ~ and retaining only biallelic SNPs
 ~ We're using PLINK2 here because it is many folds faster than PLINK1.9
 ~ '@:#:$r:$a' replaces all missing variant IDs to CHR:POS:REF:ALT
PROCEDURE

for chrom in {01..22} 0X; do
  plink2 \
    --vcf ../Cameroon_GWAS-2.5M_b37_chr${chrom}_aligned.vcf.gz \
    --make-pgen \
    --snps-only just-acgt \
    --max-alleles 2 \
    --min-alleles 2 \
    --remove samples/ethnicity_missing_and_noncameroonians.txt \
    --set-missing-var-ids '@:#:$r:$a' \
    --double-id \
    --out rawdata/chr${chrom}
done

: <<'COMMENT'
 ~ Let's delete the '0' in the file names of chr01 to chr09 and chr0X
 ~ In the loop below '{{01..09},0X}' is equivalent to listing the chromosomes one at a time
COMMENT

for file in rawdata/chr{{01..09},0X}*; do
  mv ${file} ${file/0/}
done

: <<'COMMENT'
 ~ Now, let's merge the per chromosome files into a single file.
 ~ The --pmerge option of PLINK2 can achieve this, luckily!
 ~ First we will create a list containing the base name of each file
 ~ Finally, we will delete the per chromosome files to free up some space
COMMENT

for chrom in {1..22} X; do
  echo rawdata/chr${chrom}
done > rawdata/pmerge.list

plink2 \
  --pmerge-list rawdata/pmerge.list 'pfile' \
  --out rawdata/cam-malaria-rawdata

rm rawdata/chr{{1..22},X}.{pgen,pvar,psam,log}  

: <<'NOTE'
 ~ to observe how this code works, run it replacing 'rm' with 'echo'
NOTE


#--------------------------------------------------------------------------------#
#                     GET UPDATED DATA FOR QUALITY CONTROL                       #
#--------------------------------------------------------------------------------#
mkdir -p qualitycontrol

: <<'PROCEDURE'
 ~ Make a copy of the rawdata in the 'qualitycontrol' folder for QC
 ~ ensuring that there are no duplicate variants
 ~ only the first instance of duplicate-ID variants will be kept
 ~ And also updating the sex and phenotype information from the template file 'samples/malariagwas_template_sample.fam'
PROCEDURE

  plink2 \
    --pfile rawdata/cam-malaria-rawdata \
    --make-bed \
    --rm-dup force-first \
    --update-sex samples/malariagwas_template_sample.fam col-num=3 \
    --pheno samples/malariagwas_template_sample.fam \
    --pheno-col-nums 5 \
    --set-hh-missing \
    --out qualitycontrol/cam-malaria



#--------------------------------------------------------------------------------#
#                           Pre-QC ASSOCIATION TEST                              #
#                                                                                #
#  We just wanna see how noisy the data is before quality control                #
#--------------------------------------------------------------------------------#
mkdir -p association

plink2 \
  --bfile qualitycontrol/cam-malaria \
  --logistic sex hide-covar allow-no-covars \
  --adjust \
  --ci 0.95 \
  --out association/cam-malaria-pre-qc

: <<'NOTE'
 ~ Check the log file generated and note the genomic control inflation factor (lambda)
NOTE



#--------------------------------------------------------------------------------#
#                             SAMPLE QUALITY CONTROL                             #
#--------------------------------------------------------------------------------#

# --- Relatedness --- #
: <<'PROCEDURE'
 ~ We first have to process the PLINK binary filesets with PLINK1.9 to make them
 ~ compartible with KING.
 ~ We will perform minimum qc in the process removing variants with missing data > 5%
PROCEDURE

plink \
  --bfile qualitycontrol/cam-malaria \
  --geno 0.05 \
  --make-bed \
  --set-hh-missing \
  --autosome \
  --out qualitycontrol/cam-malaria-relatedness

king \
  -b qualitycontrol/cam-malaria-relatedness.bed \
  --ibdseg \
  --rplot \
  --prefix qualitycontrol/cam-malaria-relatedness-king

mv cam-malaria-relatedness-king_ibd1vsibd2.Rout qualitycontrol/cam-malaria-relatedness-king_ibd1vsibd2.Rout

: <<'NOTE'
 ~ We are interested in the results of 'qualitycontrol/cam-malaria-relatedness-king.seg'  
 ~ Check the last column. We will remove samples with the following infType: Dup/MZ,PO,FS,2nd
NOTE

: <<'PROCEDURE'
 ~ Remove duplicate and highly related individuals
 ~ Only one individual from each pair
 ~ awk is very powerful for text mining and generating reports
 ~ $10 is column 10 (infType)
PROCEDURE

awk '($10 == "Dup/MZ") || ($10 == "FS") || ($10 == "PO") || ($10 == "2nd") {print $1,$2}' qualitycontrol/cam-malaria-relatedness-king.seg | sort | uniq > qualitycontrol/fail-relatedness-qc.txt

: <<'NOTE'
 ~ Delete the filesets created for the purpose of relatedness check to free up some space.
NOTE

rm qualitycontrol/cam-malaria-relatedness.{bed,bim,fam,log,nosex}

# --- Check for discordant sex information --- #
: <<'PROCEDURE'
 ~ PLINK1.9 performs sex check by computing X chromosome inbreeding coeffecient
 ~ Females have 2 X chromosomes while males have 1
 ~ Females are thus expected to have higher heterozygosity, hence 
 ~ lower inbreeding coeffecients than males (for females it is < 0.2, for males it is males > 0.8)
 ~ First, we split the X chromosome pseudo-autosomal regions and remove related individuals so 
 ~ that they don't skew other calculations
PROCEDURE

plink \
  --bfile qualitycontrol/cam-malaria \
  --split-x b37 \
  --remove qualitycontrol/fail-relatedness-qc.txt \
  --make-bed \
  --out qualitycontrol/cam-malaria-no-related

plink \
  --bfile qualitycontrol/cam-malaria-no-related \
  --check-sex \
  --out qualitycontrol/cam-malaria-no-related

: <<'NOTE'
 ~ Individuals that fail will be labled with 'PROBLEM'
NOTE

awk '$5 == "PROBLEM" {print $1,$2,$5}' qualitycontrol/cam-malaria-no-related.sexcheck | sort | uniq > qualitycontrol/fail-sexcheck-qc.txt

# --- Sample Missingness --- #
: <<'PROCEDURE'
 ~ Compute heterozygosity and missing data reports
PROCEDURE

plink2 \
  --bfile qualitycontrol/cam-malaria-no-related \
  --het \
  --missing \
  --out qualitycontrol/cam-malaria-sample-missingness

: <<'IMPORTANT!'
 ~ First run './sample_missingness.r' to see its recommendations
 ~ And then run it with the heterozygoisity and missing rate reports
 ~ Check the figure generated and decide whether to adjust the heterozygosity thresholds manually
 ~ If adjustment is necessary run the script again, this time adding the values as options
 ~ The order in which the options are entered is important!
IMPORTANT!

./sample_missingness.r qualitycontrol/cam-malaria-sample-missingness.het qualitycontrol/cam-malaria-sample-missingness.smiss

mv fail* qualitycontrol/

: <<'COMMENT'
 ~ get a list of all samples that failed QC and remove them to create a new dataset for SNP QC
COMMENT

cat qualitycontrol/fail-* | awk '{print $1,$2}' | sort | uniq > qualitycontrol/fail-sample-qc.txt

plink2 \
  --bfile qualitycontrol/cam-malaria-no-related \
  --remove qualitycontrol/fail-sample-qc.txt \
  --make-bed \
  --out qualitycontrol/cam-malaria-pass-sample-qc


#--------------------------------------------------------------------------------#
#                             SNP QUALITY CONTROL                                #
#--------------------------------------------------------------------------------#

# --- Differential missingnenss --- #
: <<'PROCEDURE'
 ~ Perfome SNP QC in a step-wise fashion, creating temporary intermediate files at each step
 ~ First, remove SNPs with missing rate > 5% (0.05)
 ~ Then remove SNPs that have significantly different missing rate between cases and controls
   - This might indicate some batch effect
   - PLINK2 does not perform this yet. So we use PLINK1.9
 ~ Next, remove SNPs that fail the Hardy-Wienberg equilibrium (HWE) test at P < 1e-06
 ~ Next, remove SNPs with minor allele frequency (MAF) < 1% (0.01)
 ~ Next, extract palindromic [A/T] and [C/G] SNPs
 ~ Finally, remove palindromic and SNPs with minor allele frequency (MAF) < 1% (0.01), and ensure that
   the X chromosome is merged back
 ~ We use the dataset from which bad samples have been removed
PROCEDURE

plink \
  --bfile qualitycontrol/cam-malaria-pass-sample-qc \
  --geno 0.05 \
  --make-bed \
  --out qualitycontrol/temp1

plink \
  --bfile qualitycontrol/temp1 \
  --test-missing \
  --out qualitycontrol/cam-malaria-differential-missingness

: <<'NOTE'
 ~ Check the report 'qualitycontrol/cam-malaria-differential-missingness.missing'
 ~ Look at the p-value column (P at column 5). We will use a somewhat stringent threshold (P < 0.001)
 ~ Save the SNPs and their corresponding p-values into a new file that will be used to exclude them
NOTE

awk '$5 < 0.001 {print $2,$5}' qualitycontrol/cam-malaria-differential-missingness.missing > qualitycontrol/fail-differential-missingness-qc.txt

plink \
  --bfile qualitycontrol/temp1 \
  --exclude qualitycontrol/fail-differential-missingness-qc.txt \
  --hwe 1e-06 \
  --make-bed \
  --out qualitycontrol/temp2


./palindromic_snps.r qualitycontrol/temp2.bim


plink \
  --bfile qualitycontrol/temp2 \
  --maf 0.01 \
  --exclude qualitycontrol/temp2.at-cg.snps \
  --mind 0.10 \
  --make-bed \
  --merge-x \
  --out qualitycontrol/cam-malaria-pass-sample-and-snp-qc

: <<'NOTE'
 ~ The '--mind 0.10' here is to ensure that no samples with > 10% missing rate slip through our pipeline
NOTE



: <<'NOTE'
 ~ Delete the temporary filesets to free up some space.
NOTE

rm qualitycontrol/cam-malaria-no-related.{bed,bim,fam,hh,nosex,log}
rm qualitycontrol/temp*.{bed,bim,fam,hh,nosex,log}



#--------------------------------------------------------------------------------#
#                           POST-QC ASSOCIATION TEST                             #
#--------------------------------------------------------------------------------#

plink2 \
  --bfile qualitycontrol/cam-malaria-pass-sample-and-snp-qc \
  --logistic sex hide-covar allow-no-covars \
  --adjust \
  --ci 0.95 \
  --out association/cam-malaria-post-qc

: <<'NOTE'
 ~ Check the log file generated and note how the genomic control inflation factor (lambda)
   changed compared to the pre-qc association test
NOTE



#--------------------------------------------------------------------------------#
#                      PRINCIPAL COMPONENT ANALYSIS (PCA)                        #
#--------------------------------------------------------------------------------#
: <<'COMMENT'
 ~ Now let's compute PCA, adjust for covariates in the association test, and observe the difference
COMMENT
