#!/bin/bash

if [[ $# != 6 ]]; then
   echo """
	Usage: ./runEHH.sh <in-hap-file> <in-map-file> <ehh-plot-name> <core-locus1> <core-locus2> <core-locus3>
"""
else

   Rscript runEHH.R $1 $2 $3 $4 $5 $6

   echo "Done running EHH!"

fi
