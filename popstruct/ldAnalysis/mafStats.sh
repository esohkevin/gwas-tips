#!/bin/bash

world="../eig/world/"

# Extract data for YRI, LWK and study data at MAF>0.1 then compute MAF stats
rm yri.ids lwk.ids gbr.ids chb.ids gwd.ids

for pop in yri gwd lwk gbr chb; do 
	
    grep -wi ${pop} ${world}igsr_pops.txt | \
	cut -f1 > ${pop}.txt


    for id in `cat ${pop}.txt`; do 
        echo ${id} ${id} >> ${pop}.ids;
    done

        plink \
            --bfile ${world}worldPops/qc-rsids-world \
            --autosome \
            --keep ${pop}.ids \
            --freq \
	    --allow-no-sex \
            --out ${pop}
done
rm yri.txt lwk.txt gbr.txt

# Get study data allele freqs
 plink \
       --bfile ../../analysis/raw-camgwas \
       --autosome \
       --freq \
       --allow-no-sex \
       --out cam


#### Plot
Rscript mafStats.R
