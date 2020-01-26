#!/bin/bash

samples="../../../samples/"
base="$1"

# ==> par.PED.PACKEDPED <==
echo -e """
genotypename:    ${base}.ped
snpname:         ${base}.map # or example.map, either works
indivname:       ${base}.ped # or example.ped, either works
outputformat:    PACKEDPED
genotypeoutname: ${base}.bed
snpoutname:      ${base}.pedsnp
indivoutname:    ${base}.pedind
#xregionname:	 high-ld-regions.b37
pordercheck:	 YES
strandcheck:	 YES
phasedmode:	 YES
familynames:     NO
#numthreads:	 16
""" > par.PED.PACKEDPED

# ==> par.PACKEDPED.PACKEDANCESTRYMAP <==
echo -e """
genotypename:    ${base}.bed
snpname:         ${base}.pedsnp # or example.map, either works
indivname:       ${base}.pedind # or example.ped, either works
outputformat:    PACKEDANCESTRYMAP
genotypeoutname: ${base}.packedancestrymapgeno
snpoutname:      ${base}.snp
indivoutname:    ${base}.ind
familynames:     NO
phasedmode:      YES
#numthreads:      16
""" > par.PACKEDPED.PACKEDANCESTRYMAP

# ==> par.PACKEDANCESTRYMAP.ANCESTRYMAP <==
echo -e """
genotypename:    ${base}.packedancestrymapgeno
snpname:         ${base}.snp
indivname:       ${base}.ind
outputformat:    ANCESTRYMAP
genotypeoutname: ${base}.ancestrymapgeno
snpoutname:      ${base}.snp
indivoutname:    ${base}.ind
phasedmode:      YES
#numthreads:      16
""" > par.PACKEDANCESTRYMAP.ANCESTRYMAP

# ==> par.ANCESTRYMAP.EIGENSTRAT <==
echo -e """
genotypename:    ${base}.ancestrymapgeno
snpname:         ${base}.snp
indivname:       ${base}.ind
outputformat:    EIGENSTRAT
genotypeoutname: ${base}.eigenstratgeno
snpoutname:      ${base}.snp
indivoutname:    ${base}.ind
phasedmode:      YES
#numthreads:      16
""" > par.ANCESTRYMAP.EIGENSTRAT

