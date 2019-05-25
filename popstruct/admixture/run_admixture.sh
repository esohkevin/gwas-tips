#!/bin/bash


# Perform admixture cross-validation to determine the appropriate k value to use
for k in $(seq 1 5); do
	admixture --cv adm-data.bed "${k}" -B -j15 | tee log${k}.out;
done

#./plotQestimate.sh

