#!/bin/bash

world="../eig/world/"

if [[ $# -lt 5 || $# -gt 5 ]]; then
    echo """    Usage: ./mafStats.sh <chr#> <from-kb> <to-kb> <gene-name> <blocks-min-maf>
                where 'blocks-min-maf' is the value for the minimum MAF you wish to use for haploblock
"""
else

    # Extract data for YRI, LWK and study data at MAF>0.1 then compute MAF stats
#    grep -wi -e cam -e yri -e gwd -e lwk -e ibs -e chb maf-pops.template | awk '{print $1" "$1" "$2}' > camAll.cluster

for pop in yri esn msl gwd lwk; do   
    plink \
	--vcf ../../1000G/Phase3_chr11.vcf.gz \
	--keep ../../samples/${pop}.ids \
	--freq \
	--chr $1 \
	--from-kb $2 \
	--to-kb $3 \
	--out ${pop}
 
done

plink \
        --bfile ../../analysis/raw-camgwas \
        --filter-controls \
        --freq \
	--from-kb $2 \
        --to-kb $3 \
	--chr 11 \
        --out cam

#head -1 cam.frq > all.frq
echo """ CHR           SNP   A1   A2          MAF  NCHROBS	CLST""" > all.frq
sed '1d' cam.frq | awk '{print $0"\t""CAM"}' >> all.frq
sed '1d' yri.frq | awk '{print $0"\t""YRI"}' >> all.frq
sed '1d' esn.frq | awk '{print $0"\t""ESN"}' >> all.frq
sed '1d' msl.frq | awk '{print $0"\t""MSL"}' >> all.frq
sed '1d' gwd.frq | awk '{print $0"\t""GWD"}' >> all.frq
sed '1d' lwk.frq | awk '{print $0"\t""LWK"}' >> all.frq

awk '$5>0 && $5!="NA" && $5>0' all.frq > camall.frq.txt


#    plink \
#        --bfile ../../1000G/Phase3_chr11.vcf.gz \
#    	--chr $1 \
#    	--from-kb $2 \
#    	--to-kb $3 \
#        --freq \
#        --within camAll.cluster \
#        --allow-no-sex \
#        --out all$4
    
#    head -1 all$4.frq.strat > afr$4.frq.strat; grep -wi -e cam -e gwd -e yri -e lwk all$4.frq.strat >> afr$4.frq.strat
    
    #sed 's/:/\t/g' camall.frq.strat > camall.frq.txt
    #sed 's/SNP/IN\tSNP/g' camall.frq.txt > camall.frq.strat
    #rm camall.frq.txt
    #

Rscript mafStats.R
    
#    ./haploblocks.sh $1 $2 $3 $4 $5
fi
