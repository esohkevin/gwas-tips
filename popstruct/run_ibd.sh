#!/bin/bash

if [[ $1 == 1 ]]; then

    #---- One Pop IBD
    hmmIBD \
    	-i pf3k_Cambodia_13.txt \
    	-f freqs_pf3k_Cambodia_13.txt \
    	-o mytest_1pop

elif [[ $1 == 2 ]]; then
    
    #---- Cross-pop IBD
    hmmIBD \
    	-i pf3k_Cambodia_13.txt \
    	-f freqs_pf3k_Cambodia_13.txt \
    	-I pf3k_Ghana_13.txt \
    	-F freqs_pf3k_Ghana_13.txt \
    	-o mytest_2pop

else
    echo """
	Usage: ./run_ibd.sh <(int) [1|2]>

	Enter '1' for one population
	      '2' for cross-population (two pops)
    """
fi
