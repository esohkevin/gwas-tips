#!/bin/bash
####################################### EIGEN ANALYSIS #######################################

if [[ $# == 3 ]]; then

	# Convert File Formats
	cd CONVERTF/
	./run_convertf.sh $1 $2 $3
	
	cd ../
	
	# Compute Eigenvectors
	cd EIGENSTRAT/
	./run_eigenstrat.perl $2
	
#	cut -f4 -d' ' ${2}.pca.evec | sed '1d' > eig.id1
#	cut -f4 -d' ' ${2}.pca.evec | sed '1d' > eig.id2
#	paste eig.id1 eig.id2 > eig.ids
#	rm eig.id1 eig.id2
	
	cd ../
	
	# Compute Population Genetic Statistics
	cd POPGEN/
	./run_popgenstats.sh $2
	
	cd ../
	
	# Compute PCA with dataset without outliers
#	cd CONVERTF/
#	./run_eig-convertf.sh
	
	cd ../EIGENSTRAT/
	./run_eigCorrPCA.perl
	
	echo -e "\nAll Processes Done Running!\n"

else 
	echo """
	Usage: ./run_eigstruct.sh <in-vcf> <out-name> <keep-samples>
	"""
fi
