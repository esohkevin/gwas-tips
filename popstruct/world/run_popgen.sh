#!/bin/bash
####################################### EIGEN ANALYSIS #######################################

read -p 'Do you really want to run ./prepWorldPops.sh and ./prepMergedData.sh scripts all over? [y|n]: ' response

if [[ $response == [Yy] ]]; then
   if [[ $# == 0 ]]; then
      echo """Usage: ./run_popgen.sh <maf> 
		Please enter at least one MAF value
		Type e.g. '\$(seq 0.1 0.05 0.5)' for MAF of 0.1-0.5 iteratively
      """
   else
      for maf in $@; do
	#./prepWorldPops.sh
	
	./prepeig.sh $maf

	# Convert File Formats
	cd CONVERTF/
	./run_convertf.sh
	
	cd ../
	
	# Compute Population Genetic Statistics
	cd POPGEN/
	./run_popgenstats.sh $maf
	
	Rscript fstHeatMap.R fstMatrix$maf.txt wfst$maf.png 
	
	#mv *.png ../
	
	cd ../
	
	# Compute PCA
	#cd EIGENSTRAT/
	
	#./run_eigCorrPCA.perl
	
	#cd ../
      done
   fi
elif [[ $response == [Nn] ]]; then

	# Convert File Formats
	cd CONVERTF/
	./run_convertf.sh
	
	cd ../
	
	# Compute Population Genetic Statistics
	cd POPGEN/
	./run_popgenstats.sh
	
	Rscript fstHeatMap.R
	
	mv *.png ../
	
	cd ../
	
	# Compute PCA
#	cd EIGENSTRAT/
	
#	./run_eigCorrPCA.perl
	
#	cd ../

else    echo "Sorry I did not understand your choice!"
	echo "Usage: ./run_popgen 'y' (yes) 'n' (no)"
fi
