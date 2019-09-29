#!/bin/bash

data="$1"
proga='./helpmsg.sh 1'
progb='./helpmsg.sh 2'
progc='./helpmsg.sh 3'
progd='./helpmsg.sh 4'
proge='./helpmsg.sh 5'
progf='./helpmsg.sh 6'
progg='./helpmsg.sh 7'
progh='./helpmsg.sh 8'
progi='./helpmsg.sh -h'

if [[ $data == "sub" ]]; then

    param="$2"
    
           if [[ "$param" != [123] ]]; then
       
                $proga
       
           else

                if [[ "$param" == "1" && $# != 8 ]]; then
                       
             	     $progb
                   
                elif [[ "$param" == "1" && $# == 8 ]]; then
                 
                       # chromosome region
                       plink2 \
                       	--chr $3 \
                       	--export hapslegend \
			--keep-allele-order \
                       	--vcf $8 \
                       	--out ${6/.*}${7}_chr${3} \
                       	--from-kb $4 \
                       	--to-kb $5 \
                       	--keep $6 \
                       	--double-id
                       
                         # Set awk variables
                         a='$1"\\t"'
                         b="\"$3\""
                         c='"\\t"$2"\\t"$4"\\t"$3'

                         echo "{print `awk -v vara="$a" -v varb="$b" -v varc="$c" 'BEGIN{print vara varb varc}'`}" > awkProgFile.txt

                       sed '1d' ${6/.*}${7}_chr${3}.legend | \
			       awk -f awkProgFile.txt >  ${6/.*}${7}_chr${3}.map
                       sed 's/0/2/g'  ${6/.*}${7}_chr${3}.haps >  ${6/.*}${7}_chr${3}.hap
                    
                elif [[ "$param" == "2" && $# != 5 ]]; then
             
             	       $progc
                   
                elif [[ "$param" == "2" && $# == 5 ]]; then
                 
                       # Entire chromosome
                       plink2 \
                         --chr $3 \
                         --export hapslegend \
                         --vcf $5 \
			 --keep-allele-order \
                         --out ${4/.*}_chr$3 \
                         --keep ${4} \
                         --double-id
                      
                         # Set awk variables
                         a='$1"\\t"'
                         b="\"$3\""
                         c='"\\t"$2"\\t"$4"\\t"$3'

                         echo "{print `awk -v vara="$a" -v varb="$b" -v varc="$c" 'BEGIN{print vara varb varc}'`}" > awkProgFile.txt

                       sed '1d' ${4/.*}_chr${3}.legend | \
			       awk -f awkProgFile.txt > ${4/.*}_chr${3}.map
                       sed 's/0/2/g' ${4/.*}_chr${3}.haps > ${4/.*}_chr${3}.hap
                       
                elif [[ "$param" == "3" && $# != 6 ]]; then
             
             	       $progd   
             
                elif [[ "$param" == "3" && $# == 6 ]]; then
             
                       for chr in $(seq 1 $4); do
                        
                	      # Entire dataset with more than one chromosomes             
                                plink2 \
                                  --export hapslegend \
                                  --vcf $6 \
				  --keep-allele-order \
                                  --chr $chr \
                                  --keep ${5} \
                                  --out $3_chr${chr} \
                                  --double-id
                  
                                # Set awk variables
                                a='$1"\\t"'
                                b="\"$chr\""
                                c='"\\t"$2"\\t"$4"\\t"$3'
                  
                  	      echo "{print `awk -v vara="$a" -v varb="$b" -v varc="$c" 'BEGIN{print vara varb varc}'`}" > awkProgFile.txt
                  
                                sed '1d' ${3}_chr${chr}.legend | \
                                        awk -f awkProgFile.txt > ${3}_chr${chr}.map
                                sed 's/0/2/g' ${3}_chr${chr}.haps > ${3}_chr${chr}.hap
                       done
             
             	       for chr in $(seq 1 $4); do
             
               	           if [[ -f "${3}_chr${chr}.map" ]]; then
               	     
               		       awk '{print $1"\t"$2"\t"$3"\t"$4"\t"$5}' ${3}_chr${chr}.map; 
               	   
               		   fi
                 
             	       done > snp.info
             	   
                fi 
       
                for file in *.log *.sample *.legend *.haps awkProgFile.txt; do
                    if [[ -f ${file} ]]; then
                       rm ${file}
                    fi
                done

                    if [[ -f "snp.info" && ! -s snp.info ]]; then
                          rm snp.info
                    fi
    
           fi

elif [[ $data == "all" ]]; then

    param="$2"

           if [[ "$param" != [123] ]]; then
          
                $proge
       
           else
                if [[ "$param" == "1" && $# != 8 ]]; then
                   
         	  $progf
         	       
                elif [[ "$param" == "1" && $# == 8 ]]; then
         
                        # chromosome region
                        plink2 \
                              --chr $3 \
                              --export hapslegend \
                              --vcf $8 \
			      --keep-allele-order \
                              --out ${6}${7}_chr${3} \
                              --from-kb $4 \
                              --to-kb $5 \
                              --double-id

                         # Set awk variables
                         a='$1"\\t"'
                         b="\"$3\""
                         c='"\\t"$2"\\t"$4"\\t"$3'

                         echo "{print `awk -v vara="$a" -v varb="$b" -v varc="$c" 'BEGIN{print vara varb varc}'`}" > awkProgFile.txt	

                        sed '1d' ${6}${7}_chr${3}.legend | \
				awk -f awkProgFile.txt > ${6}${7}_chr${3}.map
                        sed 's/0/2/g' ${6}${7}_chr${3}.haps > ${6}${7}_chr${3}.hap
          
                elif [[ "$param" == "2" && $# != 5 ]]; then
         
            	       $progg
                   
                elif [[ "$param" == "2" && $# == 5 ]]; then
         
                        # Entire chromosome
                        plink2 \
                          --chr $4 \
                          --export hapslegend \
                          --vcf $5 \
			  --keep-allele-order \
                          --out $3_chr$4 \
                          --double-id
               
                         # Set awk variables
                         a='$1"\\t"'
                         b="\"$4\""
                         c='"\\t"$2"\\t"$4"\\t"$3'

                         echo "{print `awk -v vara="$a" -v varb="$b" -v varc="$c" 'BEGIN{print vara varb varc}'`}" > awkProgFile.txt

                        sed '1d' $3_chr$4.legend | \
				awk -f awkProgFile.txt > $3_chr$4.map
                        sed 's/0/2/g' $3_chr$4.haps > $3_chr$4.hap          
          
                elif [[ "$param" == "3" && $# != 5 ]]; then
         
         	    $progh     
         
                elif [[ "$param" == "3" && $# == 5 ]]; then
         
                   for chr in $(seq 1 $4); do
               	
			 # Entire dataset with more than one chromosomes
                         plink2 \
                           --export hapslegend \
                           --vcf $5 \
               	           --chr $chr \
			   --keep-allele-order \
                           --out $3_chr${chr} \
                           --double-id
               
                 	 # Set awk variables
                 	 a='$1"\\t"'
                 	 b="\"$chr\""	  
                 	 c='"\\t"$2"\\t"$4"\\t"$3'
                 
                 	 echo "{print `awk -v vara="$a" -v varb="$b" -v varc="$c" 'BEGIN{print vara varb varc}'`}" > awkProgFile.txt
               
                         sed '1d' $3_chr${chr}.legend | \
				 awk -f awkProgFile.txt > $3_chr${chr}.map
                         sed 's/0/2/g' $3_chr${chr}.haps > $3_chr${chr}.hap

                   done
       
                   for chr in $(seq 1 $4); do

                       if [[ -f "$3_chr${chr}.map" ]]; then

                          awk '{print $1"\t"$2"\t"$3"\t"$4"\t"$5}' $3_chr${chr}.map

                       fi

                   done > snp.info

                    if [[ -f "snp.info" && ! -s snp.info ]]; then
                         rm snp.info
                    fi       

                fi
         
                    for file in *.log *.sample *.legend *.haps awkProgFile.txt; do
                        if [[ -f ${file} ]]; then
                           rm ${file}
                        fi
                    done
         
           fi

else

	$progi | less
fi
