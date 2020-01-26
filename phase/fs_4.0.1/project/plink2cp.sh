#!/bin/bash

analysis="../../../analysis/"
pop="../../../popstruct/"

../popstruct/fst/fvcf/

for chr in {1..22}; do
    plink \
        --vcf ../fs.vcf.gz \
        --allow-no-sex \
        --pheno "${analysis}"raw-camgwas.fam \
        --update-sex "${analysis}"raw-camgwas.fam 3 \
        --mpheno 4 \
	--remove fs_outliers.txt \
	--maf 0.05 \
        --recode12 \
        --chr ${chr} \
        --double-id \
        --biallelic-only \
        --keep-allele-order \
        --out chr${chr}_phasedWref

    plink2chromopainter.pl \
	-p=chr${chr}_phasedWref.ped \
	-m=chr${chr}_phasedWref.map \
	-o=chr${chr}_phasedWref.phase \
	-d=chr${chr}_phasedWref.cp.sample \
	-g=10e6

    makeuniformrecfile.pl chr${chr}_phasedWref.phase chr${chr}_phasedWref.recombfile
    rm chr${chr}_phasedWref.map chr${chr}_phasedWref.ped chr${chr}_phasedWref.nosex chr${chr}_phasedWref.log
done
awk '{print $1}' camgwasPhasedWref.ids > temp1.txt
grep -f temp1.txt ../world.pops | awk '{print $1,$5,$4}' > camgwasPhasedWref.ids
mv chr1_phasedWref.cp.sample camgwasPhasedWref.ids
rm chr*_phasedWref.cp.sample
