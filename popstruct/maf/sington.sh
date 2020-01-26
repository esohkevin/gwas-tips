#!/bin/bash

#awk '$7==1 {print $2"\t"$3"\t"$4"\t"$5"\t"$6}' worldHBB.frq.strat > singletons.txt
for pop in cam yri esn msl gwd lwk; do
    grep -i ${pop} singletons.txt > ${pop}Sington.txt
    cut -f1 ${pop}Sington.txt > ${pop}Sington.id.txt
done

# YRI-only singletons
grep -wv -f gwdSington.id.txt yriSington.id.txt > tmp1.txt
grep -wv -f mslSington.id.txt tmp1.txt > tmp2.txt
grep -wv -f esnSington.id.txt tmp2.txt > tmp3.txt
grep -wv -f lwkSington.id.txt tmp3.txt > yriOnlySington.id.txt

# ESN-only singletons
grep -wv -f gwdSington.id.txt esnSington.id.txt > tmp1.txt
grep -wv -f mslSington.id.txt tmp1.txt > tmp2.txt
grep -wv -f yriSington.id.txt tmp2.txt > tmp3.txt
grep -wv -f lwkSington.id.txt tmp3.txt > yriOnlySington.id.txt

# GWD-only singletons
grep -wv -f yriSington.id.txt gwdSington.id.txt > tmp1.txt
grep -wv -f mslSington.id.txt tmp1.txt > tmp2.txt
grep -wv -f esnSington.id.txt tmp2.txt > tmp3.txt
grep -wv -f lwkSington.id.txt tmp3.txt > gwdOnlySington.id.txt

# MSL-only singletons
grep -wv -f gwdSington.id.txt mslSington.id.txt > tmp1.txt
grep -wv -f yriSington.id.txt tmp1.txt > tmp2.txt
grep -wv -f esnSington.id.txt tmp2.txt > tmp3.txt
grep -wv -f lwkSington.id.txt tmp3.txt > mslOnlySington.id.txt

# LWK-only singletons
grep -wv -f gwdSington.id.txt lwkSington.id.txt > tmp1.txt
grep -wv -f mslSington.id.txt tmp1.txt > tmp2.txt
grep -wv -f esnSington.id.txt tmp2.txt > tmp3.txt
grep -wv -f yriSington.id.txt tmp3.txt > lwkOnlySington.id.txt

rm tmp*

for pop in yri msl gwd lwk; do
    grep -f ${pop}OnlySington.id.txt ../../analysis/updateName.txt | cut -f1 > ${pop}OnlySington.rsid.txt
done

rm *Sington.id.txt
