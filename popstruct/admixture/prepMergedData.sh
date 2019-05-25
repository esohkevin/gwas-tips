#!/bin/bash

analysis="../../analysis/"
samples="../../samples/"
kgp="../../1000G/"
world="../eig/world/worldPops/"

# Extract YRI IDs for acertainment of Fst estimates
grep "YRI" ../eig/world/igsr_pops.txt | cut -f1 > yri.txt

rm yri.ids

for id in `cat yri.txt`;
    do echo ${id} ${id} >> yri.ids;
done

plink \
        --bfile ${world}qc-rsids-world-pops \
        --autosome \
        --keep yri.ids \
        --make-bed \
        --maf 0.35 \
        --out yri

cut -f2 yri.bim > yri.rsids

# Extract only a subset of world Pops to use (YRI+LWK+GWD+GBR+CHS+BEB+PUR). 
# The ids are stored in worldPops.ids
plink \
        --bfile ${world}qc-rsids-world-pops \
        --allow-no-sex \
	--extract yri.rsids \
        --autosome \
	--make-bed \
        --keep worldPops.ids \
        --out worldPops
at adm-data.log > log.file

# Extract yri ids from study dataset
plink \
        --bfile ${analysis}qc-camgwas-updated \
        --allow-no-sex \
        --autosome \
	--extract yri.rsids \
        --make-bed \
        --out studyPops
cat studyPops.log >> log.file

# Merge whole dataset with world Pops shown by Fst to be closest and farthest from 
# from Cameroonian Pops for Admixture Analysis ()

plink \
        --bfile studyPops \
        --allow-no-sex \
	--autosome \
        --bmerge worldPops \
        --out merged
cat merged.log >> log.file

# Prune to get only SNPs at linkage equilibrium (independent SNPs - no LD between them)
plink \
	--bfile merged \
	--indep-pairwise 50 5 0.2 \
	--allow-no-sex \
	--out prune
cat prune.log >> log.file

plink \
	--bfile merged \
	--autosome \
	--extract prune.prune.in \
	--make-bed \
	--out adm-data
cat adm-data.log >> log.file

rm yri* prune* merged* studyPops*
