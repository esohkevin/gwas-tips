#!/bin/bash

if [[ $# == 4 ]]; then

    #-- Set input and output environment variables
    sids="$1"
    prids="$2"
    C1="$3"
    C2="$4"
    out="$(basename $sids)"

    #-- Get the Ethnicities/Continents of the indivs into a file
    grep -f $sids $prids | \
        awk -v a="$C1" -v b="$C2" '{print $b}' | uniq > temp.eth
    

    #-- Extract the indivs and their corresponding eth/conts
    grep -f $sids $prids | \
    	awk -v a="$C1" -v b="$C2" '{print $a,$b}' > ${sids/.*/.eth}
    

    #-- Make the Force file
    for i in $(cat temp.eth); do \
        grep -wi $i ${sids/.*/.eth} | \
            awk '{print $1}' | \
            tr "\n" "," | \
            sed 's/,$//' | \
            awk -v pop="$i" 'OFS=""; {print pop,"(",$0,")"}'; 
    done > ${out/.*/_force.txt}

    rm temp.eth
    
    else 
        echo """
    	Usage:./create_force.sh <SIDs> <PRIDs> <C1> <C2>
    	   
    	     SIDs: Sample ID list for the current fs project (Single column)
    	    PRIDs: Super list of all individual IDs plust their associated ethnicityes or continents
    	       C1: Column number of the Individual IDs in the Super list
               C2: Column number of the individual ethnicity or continent
        """
fi

#--- Make Sample groupings for 1 iteration mcmc file
#tr '\n' ' ' < cam-afr50_force.txt | sed 's/BA//g' | sed 's/\ FO//g' | sed 's/\ SB//g' | sed 's/\ YRI//g' | sed 's/\ ESN//g' | sed 's/\ MSL//g' | sed 's/\ GWD//g' | sed 's/\ LWK//g' | awk '{print "<Pop>"$0"</Pop>"}' >> camgwas_linked_mcmc2.xml
