#!/bin/bash

if [[ $# == 3 ]]; then

    in_vcf="$1"
    bname=$(basename $in_vcf)
    
    fsamcol="$2"
    
    zgrep "^#" ${in_vcf} | \
        tail -1 | \
        cut -f ${fsamcol}- > ${bname/.vcf.gz/.sites}
    
    
    zgrep -v "^#" ${in_vcf} | \
        sed s/"0|0"/0/g | \
        sed s/"1|0"/2/g | \
        sed s/"0|1"/2/g | \
        sed s/"1|1"/1/g | \
        cut -f ${fsamcol}- >> ${bname/.vcf.gz/.sites}


    if [[ $3 != '\t' ]]; then
    
        file="${bname/.vcf.gz/.sites}"
        sep="$3"
        nsites=$(sed '1d' $file | wc -l)
        nsamp=$(head -1 $file | sed s/"$sep"/"\n"/g | wc -l)
    
        echo -e "$nsamp"$sep"$nsites"$sep"1""" > t${file}
    
        #numc=$(($(head -n 1 "$file" | grep -o "$sep" | wc -l)+1))
        for ((i=1; i<="$nsamp"; i++))
        #do cut -d "$sep" -f"$i" "$file" | paste -s -d "$sep" >> t${file}
    
        do cut -d "$sep" -f"$i" $file | \
              paste -s -d "$sep" | \
              awk -v col="$i" '{print ">"$col}';
           cut -d "$sep" -f"$i" $file | \
              paste -s -d "$sep" | \
              cut -f 2- -d "$sep" | \
              sed 's/ //g' | \
              fold -2000;
        done >> t$file
    
    else
        file="${bname/.vcf.gz/.sites}"
        sep="$3"
        nsites=$(sed '1d' $file | wc -l)
        nsamp=$(head -1 $file | sed s/"$sep"/"\n"/g | wc -l)
    
        echo -e "$nsamp"$sep"$nsites"$sep"1""" > t${file}
    
    
        for i in $(seq 1 $nsamp); do
            cut -f$i $file | \
               paste -s -d' ' | \
               awk '{print ">"$1}';
            cut -f$i $file | \
               paste -s -d' ' | \
               cut -f 2- -d' ' | \
               sed 's/ //g' | \
               fold -2000;
        done >> t$file
    fi


else 
    echo """
	Usage: ./prep_ldhat.sh <in_vcf [gzipped]> <1st-sample-col-num> <sep>

		    in_vcf: VCF genotpye file gzipped
	1st-sample-col-num: Column number of the first sample in the VCF file
		       sep: The file delimiter (e.g. '\t' or ' ' or ',')
    """
fi
