#!/bin/bash

#analysis="../../../analysis/"
samples="../../../samples/"

vcf="$3"
outname="$2"
samfile="$4"
sl="$5"

if [[ $1 == "sub" ]]; then

    if [[ $1 == "sub" && $# == 2 ]]; then
    
        # Prune the qc-dataset for SNPs within 50bp with r^2 < 0.2 using a window of 5 SNPs
        #plink \
        #    --vcf "${vcf}" \
        #    --indep-pairwise 5k 50 0.2 \
        #    --allow-no-sex \
        #    --keep ${samfile} \
        #    --keep-allele-order \
        #    --autosome \
        #    --double-id \
        #    --biallelic-only \
        #    --out qc-ldPruned
        #
        #plink \
        #    --vcf "${vcf}" \
        #    --extract qc-ldPruned.prune.in \
        #    --allow-no-sex \
        #    --autosome \
        #    --keep ${samfile} \
        #    --keep-allele-order \
        #    --make-bed \
        #    --double-id \
        #    --out qc-camgwas-ldPruned
        #
        plink \
            --vcf ${vcf} \
            --recode \
            --threads 15 \
            --maf 0.05 \
            --extract $sl \
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
    	Usage: ./convertf_all.sh sub <in-vcf> <outname> <sample-file> <snplist (e.g. ../all.snps.txt OR ../POPGEN/afrfstsnps.txt)>
    
    	"""
    fi


elif [[ $1 == "all" ]]; then

    if [[ $1 == "all" && $# == 2 ]]; then
    
        # Prune the qc-dataset for SNPs within 50bp with r^2 < 0.2 using a window of 5 SNPs
        #plink \
        #    --vcf "${vcf}" \
        #    --indep-pairwise 5k 50 0.2 \
        #    --allow-no-sex \
        #    --autosome \
	#    --double-id \
    	#    --keep-allele-order \
	#    --biallelic-only \
	#    --out qc-ldPruned
        #
        #plink \
        #    --vcf "${vcf}" \
        #    --extract qc-ldPruned.prune.in \
        #    --allow-no-sex \
        #    --autosome \
	#    --keep-allele-order \
        #    --make-bed \
	#    --double-id \
        #    --out qc-camgwas-ldPruned
        
       # plink \
       #	    --vcf "${vcf}" \
       #	    --recode \
       #     --threads 15 \
       #     --autosome \
       #     --maf 0.05 \
       #	    --keep-allele-order \
       #	    --allow-no-sex \
       #	    --double-id \
       #	    --out ${outname}
        
       # rm *.nosex #qc-ldPruned* qc-camgwas-ldPruned*
        
        # Convert files into eigensoft compartible formats
        
        ./make_par_files.sh ${outname}
        
        convertf -p par.PED.PACKEDPED
        convertf -p par.PACKEDPED.PACKEDANCESTRYMAP	
        convertf -p par.PACKEDANCESTRYMAP.ANCESTRYMAP
        convertf -p par.ANCESTRYMAP.EIGENSTRAT

	awk '{print $1}' ${outname}.ind > ${outname}.ids
	grep -f ${outname}.ids ../pca_eth_world_pops.txt > ${outname}-ald.ind

    else
    	echo """
    	Usage: ./convertf_all.sh all <pop-prefix>
    
    	"""
    
    fi

else
	echo """
	Usage: ./convertf_all.sh <[sub|all]>
	
	Please enter 'sub' for subset of samples or 'all' for all samples

	"""
fi

