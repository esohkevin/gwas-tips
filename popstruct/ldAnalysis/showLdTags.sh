#!/bin/bash

for pop in cam gwd lwk yri gbr chb; do
    plink \
	--bfile ${pop} \
	--show-tags ${pop}Tag.txt \
	--list-all \
	--tag-r2 0.5 \
	--tag-kb 1000 \
	--out ${pop}
done
