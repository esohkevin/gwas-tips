#!/bin/bash

world="../world/"
convert="../world/CONVERTF/"

# Perform admixture cross-validation to determine the appropriate k value to use

if [[ $# == 2 ]]; then

   inbed="$1"
   nseq="$2"

   seq $nseq | parallel echo --cv ${inbed}.bed {} -B300 -j15 | xargs -P5 -n5 admixture
   
   
   #./plotQestimate.sh log.out
else
    echo """
	Usage:./run_admixture.sh <input-bed-root> <#K [number of K params]>
    """
fi
