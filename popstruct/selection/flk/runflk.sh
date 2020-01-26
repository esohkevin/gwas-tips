#!/bin/bash

p="$1"
prfx="$2"
n="$3"
nl="$4"
nh="$5"

if [[ $# == 2 && $p == "flk" ]]; then

    #--- Whole Genome flk
    hapflk --bfile boot/${prfx} --outgroup=MSL --phased -p flkout/${prfx}
    Rscript flk.R flkout/$prfx.flk

elif [[ $# == 5 && $p == "hflk" ]]; then
        
    #--- Per chromosome hapflk
    seq $nl $nh | parallel echo --bfile boot/${prfx}{}flk -K 15 --kinship flkout/camflk_fij.txt --ncpu=15 --phased --kfrq -p flkout/${prfx}{}flk | xargs -P$n -n11 hapflk
    seq $nl $nh | parallel echo "hapflk-clusterplot.R flkout/${prfx}{}flk.kfrq.fit_1.bz2" | xargs -P5 -n2 Rscript
    seq $nl $nh | parallel echo "scaling_chi2_hapflk.py flkout/${prfx}{}flk.hapflk 15 3" | xargs -P5 -n4 python
    ./hflkman.R flkout/${prfx} 22

else
    echo """
	Usage:./runflk.sh [flk|hflk] <in-prefix> <N> <NL> <NH>

		Enter 'flk' to run only whole genome flk or 'hflk' to run only hapflk
		prefix: Input bfile prefix. Do not specify path 
			(input will be takien from /boot and output will be saved in /flkout)
		     N: Number of jobs (chromosomes) to run eacg time (NB: Necessary for 'hapflk' only)
		    NL: Lower CHROM number; CHROM num to start with
		    NH: Higher CHROM number; CHROM num to end with
    """
fi
