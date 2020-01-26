#!/bin/bash

if [[ $# == 2 ]]; then

    poplist="$1"
    base="${poplist/-pop.list/}"
    thr="$2"

echo """
genotypename:    ../CONVERTF/world.eigenstratgeno
snpname:         ../CONVERTF/world.snp
indivname:       ../CONVERTF/world-ald.ind
altnormstyle:    NO
ldregress:       200
fstdetailsname:  $base.fst.snps.txt
#fstz:  YES
numthreads:   $thr
#outlieroutname:         smartpca-fst-eth.outlier
poplistname: $poplist
familynames:     NO
#snpweightoutname:       world-snpwt
#deletesnpoutname:       world-eth-badsnps
#numthreads:     2
fstonly:         YES
""" > par.fst.txt

    smartpca -p par.fst.txt > fst.${base}.txt
    sed '1d' $base.fst.snps.txt | awk '$6>0.05 {print $3}' | sort | uniq > ${base}.fstsnps.txt

    #tail -63 fst.${base}.txt | head -30 | awk '$1=""; {print $0}' > temp1.txt

    ##echo "Pop" > temp2.txt
    #grep -w population fst.${base}.txt | awk '{print $3}' > temp2.txt
    #paste temp1.txt temp2.txt > fstMatrix${base}.txt

    #Rscript fstHeatmap.R fstMatrix${base}.txt

else 
    echo """
	Usage:./run_popgen.sh <pop-list> <threads>
    """
fi
