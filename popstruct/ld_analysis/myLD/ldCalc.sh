## File to calculate LD using VCFtools
## It calculates point estimates for the CP groups
## As well as bootstraps and then calculates LD
## Started 5 November 2015
## Christian Parobek
## Modified by Kevin Esoh for Cameroonian parasites analysis (2019 - 2020)

########################
###### PARAMETERS ######
########################

vcf2use="$1"
#vcf2use=args[1]
s=$2

########################
## CP POINT ESTIMATES ##
########################
if [[ $# != 5 ]]; then
   echo """
   Usage: ldCalc.sh <in-vcf> <maf> <from-chr> <to-chr> <sample-file>
   """
else
   vcf2use="$1"
   maf=$2
   lc=$3
   uc=$4
   s=$5

   mkdir -p ${s/.*/}; dir="${s/.*/}/"
   mkdir -p ${s/.*/}/pointestimates;
   mkdir -p ${s/.*/}/bootstrap; btrp="${s/.*/}/bootstrap/"
   mkdir -p ${s/.*/}/bootstrap/boot; 
   mkdir -p ${s/.*/}/bootstrap/ld
   mkdir -p ${s/.*/}/bootstrap/vcfs
   mkdir -p ${s/.*/}/pointestimates/ld; pts="${s/.*/}/pointestimates/ld/"
   
   ## calculate LD
   seq $lc $uc | parallel echo "--gzvcf $vcf2use --hap-r2 --keep $s --maf $maf --chr {} --ld-window-bp 100000 --out ${pts}chr{}.ld.1-100000" | xargs -P5 -n13 vcftools
   
   ########################
   ####### BOOTSTRAP ######
   ########################
   for strap in {1..100}; do # number of bootstraps to do
	if [[ -f "${btrp}boot/boot$strap.txt" ]]; then
		rm ${btrp}boot/boot$strap.txt
	fi
#	echo -e "\nBootstrap $strap"
#	echo "===================="
   	## sample without replacement
   	## sampling with replacement is impossible with vcftools
   	## pull 17 isolates
   	shuf -n17 $s >> ${btrp}boot/boot$strap.txt
   	## subsample the VCF (--recode \)
#   	vcftools --gzvcf $vcf2use \
#   		--keep ${btrp}boot/boot$strap.txt \
#   		--ld-window-bp 100000 \
#		--maf $maf \
#		--hap-r2 \
#		--out ${btrp}ld/boot$strap.ld.1-100000
   done
   seq 1 100 | parallel echo "--gzvcf $vcf2use --keep ${btrp}boot/boot{}.txt --ld-window-bp 100000 --maf $maf  --hap-r2 --out ${btrp}ld/boot{}.ld.1-100000" | xargs -P5 -n11 vcftools

fi
