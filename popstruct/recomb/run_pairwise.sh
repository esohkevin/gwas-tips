#!/bin/bash

if [[ $# == 1 ]]; then

    for chr in {1..22}; do 
	echo "-seq chr${chr}.ldhat.sites -loc chr${chr}.ldhat.locs -prefix chr${chr}"; 
    done > arg_file.txt

cat arg_file.txt | xargs -P22 -n6 pairwise

#pairwise -seq chr10.ldhat.sites -loc chr10.ldhat.locs -prefix chr10
else
    echo """
	Usage: ./run_pairwise.sh <#chr>
    """
fi
