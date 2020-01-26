#!/bin/bash


cut -f2 phasedWrefImpute2.bim | cut -f1-2 -d':' | sort | uniq -d > dups.txt

split -d -l 1000 dups.txt

for i in x*; do grep -w -f${i} phasedWrefImpute2.bim; done | cut -f2 > dups.txt

plink \
	--bfile phasedWrefImpute2 \
	--keep-allele-order \
	--exclude dups.txt \
	--make-bed \
	--out phasedWrefImpute2NoDups


# Search for all the 16 possible two-base combinations that would mean multi-allelic and save in a file
for i in GG GC GA GT CG CC CA CT AG AC AA AT TG TC TA TT; do
    grep "${i}" phasedWrefImpute2NoDups.bim | cut -f2 | sort | uniq; 
done > multi_allelic.txt

# Remove all non-SNP variants
grep ">" phasedWrefImpute2NoDups.bim | cut -f2 > alu.txt

cat multi_allelic.txt alu.txt exclude.txt > exclusion.list

plink \
	--bfile phasedWrefImpute2NoDups \
	--keep-allele-order \
	--exclude multi_allelic.txt \
	--make-bed \
	--out phasedWrefImpute2Biallelic

rm x* multi_allelic.txt alu.txt
