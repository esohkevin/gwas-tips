#!/bin/bash

if [[ $# == 9 ]]; then

    map="$1"
    leg="$2"
    hap="$3"
    chr="$4"
    numhap="$5"
    dlocus="$6"
    hetrisk="$7"
    homrisk="$8"
    out="$9"
    
    
    hapgen2 \
    	-m ${map} \
    	-l ${leg} \
    	-h ${hap} \
    	-n ${numhap} ${numhap} \
    	-dl ${dlocus} ${hetrisk} ${homrisk} \
    	-no_gens_output \
    	-Ne 17469 \
    	-o ${out}
    
    
    # Set awk variables
    a='$1"\\t"'
    b="\"$chr\""	  
    c='"\\t"$2"\\t"$4"\\t"$3'
    
    echo "{print `awk -v vara="$a" -v varb="$b" -v varc="$c" 'BEGIN{print vara varb varc}'`}" > awkProgFile.txt
    
    sed '1d' ${leg} | \
            awk -f awkProgFile.txt > ${out}.map
    sed 's/0/2/g' ${out}.controls.haps > ${out}.hap
    
    else
    	echo """
    	Usage: ./simhaps.sh <map-file> <legend-file> <haps-file> <chr#> <num-haps> <dlocus> <outname>
    
    		   map-file: Recombination map file
    		legend-file: Input legend file
    		  haps-file: Input haplotype file
    		       chr#: Chromosome number
    		   num-haps: Number of haplotypes to simulate
		     dlocus: The disease locus position (e.g. 63487386)
		    hetrisk: heterozygote disease risk
		    homrisk: homozygote disease risk
    		    outname: THe output file name
    	"""

fi
