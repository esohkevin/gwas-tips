#!/bin/bash


touch qc-world-eth2.ind
file="qc-world-eth2.ind"

if [[ -f "${file}" ]]; then
    
  rm ${file};

fi

head -1 qc-world-eth.ind > qc-world-eth2.ind

for popGroup in `cat pop.list`; do

    grep -w ${popGroup} qc-world-eth.ind >> qc-world-eth2.ind

done

echo "Done!"

