#!/bin/bash


if [[ $# == 2 ]]; then

    bfile="$1"
    cov="$2"
    
    bolt \
        --bfile=${1} \
        --phenoUseFam \
        --covarFile=${2} \
        --covarMaxLevels=30 \
	--LDscoresUseChip \
	--maxModelSnps=8000000 \
        --qCovarCol=C{1:30} \
        --geneticMapFile=../phase/tables/genetic_map_hg19_withX.txt.gz \
        --lmmForceNonInf \
        --numThreads=8 \
        --statsFile=${1}.stats.gz \
        --verboseStats

else
    echo """
	Usage: ./run_bolt.sh <bfile-prefix> <covar-file>
    """
fi

#bolt \
#    --bfile=${1} \
#    --remove=bolt.in_plink_but_not_imputed.FID_IID.976.txt \
#    --remove=sampleQC/remove.nonWhite.FID_IID.txt \
#    --exclude=snpQC/autosome_maf_lt_0.001.txt \
#    --exclude=snpQC/autosome_missing_gt_0.1.txt \
#    --phenoFile=ukb4777.phenotypes.tab \
#    --phenoCol=height \
#    --covarFile=ukb4777.covars.tab.gz \
#    --covarCol=cov_ASSESS_CENTER \
#    --covarCol=cov_GENO_ARRAY \
#    --covarMaxLevels=30 \
#    --qCovarCol=cov_AGE \
#    --qCovarCol=cov_AGE_SQ \
#    --qCovarCol=PC{1:20} \
#    --LDscoresFile=tables/LDSCORE.1000G_EUR.tab.gz \
#    --geneticMapFile=tables/genetic_map_hg19.txt.gz \
#    --lmmForceNonInf \
#    --numThreads=8 \
#    --statsFile=bolt_460K_selfRepWhite.height.stats.gz \
#    --bgenFile=ukb_imp_chr{1:22}_v2.bgen \
#    --bgenMinMAF=1e-3 \
#    --bgenMinINFO=0.3 \
#    --sampleFile=ukb1404_imp_chr1_v2_s487406.sample \
#    --statsFileBgenSnps=bolt_460K_selfRepWhite.height.bgen.stats.gz \
#    --verboseStats
