#!/bin/bash

signal="$1"

if [[ $signal == "1" ]]; then

     echo """
           Usage: ./phased_vcf2rehh.sh 'sub' [1|2|3]

           Enter '1' if you are working with a specific chromosome region (e.g. chr11:5200-5600)
                 '2' if you are working with a single whole chromosome
                 '3' if you are working with a whole genome with more than one chromosomes
          """

elif [[ $signal == "2" ]]; then

     echo """
           Usage: ./phased_vcf2rehh.sh 'sub' 1 <chr#> <from-kb> <to-kb> <sample-file> <gen-reg-name> <input-VCF> 
	   
                          Specific region of a single chromosome
                        -------------------------------------------

			        chr#: The chromosome you wish to work with (e.g. 11 for chromosome 11)
			     from-kb: The start position (in kb: e.g. for 1 for start position at 1000 or 2000 for start position at 2000000)
			       to-kb: The end position (in kb: e.g. for 3 for end position at 3000 or 4000 for end position at 4000000)
  		         sample-file: List of samples to include (e.g. samples.txt), sample IDs, one per line, two colums (tab or space delimited)

			Example (This example is space delimited)
			-------

			 RC0001 RC0001
                         RC0002 RC0002
                         RC0003 RC0003

			gen-reg-name: The genomeric region name
			   input-VCF: The input phased VCF dataset (e.g. data.vcf or data.vcf.gz)
	   		
          """

elif [[ $signal == "3" ]]; then

     echo """
           Usage: ./phased_vcf2rehh.sh 'sub' 2 <chr#> <sample-file> <input-VCF> 
	   
	   		  Working with a whole single chromosome 
			-------------------------------------------
			       chr#: The chromosome you wish to work with (e.g. 11 for chromosome 11)
			sample-file: List of samples to include (e.g. samples.txt)

			Example (This example is space delimited)
                        -------

                         RC0001 RC0001
                         RC0002 RC0002
                         RC0003 RC0003

			  input-VCF: The input phased VCF dataset (e.g. data.vcf or data.vcf.gz)
          """

elif [[ $signal == "4" ]]; then 

     echo """
           Usage: ./phased_vcf2rehh.sh sub 3 <out-file-name> <#chr> <sample-file> <input-VCF> 
               
                        Whole genome with more than one chromosomes
                        -------------------------------------------
                        
                        out-file-name: The output file name prefix (e.g. result)
                                 #chr: The number of chromosomes in the input VCF file
                          sample-file: List of samples to include (e.g. samples.txt), sample IDs, one per line, two colums (tab or space delimited)

                        Example (This example is space delimited)
                        -------

                         RC0001 RC0001
                         RC0002 RC0002
                         RC0003 RC0003

                            input-VCF: The input phased VCF dataset (e.g. data.vcf or data.vcf.gz)
          """

elif [[ $signal == "5" ]]; then

     echo """
          Usage: ./phased_vcf2rehh.sh 'all' [1|2|3] 
	  
	  Enter '1' if you are working with a specific chromosome region (e.g. chr11:5200-5600)
                '2' if you are working with a single whole chromosome
                '3' if you are working with a whole genome with more than one chromosomes
          """

elif [[ $signal == "6" ]]; then

      echo """
          Usage: ./phased_vcf2rehh.sh 'all' 1 <chr#> <from-kb> <to-kb> <outname> <gen-reg-name> <input-VCF>

	  	          Specific region of a single chromosome
                        -------------------------------------------

                                chr#: The chromosome you wish to work with (e.g. 11 for chromosome 11)
                             from-kb: The start position (in kb: e.g. for 1 for start position at 1000 or 2000 for start position at 2000000)
                               to-kb: The end position (in kb: e.g. for 3 for end position at 3000 or 4000 for end position at 4000000)
                             outname: The output file name prefix
                        gen-reg-name: The genomeric region name
                           input-VCF: The input phased VCF dataset (e.g. data.vcf or data.vcf.gz)

           """

elif [[ $signal == "7" ]]; then

      echo """
          Usage: ./phased_vcf2rehh.sh 'all' 2 <outname> <chr#> <input-VCF>

	  		   Working with a whole single chromosome
                        -------------------------------------------

                             outname: The output file name prefix
                                chr#: The chromosome you wish to work with (e.g. 11 for chromosome 11)
                           input-VCF: The input phased VCF dataset (e.g. data.vcf or data.vcf.gz)

           """

elif [[ $signal == "8" ]]; then

      echo """
          Usage: ./phased_vcf2rehh.sh 'all' 3 <outname> <#chr> <input-VCF>
                        
	  		Whole genome with more than one chromosomes
                        -------------------------------------------

                        outname: The output file name prefix
                                 #chr: The number of chromosomes in the input VCF file
                            input-VCF: The input phased VCF dataset (e.g. data.vcf or data.vcf.gz)
          """

