#!/bin/bash

home="$HOME/Git/GWAS/"

progress_report() {
   for i in {1..22}; do echo -e "chr$i: `ls -lh chr${i}_*.gen.gz | wc -l`"; done; echo "Total: `ls ./*.gen.gz | wc -l`"
}
