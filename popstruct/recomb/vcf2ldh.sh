#!/bin/bash

if [[ $1 == "ldhat" ]]; then

    if [[ $# == [45] ]]; then
        
        mkdir -p ldhat
        in_vcf="$2"
        chr=$3
        famfile="$4"
        out="$5"
    
        for chr in $(seq 1 $chr); do
          vcftools \
            --gzvcf ${in_vcf} \
            --chr ${chr} \
            --phased \
            --ldhat \
            --keep ${famfile} \
            --out ldhat/${out}chr${chr}
        done

	echo """
		Done! All files saved in the directory 'ldhat'
	"""
    
    else
        echo """
    	Usage: ./vcf2ldh.sh ldhat <in_vcf> <#chr> <sample-file> <out-prefix>
        """
    
    fi

elif [[ $1 == "ldhelmet" ]]; then

    if [[ $# == [45] ]]; then
    
        mkdir -p ldhel
        in_vcf="$2"
        chr=$3
        famfile="$4"
        out="$5"
    
        for chr in $(seq 1 $chr); do
          vcftools \
            --gzvcf ${in_vcf} \
            --chr ${chr} \
            --phased \
            --ldhelmet \
            --keep ${famfile} \
            --out ldhel/${out}chr${chr}
        done

        echo """
                Done! All files saved in the directory 'ldhel'
        """
    
    else
        echo """
            Usage: ./vcf2ldh.sh ldhelmet <in_vcf> <#chr> <sample-file> <out-prefix>
        """
    
    fi

else 
    echo """
	Usage: ./vcf2ldh.sh <[ldhat|ldhelmet]>
    """
fi
