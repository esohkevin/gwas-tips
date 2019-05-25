
####################################### EIGEN ANALYSIS #######################################
# Convert File Formats
#cd CONVERTF/
#./run_convertf.sh

#cd ../

# Compute Eigenvectors
cd EIGENSTRAT/
./run_eigenstrat.perl

cut -f4 -d' ' qc-camgwas.pca.evec | sed '1d' > eig.id1
cut -f4 -d' ' qc-camgwas.pca.evec | sed '1d' > eig.id2
paste eig.id1 eig.id2 > eig.ids
rm eig.id1 eig.id2

cd ../

# Compute Population Genetic Statistics
cd POPGEN/
./run_popgenstats.sh

cd ../

# Compute PCA with dataset without outliers
cd CONVERTF/
./run_eig-convertf.sh

cd ../EIGENSTRAT/
./run_eigCorrPCA.perl

echo -e "\nAll Processes Done Running!\n"

