#!/bin/bash

# Extract population from each into separate files

#plink \
#	--bfile ../analysis/qc-camgwas-updated \
#	--thin-indiv-count 200 \
#	--make-bed \
#	--autosome \
#	--out qc-camgwas200

#cut -f2 qc-camgwas200.bim > camgwas200.ids
cut -f2 ind-qc-camgwas.bim | wc -l > snp-count.txt

for snpCount in `cat snp-count.txt`; do
  
  pop="YRI ESN LWK GWD MSL"
  
    for eachPop in $pop; do 
	cut -f1,4 igsr_phase3.samples | \
		grep $eachPop | cut -f1 > "$eachPop"1.ids
	cut -f1,4 igsr_phase3.samples | \
                grep $eachPop | cut -f1 > "$eachPop"2.ids
	paste "$eachPop"1.ids "$eachPop"2.ids > all_"$eachPop".ids
	rm "$eachPop"1.ids "$eachPop"2.ids


	# Get World Pops
	plink \
        	--vcf ../1000G/Phase3_merged.vcf.gz \
        	--allow-no-sex \
        	--autosome \
		--thin-count ${snpCount} \
        	--make-bed \
		--keep all_"$eachPop".ids \
        	--biallelic-only \
        	--exclude-snp rs16959560 \
        	--out 1kgp_${eachPop}

	# Compute frequency stats
	plink \
		--bfile 1kgp_${eachPop} \
		--allow-no-sex \
		--freq \
		--out 1kgp3_$eachPop

#Rscript --vanilla 1kgp_snpmiss.R 1kgp3_$eachPop.frq ${eachPop}_maf.png		# Include SNP missing genotype test and uncomment this line
Rscript --vanilla 1kgp_maf.R 1kgp3_$eachPop.frq ${eachPop}_maf.png
     done
done
