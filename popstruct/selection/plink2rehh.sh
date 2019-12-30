#!/bin/bash

data="$1"

if [[ $data == "sub" ]]; then

    param="$2"
    
    if [[ "$param" != [123] ]]; then
       
       echo """
    	Usage: ./plink2rehh.sh sub [1|2|3] : Enter '1' if you are working with a specific chromosome region (e.g. chr11:5200-5600)
    					           '2' if you are working with a single whole chromosome
    					       	   '3' if you are working with a whole genome with more than one chromosomes
       """
    else
       if [[ "$param" == "1" && $# != 8 ]]; then
          echo """
          	Usage: ./plink2rehh.sh sub 1 <chr#> <from-kb> <to-kb> <sample-file-name> <genomic-region-name> <input-VCF> (for specific chromosome region)
          """
       elif [[ "$param" == "1" && $# == 8 ]]; then
    
          # chromosome region
          plink2 \
          	--chr $3 \
          	--export hapslegend \
          	--vcf $8 \
          	--out chr${3}${6}${7} \
          	--from-kb $4 \
          	--to-kb $5 \
          	--keep $6.txt \
          	--double-id
          
          sed '1d' chr${3}${6}${7}.legend | awk '{print $1"\t""11""\t"$2"\t"$4"\t"$3}' > chr${3}${6}${7}.map
          sed 's/0/2/g' chr${3}${6}${7}.haps > chr${3}${6}${7}.hap
       
       elif [[ "$param" == "2" && $# != 5 ]]; then
          echo """
               Usage: ./plink2rehh.sh sub 2 <chr#> <sample-file-name> <input-VCF> (for single whole chromosome)
          """
      
       elif [[ "$param" == "2" && $# == 5 ]]; then
    
          # Entire chromosome
          plink2 \
            --chr $3 \
            --export hapslegend \
            --vcf $5 \
            --out chr$3$4 \
            --keep $4.txt \
            --double-id
         
          sed '1d' chr${3}${4}.legend | awk '{print $1"\t""11""\t"$2"\t"$4"\t"$3}' > chr${3}${4}.map
          sed 's/0/2/g' chr${3}${4}.haps > chr${3}${4}.hap
          
       elif [[ "$param" == "3" && $# != 6 ]]; then
            echo """
               Usage: ./plink2rehh.sh sub 3 <out-file-name> <#chr> <sample-file> <input-VCF> (whole genome with more than one chromosomes)
                        
                        out-file-name: The output file name prefix
                                 #chr: The number of chromosomes in the input VCF file
				 sample-file: List of subsamples to include
                            input-VCF: The input phased VCF dataset (e.g. data.vcf or data.vcf.gz)
          """
       elif [[ "$param" == "3" && $# == 6 ]]; then

            for chr in `(seq 1 $4)`; do
           
	      # Entire dataset with more than one chromosomes

              plink2 \
                --export hapslegend \
                --vcf $6 \
                --chr $chr \
                --keep $5 \
                --out $3${chr} \
                --double-id

              # Set awk variables

              a='$1"\\t"'
              b="\"$chr\""
              c='"\\t"$2"\\t"$4"\\t"$3'

	      echo "{print `awk -v vara="$a" -v varb="$b" -v varc="$c" 'BEGIN{print vara varb varc}'`}" > awkProgFile.txt

              sed '1d' ${3}${chr}.legend | \
                      awk -f awkProgFile.txt > ${3}${chr}.map
              sed 's/0/2/g' ${3}${chr}.haps > ${3}${chr}.hap
            done

	       for chr in `(seq 1 $4)`; do

	           if [[ -f "${3}${chr}.map" ]]; then
	     
		       awk '{print $1"\t"$2"\t"$3"\t"$4"\t"$5}' ${3}${chr}.map; 
	   
		   fi
    
	       done > snp.info
	   
       fi 

       for file in *.log *.sample *.legend *.haps awkProgFile.txt; do
           if [[ -f ${file} ]]; then
             rm ${file}
           fi
       done

      
    fi

elif [[ $data == "all" ]]; then

    param="$2"

    if [[ "$param" != [123] ]]; then
   
       echo """
        Usage: ./plink2rehh.sh all [1|2|3] : Enter '1' if you are working with a specific chromosome region (e.g. chr11:5200-5600)
                                                   '2' if you are working with a single whole chromosome
                                                   '3' if you are working with a whole genome with more than one chromosomes
       """
    else
       if [[ "$param" == "1" && $# != 8 ]]; then
          echo """
                Usage: ./plink2rehh.sh all 1 <chr#> <from-kb> <to-kb> <sample-file-name> <genomic-region-name> <input-VCF> (for specific chromosome region)
          """
       elif [[ "$param" == "1" && $# == 8 ]]; then

          # chromosome region
          plink2 \
                --chr $3 \
                --export hapslegend \
                --vcf $8 \
                --out chr${3}${6}${7} \
                --from-kb $4 \
                --to-kb $5 \
                --double-id
 
          sed '1d' chr${3}${6}${7}.legend | awk '{print $1"\t""11""\t"$2"\t"$4"\t"$3}' > chr${3}${6}${7}.map
          sed 's/0/2/g' chr${3}${6}${7}.haps > chr${3}${6}${7}.hap
 
       elif [[ "$param" == "2" && $# != 5 ]]; then
          echo """
               Usage: ./plink2rehh.sh all 2 <chr#> <sample-file-name> <input-VCF> (for single whole chromosome)
          """
 
       elif [[ "$param" == "2" && $# == 5 ]]; then

          # Entire chromosome
          plink2 \
            --chr $3 \
            --export hapslegend \
            --vcf $5 \
            --out chr$3$4 \
            --double-id
 
          sed '1d' chr${3}${4}.legend | awk '{print $1"\t""11""\t"$2"\t"$4"\t"$3}' > chr${3}${4}.map
          sed 's/0/2/g' chr${3}${4}.haps > chr${3}${4}.hap
 
 
       elif [[ "$param" == "3" && $# != 5 ]]; then
          echo """
               Usage: ./plink2rehh.sh all 3 <out-file-name> <#chr> <input-VCF> (whole genome with more than one chromosomes)
	       		
	       		out-file-name: The output file name prefix
	       		         #chr: The number of chromosomes in the input VCF file
			    input-VCF: The input phased VCF dataset (e.g. data.vcf or data.vcf.gz)
          """
       elif [[ "$param" == "3" && $# == 5 ]]; then

       for chr in `(seq 1 $4)`; do
	# Entire dataset with more than one chromosomes
          plink2 \
            --export hapslegend \
            --vcf $5 \
	    --chr $chr \
            --out $3${chr} \
            --double-id

	  # Set awk variables
	  a='$1"\\t"'
	  b="\"$chr\""	  
	  c='"\\t"$2"\\t"$4"\\t"$3'

	  echo "{print `awk -v vara="$a" -v varb="$b" -v varc="$c" 'BEGIN{print vara varb varc}'`}" > awkProgFile.txt

          sed '1d' ${3}${chr}.legend | \
		  awk -f awkProgFile.txt > ${3}${chr}.map
          sed 's/0/2/g' ${3}${chr}.haps > ${3}${chr}.hap

       done

       fi

       for file in *.log *.sample *.legend *.haps awkProgFile.txt; do
           if [[ -f ${file} ]]; then
             rm ${file}
           fi
       done

          for chr in `(seq 1 $4)`; do

              if [[ -f "${3}${chr}.map" ]]; then

               awk '{print $1"\t"$2"\t"$3"\t"$4"\t"$5}' ${3}${chr}.map

	      fi
	   
          done > snp.info

    fi

else
    echo """
            Usage: ./plink2rehh.sh [sub|all]
            
            Enter 'sub' if you are working with a subset of samples (provide base of sample id file e.g. cam for cam.txt - tab or space delimited)
                         e.g. sample id file
    
                         RC0001 RC0001
                         RC0002 RC0002
                         RC0003 RC0003
            
            Enter 'all' if you are working with whole dataset
    
       """
fi
