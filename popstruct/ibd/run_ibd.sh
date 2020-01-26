#!/bin/bash

if [[ $1 == 1 ]]; then

    #---- One Pop IBD
    hmmIBD \
    	-i pf3k_Cambodia_13.txt \
    	-f freqs_pf3k_Cambodia_13.txt \
    	-o mytest_1pop

elif [[ $1 == 2 ]]; then
    pop1="$2"
    frq1="$3"
    pop2="$4"
    frq2="$5"
    outn="$6"
    #---- Cross-pop IBD
    #hmmIBD \
    #	-i $pop1 \
    #	-f $frq1 \
    #	-I $pop2 \
    #	-F $frq2 \
    #	-o $outn

    #--Run hmmIBD in parallel
    for i in BA FO; do echo $i; done | parallel hmmIBD "-i SB.gt -f frq.SB.txt -I {}.gt -F frq.{}.txt -o sb_{}"
    for i in SB FO; do echo $i; done | parallel hmmIBD "-i BA.gt -f frq.BA.txt -I {}.gt -F frq.{}.txt -o ba_{}"               

else
    echo """
	Usage: ./run_ibd.sh <(int) [1|2]> 

	Enter '1' for one population
	      '2' for cross-population (two pops)
    """
fi
