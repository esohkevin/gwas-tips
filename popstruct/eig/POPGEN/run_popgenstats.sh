#!/bin/bash

Rscript prepIndFile.R

sed 's/FID/\#FID/g' ../CONVERTF/qc-camgwas-eth.txt > ../CONVERTF/qc-camgwas-eth.ind
sed 's/FID/\#FID/g' ../CONVERTF/qc-camgwas-reg.txt > ../CONVERTF/qc-camgwas-reg.ind
rm ../CONVERTF/qc-camgwas-eth.txt ../CONVERTF/qc-camgwas-reg.txt

smartpca -p par.smartpca-ancmap-eth-fst > par.smartpca-ancmap-eth-fst.log
smartpca -p par.smartpca-ancmap-reg-fst > par.smartpca-ancmap-reg-fst.log
#smartpca -p par.smartpca-fst > smartpca-fst.log
#smartpca -p par.smartpca-pca-grm > smartpca-pca-grm.log
#./../run_twstatsperl
