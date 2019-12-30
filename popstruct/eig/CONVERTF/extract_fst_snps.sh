#!/bin/bash

if [[ $# == 2 ]]; then

    #-----Extract only Fst-best SNPs for PCA analysis
    ped="$1"
    fst="$2"
    bname="$(basename $fst)"
    out="${bname/_fst.txt/}"
    
    plink \
    	--file $ped \
    	--extract $fst \
    	--recode \
	--aec \
    	--out $out
    
    ./make_par_files.sh ${out}
    
    convertf -p par.PED.PACKEDPED
    convertf -p par.PACKEDPED.PACKEDANCESTRYMAP
    convertf -p par.PACKEDANCESTRYMAP.ANCESTRYMAP
    convertf -p par.ANCESTRYMAP.EIGENSTRAT

else
    echo """
	Usage:./extract_fst_snps.sh <ped+map-root> <snp-file>
    """
fi
