#!/bin/bash

if [[ $# == 6 ]]; then

    #------- Set parameter variables
    base="$1"
    k="$2"
    m="$3"
    t="$4"
    s="$5"
    th="$6"
    
    #------- Create parameter files
    echo """
    genotypename: ../CONVERTF/${base}.eigenstratgeno
    snpname: ../CONVERTF/${base}.snp
    indivname: ../CONVERTF/${base}.ind
    evecoutname: ${base}.pca.evec
    evaloutname: ${base}.eval
    altnormstyle: NO
    numoutevec: ${k}
    numoutlieriter: ${m}
    numoutlierevec: ${t}
    outliersigmathresh: ${s}
    qtmode: 0
    xregionname: high-ld-regions.b37
    #lsqproject: YES
    outlieroutname: ${base}.outlier
    familynames: NO
    #snpweightoutname: ${base}-snpwt
    #deletesnpoutname: ${base}-eth-badsnps
    numthreads: ${th}
    #ldregress: 200
    phylipoutname: ${base}.phy
    """ > ${base}.pca.par
    
    #echo """
    #genotypename:  ../CONVERTF/${base}.eigenstratgeno
    #snpname:       ../CONVERTF/${base}.snp
    #indivname:     ../CONVERTF/${base}.ind
    #pcaname:       ${base}.pca
    #outputname:    ${base}.chisq
    #numpc:         ${k}
    #qtmode:        NO
    #""" > ${base}.chisq.par
    
    
    #------- Run the jobs
    echo "smartpca -p ${base}.pca.par >${base}-pca.log"
          smartpca -p ${base}.pca.par >${base}-pca.log
    
    #echo "smarteigenstrat -p ${base}.chisq.par >${base}.chisq.log"
    #      smarteigenstrat -p ${base}.chisq.par >${base}.chisq.log
    #
    #echo "gc.perl $base.chisq $base.chisq.GC"
    #      gc.perl $base.chisq $base.chisq.GC

else 
    echo """
	Usage: ./run_eingenstrat.sh <input_prefix> <k_param> <m_param> <t_param> <s_param> <threads>
    """
fi

