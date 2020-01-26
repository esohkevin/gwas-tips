#!/bin/bash

if [[ $# == 1 ]]; then

in_file="$1"

plink \
	--file ${in_file} \
	--fst \
	--keep-allele-order \
	--keep pca.ids \
	--autosome \
	--within plink_fst.pops \
	--out all

else
    echo """
	Usage./run_fst <ped+map>

	pep+map: ped and map file root from ../eig/CONVERT/
	(Specify the path)
    """
fi
