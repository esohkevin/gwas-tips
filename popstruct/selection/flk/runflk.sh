#!/bin/bash

#hapflk

#--- Whole Genome flk
hapflk --bfile boot/camflk -p flkout/camflk

#for chr in {1..22}; do

#    if [[ -f "flkout/cam-${chr}chr${chr}flk.flk" ]]; then

#        echo -e "\e[38;5;40mflkout/cam-${chr}chr${chr}flk.flk already exists! Skipping!\e[0m"

#    else
        #--- Per chromosome hapflk
#        seq 22 | parallel echo --bfile boot/cam-chr{}flk -K 30 --kinship flkout/camflk_fij.txt --ncpu=15 -p flkout/cam-chr{}flk | xargs -P5 -n9 hapflk

#    fi

#done

Rscript flk.R