elif [[ $signal == "9" ]]; then

      echo """
           Usage: ./phased_vcf2rehh.sh [sub|all]
            
           Enter 'sub' if you are working with a subset of samples (provide base of sample id file e.g. cam for cam.txt - tab or space delimited)

	              Example (This example is space delimited)
                      -------

                         RC0001 RC0001
                         RC0002 RC0002
                         RC0003 RC0003
            
           Enter 'all' if you are working with whole dataset
   
       """

elif [[ $signal == "--help" || $signal == "-h" || $signal == "help" || $signal == "" ]]; then
     echo """
           Usage: ./phased_vcf2rehh.sh [sub|all]
            
           sub: If you are working with a subset of samples
           all: If you are working with whole dataset



	   Working with a subset of samples
	   ================================

           Usage: ./phased_vcf2rehh.sh 'sub' [1|2|3]

           Enter '1' if you are working with a specific chromosome region (e.g. chr11:5200-5600)
                 '2' if you are working with a single whole chromosome
                 '3' if you are working with a whole genome with more than one chromosomes




              Specific region of a single chromosome
           -------------------------------------------

	   Usage: ./phased_vcf2rehh.sh 'sub' 1 <chr#> <from-kb> <to-kb> <sample-file> <gen-reg-name> <input-VCF> 
	   
			        chr#: The chromosome you wish to work with (e.g. 11 for chromosome 11)
			     from-kb: The start position (in kb: e.g. for 1 for start position at 1000 or 2000 for start position at 2000000)
			       to-kb: The end position (in kb: e.g. for 3 for end position at 3000 or 4000 for end position at 4000000)
  		         sample-file: List of samples to include (e.g. samples.txt), sample IDs, one per line, two colums (tab or space delimited)

			Example (This example is space delimited)
			-------

			 RC0001 RC0001
                         RC0002 RC0002
                         RC0003 RC0003

			gen-reg-name: The genomeric region name
			   input-VCF: The input phased VCF dataset (e.g. data.vcf or data.vcf.gz)



              Working with a whole single chromosome
           -------------------------------------------

           Usage: ./phased_vcf2rehh.sh 'sub' 2 <chr#> <sample-file> <input-VCF> 
	   
			       chr#: The chromosome you wish to work with (e.g. 11 for chromosome 11)
			sample-file: List of samples to include (e.g. samples.txt)

			Example (This example is space delimited)
                        -------

                         RC0001 RC0001
                         RC0002 RC0002
                         RC0003 RC0003

			  input-VCF: The input phased VCF dataset (e.g. data.vcf or data.vcf.gz)



           Whole genome with more than one chromosomes
           -------------------------------------------

           Usage: ./phased_vcf2rehh.sh sub 3 <out-file-name> <#chr> <sample-file> <input-VCF> 
               
                        out-file-name: The output file name prefix (e.g. result)
                                 #chr: The number of chromosomes in the input VCF file
                          sample-file: List of samples to include (e.g. samples.txt), sample IDs, one per line, two colums (tab or space delimited)

                        Example (This example is space delimited)
                        -------

                         RC0001 RC0001
                         RC0002 RC0002
                         RC0003 RC0003

                            input-VCF: The input phased VCF dataset (e.g. data.vcf or data.vcf.gz)



           Working with all the samples
           ================================

          Usage: ./phased_vcf2rehh.sh 'all' [1|2|3] 
	  
	  Enter '1' if you are working with a specific chromosome region (e.g. chr11:5200-5600)
                '2' if you are working with a single whole chromosome
                '3' if you are working with a whole genome with more than one chromosomes



              Specific region of a single chromosome
           -------------------------------------------

          Usage: ./phased_vcf2rehh.sh 'all' 1 <chr#> <from-kb> <to-kb> <outname> <gen-reg-name> <input-VCF>

                                chr#: The chromosome you wish to work with (e.g. 11 for chromosome 11)
                             from-kb: The start position (in kb: e.g. for 1 for start position at 1000 or 2000 for start position at 2000000)
                               to-kb: The end position (in kb: e.g. for 3 for end position at 3000 or 4000 for end position at 4000000)
                             outname: The output file name prefix
                        gen-reg-name: The genomeric region name
                           input-VCF: The input phased VCF dataset (e.g. data.vcf or data.vcf.gz)



              Working with a whole single chromosome
           -------------------------------------------

          Usage: ./phased_vcf2rehh.sh 'all' 2 <chr#> <pop-name> <input-VCF>

                                chr#: The chromosome you wish to work with (e.g. 11 for chromosome 11)
                             outname: The output file name prefix
                           input-VCF: The input phased VCF dataset (e.g. data.vcf or data.vcf.gz)



           Whole genome with more than one chromosomes
           -------------------------------------------

          Usage: ./phased_vcf2rehh.sh 'all' 3 <outname> <#chr> <input-VCF>

                        outname: The output file name prefix
                                 #chr: The number of chromosomes in the input VCF file
                            input-VCF: The input phased VCF dataset (e.g. data.vcf or data.vcf.gz)
   
   """
fi
