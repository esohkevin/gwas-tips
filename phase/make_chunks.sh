#!/bin/bash

chrSize="252000000 246000000 202000000 194000000 185000000 174000000 163000000 149000000 142000000 136000000 139000000 137000000 118000000 111000000 106000000 92200000 85200000 82200000 60200000 66200000 48200000 52200000"

for size in ${chrSize}; do 

   for interval in `seq 1 2000000 $size`; do 

      echo $(($interval)) >> chr"${size}".tmp1; 
      echo $(($interval-1)) >> chr"${size}".tmp2; 

   done; 

      sed '1d' chr"${size}".tmp2 > chr"${size}".tmp3   

     paste chr"${size}".tmp1 chr"${size}".tmp3 > chr"${size}".tmp4
    
     sed 's/\t/=/g' chr"${size}".tmp4 > chr"${size}".tmp5

     head -n -1 chr"${size}".tmp5 > chr"${size}".txt

   rm *.tmp*

done;

mv chr252000000.txt  chr1intervals.txt
mv chr246000000.txt  chr2intervals.txt
mv chr202000000.txt  chr3intervals.txt
mv chr194000000.txt  chr4intervals.txt
mv chr185000000.txt  chr5intervals.txt
mv chr174000000.txt  chr6intervals.txt
mv chr163000000.txt  chr7intervals.txt
mv chr149000000.txt  chr8intervals.txt
mv chr142000000.txt  chr9intervals.txt
mv chr136000000.txt  chr10intervals.txt
mv chr139000000.txt  chr11intervals.txt
mv chr137000000.txt  chr12intervals.txt
mv chr118000000.txt  chr13intervals.txt
mv chr111000000.txt  chr14intervals.txt
mv chr106000000.txt  chr15intervals.txt
mv chr92200000.txt  chr16intervals.txt
mv chr85200000.txt  chr17intervals.txt 
mv chr82200000.txt  chr18intervals.txt
mv chr60200000.txt  chr19intervals.txt
mv chr66200000.txt  chr20intervals.txt
mv chr48200000.txt  chr21intervals.txt 
mv chr52200000.txt  chr22intervals.txt


