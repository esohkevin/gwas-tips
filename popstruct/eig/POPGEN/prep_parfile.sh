#!/bin/bash

if [[ $# == 1 ]]; then
    
base="$1"
bname=$(basename ${base})

# ==> popgen parameter file <==
echo """
genotypename:    ${base}.ancestrymapgeno
snpname:         ${base}.snp
indivname:       ${base}-eth.ind
evecoutname:     ${bname}-eth.evec
evaloutname:     ${bname}-eth.eval
altnormstyle:    NO
outlieroutname:  ${bname}.outlier
familynames:     NO
#snpweightoutname:      ${bname}-snpwt
deletesnpoutname:       ${bname}-eth-badsnps
#numthreads:     2
ldregress:       200
phylipoutname:   ${bname}.phy
fstonly:         YES

""" > par.smartpca-ancmap-eth-fst

else
    echo """
	Usage: ./prep_parfile.sh <input-root (with path)>
	
		input-root: basename of eigenstrat format files with path to the files
    """

fi

