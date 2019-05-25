#!/bin/bash

for i in {1..22}; do echo -e "chr$i: `ls -lh chr${i}_*.gen | wc -l`"; done; echo "Total: `ls *.gen | wc -l`"
