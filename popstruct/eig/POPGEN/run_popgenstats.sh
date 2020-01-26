#!/bin/bash

if [[ $# == 2 ]]; then

   base="$1"
   thr="$2"

   #Rscript prepIndFile.R $base
   
   #sed 's/FID/\#FID/g' ../CONVERTF/${base}-eth.txt > ../CONVERTF/${base}-eth.ind
   #sed 's/FID/\#FID/g' ../CONVERTF/${base}-reg.txt > ../CONVERTF/qc-camgwas-reg.ind
   #rm ../CONVERTF/${base}-eth.txt #../CONVERTF/qc-camgwas-reg.txt
   
   echo """
   genotypename:    ../CONVERTF/${base}.ancestrymapgeno
   snpname:         ../CONVERTF/${base}.snp
   indivname:       ../CONVERTF/${base}-ald.ind
   evecoutname:     ${base}-eth.evec
   evaloutname:     ${base}-eth.eval
   altnormstyle:    NO
   outlieroutname:  ${base}.outlier
   familynames:     NO
   snpweightoutname:      ${base}-snpwt
   deletesnpoutname:       ${base}-eth-badsnps
   numthreads:      $thr
   fstdetailsname:  mybig.out
   fstz:  YES
   ldregress:       200
   phylipoutname:   ${base}.phy
   fstonly:         YES
   """ > par.smartpca-ancmap-eth-fst
   
   
   echo "smartpca -p par.smartpca-ancmap-eth-fst > fst-eth.txt"
   smartpca -p par.smartpca-ancmap-eth-fst > ${base}-fst.txt

   sed '1d' mybig.out | awk '$6>0.001 {print $3}' | sort | uniq > fstsnps.txt
   
   #smartpca -p par.smartpca-ancmap-reg-fst > par.smartpca-ancmap-reg-fst.log
   #smartpca -p par.smartpca-fst > smartpca-fst.log
   #smartpca -p par.smartpca-pca-grm > smartpca-pca-grm.log
   #./../run_twstatsperl

else 
   echo """
	Usage:./run_popgen.sh <ancestrymapgeno-root> <threads>
   """
fi
