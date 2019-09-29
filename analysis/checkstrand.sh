#!/bin/bash

kgp="../phase/1000GP_Phase3/"

perl HRC-1000G-check-bim.pl -b qc-camgwas.bim -f qc-camgwas.frq -r ${kgp}1000GP_Phase3_combined.legend.gz -g -p "AFR"
