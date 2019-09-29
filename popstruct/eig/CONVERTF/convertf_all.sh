#!/bin/bash

#analysis="../../../analysis/"
samples="../../../samples/"

vcf="$2"
outname="$3"
samfile="$4"

if [[ $1 == "sub" ]]; then

    if [[ $1 == "sub" && $# == 6 ]]; then
    
        maf="$5"
	sl="$6"

        # Prune the qc-dataset for SNPs within 50bp with r^2 < 0.2 using a window of 5 SNPs
        plink \
            --vcf "${vcf}" \
            --indep-pairwise 50kb 50 0.1 \
            --allow-no-sex \
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
            --extract $sl \
            --threads 15 \
	    --maf ${maf} \
            --autosome \
            --keep ${samfile} \
            --keep-allele-order \
            --allow-no-sex \
            --double-id \
            --out ${outname}
        
        #rm qc-ldPruned* qc-camgwas-ldPruned*
        
        # Convert files into eigensoft compartible formats
        
        ./make_par_files.sh ${outname}
        
        convertf -p par.PED.PACKEDPED
        convertf -p par.PACKEDPED.PACKEDANCESTRYMAP	
        convertf -p par.PACKEDANCESTRYMAP.ANCESTRYMAP
        convertf -p par.ANCESTRYMAP.EIGENSTRAT

	awk '{print $1}' ${outname}.ind > ${outname}.ids
	grep -f ${outname}.ids ${samples}qc-camgwas_sex_eth.txt > ${outname}-ald.ind
    
    else
    	echo """
    	Usage: ./convertf_all.sh sub <in-vcf> <outname> <sample-file> <maf> <snplist (e.g. .././world/msl.rsids)>
    
    	"""
    fi


elif [[ $1 == "all" ]]; then

    if [[ $1 == "all" && $# == 5 ]]; then
    
        maf="$4"
	sl="$5"
        
        # Prune the qc-dataset for SNPs within 50bp with r^2 < 0.2 using a window of 5 SNPs
        plink \
            --vcf "${vcf}" \
            --indep-pairwise 50k 50 0.1 \
            --allow-no-sex \
            --autosome \
            --extract $sl \
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
            --threads 15 \
            --autosome \
	    --maf ${maf} \
       	    --keep-allele-order \
       	    --allow-no-sex \
       	    --double-id \
       	    --out ${outname}
        
        rm *.nosex qc-ldPruned* qc-camgwas-ldPruned*
        
        # Convert files into eigensoft compartible formats
        
        ./make_par_files.sh ${outname}
        
        convertf -p par.PED.PACKEDPED
        convertf -p par.PACKEDPED.PACKEDANCESTRYMAP	
        convertf -p par.PACKEDANCESTRYMAP.ANCESTRYMAP
        convertf -p par.ANCESTRYMAP.EIGENSTRAT

	awk '{print $1}' ${outname}.ind > ${outname}.ids
	grep -f ${outname}.ids ${samples}qc-camgwas_sex_eth.txt > ${outname}-ald.ind

    else
    	echo """
    	Usage: ./convertf_all.sh all <in-vcf> <outname> <MAF> <snplist (e.g. .././world/msl.rsids) OR ../POPGEN/fstsnps.txt>
    
    	"""
    
    fi

else
	echo """
	Usage: ./convertf_all.sh <[sub|all]>
	
	Please enter 'sub' for subset of samples or 'all' for all samples

	"""
fi

