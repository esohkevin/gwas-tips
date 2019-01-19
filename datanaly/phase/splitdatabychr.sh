#!/bin/bash

touch log.file
rm log.file
touch log.file
for chr in $(seq 1 22); 
do
	echo "######### CHR "$chr" ############" >> log.file
	echo " "
	plink1.9 \
	--bfile ../newtest/qc-camgwas \
	--chr ${chr} \
	--allow-no-sex \
	--recode \
	--out qc-camgwas.chr${chr} ;
	cat qc-camgwas.chr${chr}.log >> log.file

	plink1.9 \
	--file qc-camgwas.chr${chr} \
	--allow-no-sex \
	--make-bed \
	--out qc-camgwas.chr${chr} ;
	cat qc-camgwas.chr${chr}.log >> log.file

	rm *.map *.ped *.log
done
