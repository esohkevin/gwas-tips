#!/bin/bash

resp="$1"

if [[ $resp == "1" && $# != 2 ]]; then

    echo """
        Usage: ./run_emmax.sh 1 <bfile-prefix>
    """

elif [[ $resp == 1 && $# == 2 ]]; then

    base="$2"
    						# Make emmax input tped and tfam
    plink \
    	--bfile ${base} \
    	--recode12 transpose \
	--autosome \
    	--output-missing-genotype 0 \
    	--out ${base}


    emmax-kin -v -d 10 ${base}			# Generate kinship matrix

    awk '{print $1,$2,$6}' ${base}.tfam > ${base}.phe	# Generate pheno file

    emmax -v -d 10 -t ${base} -p ${base}.phe -k ${base}.BN.kinf -o ${base}


elif [[ $resp == "2" && $# != 2 ]]; then

    echo """
        Usage: ./run_emmax.sh 2 <bfile-prefix>

	Please make sure your covariates file has the same prefix as tped file and ends with .cov
    """

elif [[ $resp == 2 && $# == 2 ]]; then

    base="$2"
                                                # Make emmax input tped and tfam
#    plink \
#        --bfile ${base} \
#        --recode12 transpose \
#	--autosome \
#        --output-missing-genotype 0 \
#        --out ${base}
#
##    awk '{print $1,$2,"1",$3,$4,$5,$6,$7,$8,$9,$10,$11,$12,$13,$14,$15,$16,$17,$18,$19,$20,$21,$22,$23,$24,$25,$26,$27,$28,$29,$30,$31,$32}' qc-camgwas.pcs | sed '1d' > qc-camgwas-updated.cov
#    emmax-kin -v -d 10 ${base}	                # Generate kinship matrix

    awk '{print $1,$2,$6}' ${base}.tfam > ${base}.phe   # Generate pheno file

    emmax -v -d 10 -t ${base} -p ${base}.phe -k ${base}.BN.kinf -c ${base}.cov -o ${base}

elif [[ $resp != [12] ]]; then
    echo """
	Usage: ./run_emmax.sh [1|2] <bfile-prefix>

	Enter 1 or 2 then prefix of bfile to convert to tped and tfam
	1: Association without covariates
	2: Association with covariates
    """

fi
