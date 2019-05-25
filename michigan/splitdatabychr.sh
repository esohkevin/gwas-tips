#!/bin/bash

touch log.file
rm log.file
touch log.file

for chr in $(seq 1 22); 
do
	echo -e "\n######### CHR "$chr" ############\n" >> log.
	plink1.9 \
	--bfile "$1" \
	--chr ${chr} \
	--allow-no-sex \
	--make-bed \
	--out merge.filtered-updated-chr${chr} ;
	cat merge.filtered-updated-chr${chr}.log >> log.file

#	plink1.9 \
#	--file qc-camgwas.chr${chr} \
#	--allow-no-sex \
#	--make-bed \
#	--out qc-camgwas.chr${chr} ;
#	cat qc-camgwas.chr${chr}.log >> log.file

#	rm *.map *.ped *.log
#	rm *.log

done
