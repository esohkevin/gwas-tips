#!/bin/bash

#analysis="../../../analysis/"
#phase="../../../phase/"

vcf="$2"
outname="$3"
samfile="$4"

if [[ $1 == "sub" ]]; then

    if [[ $1 == "sub" && $# == 4 ]]; then
    
        # Prune the qc-dataset for SNPs within 50bp with r^2 < 0.2 using a window of 5 SNPs
        plink \
            --vcf "${vcf}" \
            --indep-pairwise 5k 5 0.05 \
            --allow-no-sex \
            --hwe 1e-8 \
            --keep ${samfile} \
            --keep-allele-order \
            --autosome \
            --double-id \
            --biallelic-only \
            --out qc-ldPruned
        
        plink \
            --vcf "${vcf}" \
            --extract qc-ldPruned.prune.in \
            --allow-no-sex \
            --autosome \
            --keep ${samfile} \
            --keep-allele-order \
            --make-bed \
            --double-id \
            --out qc-camgwas-ldPruned
        
        plink \
            --bfile qc-camgwas-ldPruned \
            --recode \
            --keep-allele-order \
            --allow-no-sex \
            --double-id \
            --out ${outname}
        
        rm qc-ldPruned* qc-camgwas-ldPruned*
        
        # Convert files into eigensoft compartible formats
        
        ./make_par_files.sh ${outname}
        
        convertf -p par.PED.PACKEDPED
        convertf -p par.PACKEDPED.PACKEDANCESTRYMAP	
        convertf -p par.PACKEDANCESTRYMAP.ANCESTRYMAP
        convertf -p par.ANCESTRYMAP.EIGENSTRAT
    
    else
    	echo """
    	Usage: ./convertf_all.sh sub <in-vcf> <outname> <sample-file>
    
    	"""
    fi


elif [[ $1 == "all" ]]; then

    if [[ $1 == "all" && $# == 3 ]]; then
    
        # Prune the qc-dataset for SNPs within 50bp with r^2 < 0.2 using a window of 5 SNPs
        plink \
            --vcf "${vcf}" \
            --indep-pairwise 5k 5 0.05 \
            --allow-no-sex \
	    --hwe 1e-8 \
            --autosome \
	    --double-id \
    	    --keep-allele-order \
	    --biallelic-only \
	    --out qc-ldPruned
        
        plink \
            --vcf "${vcf}" \
            --extract qc-ldPruned.prune.in \
            --allow-no-sex \
            --autosome \
	    --keep-allele-order \
            --make-bed \
	    --double-id \
            --out qc-camgwas-ldPruned
        
        plink \
       	    --bfile qc-camgwas-ldPruned \
       	    --recode \
       	    --keep-allele-order \
       	    --allow-no-sex \
       	    --double-id \
       	    --out ${outname}
        
        rm qc-ldPruned* qc-camgwas-ldPruned*
        
        # Convert files into eigensoft compartible formats
        
        ./make_par_files.sh ${outname}
        
        convertf -p par.PED.PACKEDPED
        convertf -p par.PACKEDPED.PACKEDANCESTRYMAP	
        convertf -p par.PACKEDANCESTRYMAP.ANCESTRYMAP
        convertf -p par.ANCESTRYMAP.EIGENSTRAT
    
    else
    	echo """
    	Usage: ./convertf_all.sh all <in-vcf> <outname>
    
    	"""
    
    fi

else
	echo """
	Usage: ./convertf_all.sh <[sub|all]>
	
	Please enter 'sub' for subset of samples or 'all' for all samples

	"""
fi

