#!/bin/bash

#poplist="$@"
#if [[ $# == 0 ]]; then
#   echo "You must provide at least one .ped + .info file pair!"
#else
#   for pop in $@; do
#       if [[ -f ${pop}.ped && -f ${pop}.info ]]; then
#     
#         java -jar Haploview4.1.jar -n -log logfile.txt -pedfile ${pop}.ped -info ${pop}.info -out ${pop} -chromosome 11 -skipcheck -minMAF 0.05 -hwcutoff 0.00000001 -blockoutput GAB -dprime -png -ldcolorscheme RSQ -pairwiseTagging -compressedpng -track recomFile.txt
#
#       else
#          echo "'${pop}.ped + ${pop}.info' file pair could not be found!"
#       fi
#   done
#fi


# Plot only
if [[ $# == 0 ]]; then
   echo "You must provide at least one .ped + .info file pair!"
else
   for pop in $@; do
       if [[ -f ${pop}.ped && -f ${pop}.info ]]; then

         java -jar Haploview4.1.jar -n -log logfile.txt -pedfile ${pop}.ped -info ${pop}.info -out ${pop} -chromosome 11 -skipcheck -minMAF 0.05 -hwcutoff 0.00000001 -png -ldcolorscheme RSQ -compressedpng -track recomFile.txt

       else
          echo "'${pop}.ped + ${pop}.info' file pair could not be found!"
       fi
   done
fi

