#!/bin/bash

if [[ $# == 2 ]]; then

    beagle \
	gt=${1} \
	out=${2} \
	burnin=10 \
	iterations=15 \
	nthreads=4

    bgzip ${2}
    tabix -f -p vcf ${2}.vcf.gz

else
   echo """
	Usage: ./beaglePhase.sh <vcf-file> <out-file>
   """

fi
