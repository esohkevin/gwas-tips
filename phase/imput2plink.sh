#!/bin/bash

assocResults="../assoc_results/"

for chr in {1..22}; do
 
     grep -v "<" chr${chr}ImputSuccessful.txt |  awk '$7>=0.75' | sed '1d' | cut -f2 -d' ' | sort | uniq -u | sort | uniq -u > chr${chr}inclusion.txt
 
     grep -v -f codons.txt chr${chr}inclusion.txt > chr${chr}inclusion.list
    
     cut -f2 -d' ' chr${chr}ImputSuccessful.txt | sort | uniq -D > chr${chr}exclusion.list
 
     cut -f1-3 -d':' chr${chr}ImputSuccessful.txt | sort | uniq -D > refdups.txt
 
     grep -v -f refdups.txt chr${chr}ImputSuccessful.txt | cut -f2 -d' ' | sort | uniq -D >> chr${chr}exclusion.list
 
done


#if [[ -f "merge.list" ]]; then
#
#      rm merge.list
#
#fi


for chr in {1..22}; do

    echo chr${chr} >> merge.list

    plink \
	--oxford-single-chr ${chr} \
	--gen chr${chr}_imputed.gen.gz \
	--maf 0.0001 \
	--sample phasedWref.sample \
	--make-bed \
	--hwe 1e-8 \
	--keep-allele-order \
	--extract chr${chr}inclusion.list \
	--hard-call-threshold 0.01 \
	--out chr$chr-temp


    plink \
        --bfile chr${chr}-temp \
        --exclude chr${chr}exclusion.list \
	--make-bed \i
	--keep-allele-order \
	--out chr${chr}
done




plink \
	--merge-list merge.list \
	--keep-allele-order \
	--out phasedWrefImpute2

plink \
	--bfile phasedWrefImpute2 \
	--list-duplicate-vars ids-only suppress-first \
	--keep-allele-order \
	--out dups

plink \
        --bfile phasedWrefImpute2 \
	--exclude dups.dupvar \
	--keep-allele-order \
	--make-bed \
	--out phasedWrefImpute2
#
#for chr in {1..22}; do
#    rm chr${chr}.bim chr${chr}.bed chr${chr}.fam chr${chr}.log
#done


cut -f1,4 phasedWrefImpute2.bim | \
	sed 's/\t/:/g' > phasedWrefImpute2.pos
cut -f2 phasedWrefImpute2.bim > phasedWrefImpute2.ids
paste phasedWrefImpute2.ids phasedWrefImpute2.pos > phasedWrefImpute2-ids-pos.txt

# Get duplicates in the bim file and exclude
cut -f2 phasedWrefImpute2.bim | uniq -D > bim.dups
grep -f bim.dups phasedWrefImpute2-ids-pos.txt | cut -f1 >> phasedWrefImpute2exclusion.list

plink \
	--bfile phasedWrefImpute2 \
	--update-name phasedWrefImpute2-ids-pos.txt 2 1 \
	--exclude phasedWrefImpute2exclusion.list \
	--allow-no-sex \
	--make-bed \
	--out phasedWrefImpute2

plink \
	--bfile phasedWrefImpute2 \
	--update-name ../analysis/updateName.txt 1 2 \
	--allow-no-sex \
	--make-bed \
	--out phasedWrefImpute2-updated

# Check against ref for ref allele assignment (Note all errors and warnings. Fix before making vcf)
plink2 \
	--bfile phasedWrefImpute2-updated \
	--ref-allele force ../analysis/refSites.txt 4 1 \
	--make-bed \
	--out phasedWrefImpute2-imp-refchecked

# Convert to vcf for phasing
plink \
	--bfile phasedWrefImpute2-imp-refchecked \
	--recode vcf-fid bgz \
	--real-ref-alleles \
	--exclude-snp rs4760904 \
	--keep-allele-order \
	--out phasedWrefImpute2-imputed

for chr in {1..22}; do
   
    rm chr${chr}-temp chr${chr}.fam chr${chr}.bed chr${chr}.bim dups* *inclusion.txt *~ chr${chr}-imp-refchecked* chr${chr}-updated* refdups.txt chr${chr}exclusion.list chr${chr}exclusion.txt

done
