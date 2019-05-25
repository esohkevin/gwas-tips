#!/bin/bash

for k in {1..5}; do
    Rscript plotQestimate.R qc-camgwas-ldPruned.${k}.Q qc-camgwas-ldPruned.${k}.png
done

mv *.png ../../images/
