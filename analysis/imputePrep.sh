#!/usr/bin/env bash

cd ../;
baseDir=`pwd`
cd -;
analysis="${baseDir}/analysis/"
kgp="${baseDir}/phase/1000GP_Phase3/"
eig="${baseDir}/popstruct/eig/EIGENSTRAT/"
eigstruct="${baseDir}/popstruct/eig/"

echo "######################## Extract Palimcromic SNPs and prepare chromosomes for imputation services ########################"
# Compute allel frequencies
plink \
	--bfile qc-camgwas \
	--allow-no-sex \
	--freq \
	--out qc-camgwas
cat qc-camgwas.log > log-impuPrep.txt

echo -e "\n####################### Now extract palindromic SNPs in R for subsequent exclusion #####################"
R CMD BATCH palindromicsnps.R

echo -e "\n#################### Check Strand using the Wrayner perl script #############################"
./checkstrand.sh

####################### Add command line to remove at-cg SNPs ###################################
echo -e "\n### Update Run-plink.sh file to remove palindromic SNPs ###"
echo "plink --bfile qc-camgwas --allow-no-sex --exclude at-cg.snps --make-bed --out TEMP0" > TEMP.file
echo "plink --bfile TEMP0 --exclude Exclude-qc-camgwas-1000G.txt --make-bed --out TEMP1" >> TEMP.file
echo "plink --bfile TEMP1 --update-map Chromosome-qc-camgwas-1000G.txt --update-chr --make-bed --out TEMP2" >> TEMP.file
grep -v "TEMP1" Run-plink.sh >> TEMP.file
cp TEMP.file Run-plink.sh

echo -e "\n########################### Run Run-plink.sh to update the dataset ##########################"
./Run-plink.sh

cat qc-camgwas-updated.log >> log-impuPrep.txt

echo -e "\n#################Converting Single Chromosome plink binary files to VCF files####################\n"
./plink2vcf.sh

echo -e "\n######################## Chechk VCF for errors using the checkVCF.py script ########################"
./vcfcheck.sh

################################# Remove Irrelevant Files ####################################
rm qc-camgwas-updated-chr*.*
