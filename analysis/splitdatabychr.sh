#!/bin/bash

touch log.file
rm log.file
touch log.file

for chr in $(seq 1 22); 
do
	echo -e "\n######### CHR "$chr" ############\n" >> log.
	plink1.9 \
	--bfile ../qc-camgwas \
	--chr ${chr} \
	--allow-no-sex \
	--keep-allele-order \
	--make-bed \
	--out qc-camgwas.chr${chr} ;
	cat qc-camgwas.chr${chr}.log >> log.file

#	plink1.9 \
#	--file qc-camgwas.chr${chr} \
#	--allow-no-sex \
#	--make-bed \
#	--out qc-camgwas.chr${chr} ;
#	cat qc-camgwas.chr${chr}.log >> log.file

#	rm *.map *.ped *.log
	rm *.log

done
