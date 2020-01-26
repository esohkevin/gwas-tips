#!/bin/bash
### Example using the unlinked model on (nearly) unlinked data
## We are showing two different methods here.

###############################################
## First method: defining all parameters via a settings file, and performing the calculations in one go
# This is only recommended for small datasets
#time fs example2a.cp -v -import example2.settings -go
# Takes about 8min 45s on a 2nd gen core i5 laptop (dual core, 4 cores with hyperthreading)
# You can specify the number of cores with e.g. -numthreads 4, but fs will use all of them by default.
# The command has run everything, including 2 independent finestructure runs!

# To examine the output, we will follow the suggested GUI output:
# > finegui -c example2a_unlinked.chunkcounts.out -m example2a_unlinked_mcmc_run0.xml -t example2a_unlinked_tree_run0.xml
# Click File->Open
# Click "Read data file", "Read Pairwise coincidence", "Read Tree"
# Click "Done"
# Click File->Manage Second Dataset
# Change data filename from "run0" to "run1", click "Read data file"
# Change MCMC filename from "run0" to "run1", click "Read Pairwise coincidence"
# Change Tree filename from "run0" to "run1", click "Read Tree"
# Click "Done"
# View->Pairwise coincidence
# Second View->Enable alternative second view
# Second View->Use second dataset
# Second View->Pairwise coincidence
## Now run0 is displayed in the bottom left and run1 in the top right. They should be almost identical

## If you want to access the MCMC traces, they are stored in the file:
# example2a/example2a_linked_x30000_y30000_z60_mcmc.mcmctraces.tab
## The Gelman-Rubin convergence diagnostics are stored in the settings file:
#> grep "mcmcGR" example2a.cp
# mcmcGR:1.12997,1.0143,1.00456,0.999354,1.00513  # Gelman-Rubin diagnostics obtained from combining MCMC runs, for log-posterior, K,log-beta,delta,f respectively



###############################################
## Second method: Using HPC mode, and defining the parameters inline. This achieves an identical result to the previous approach, but allows explorting computation to another machine.
# NOTE: You need gnu "parallel" ("sudo apt-get install parallel" on Ubuntu) to be installed on your system ONLY for this example. In a HPC setup you would replace those lines with calls to qsub_run.sh to submit the jobs to the cluster.
#date > example2b.time
#fs example2b.cp -hpc 1 -idfile Europe.small.ids -phasefiles EuropeSample.small.chrom{1..22}.phase -recombfiles EuropeSample.small.chrom{1..22}.recombfile -s3iters 100000 -s4iters 50000 -s1minsnps 1000 -s1indfrac 0.1 -go
#cat example2b_commandfile1.txt | parallel
#fs example2b.cp -go
#cat example2b_commandfile2.txt | parallel
#fs example2b.cp -go
#cat example2b_commandfile3.txt | parallel
#fs example2b.cp -go
#cat example2b_commandfile4.txt | parallel
#fs example2b.cp -go
#date >> example2b.time
# The output should be identical, to within MCMC tolerance

###############################################
## This is how we might define things in "best practice", i.e. by loading all non-input settings from a file:
# time fs example2c.cp -idfile Europe.small.ids -phasefiles EuropeSample.small.chrom{1..22}.phase -recombfiles EuropeSample.small.chrom{1..22}.recombfile -import example2.settings -go

###############################################
# This is how we can continue previous runs.  We will test the tolerance of the model to deviations in the parameter 'c'.

## First, we don't know what the parameter might be called.
#> fs -h parameters | grep "'c'"
#Help for Parameter cval : 'c' as inferred using chromopainter. This is only used for sanity checking. See s34 args for setting it manually.
#Help for Parameter s34args : Additional arguments to both finestructure mcmc and tree steps. Add "-c <val>" to manually override 'c'.

## Now we've learned that we should set -s34args. But we've already run to stage 4, so we can't do this without rerunning chromopainter. That would be madness... Lets instead duplicate the settings as of the beginning.  How do we do that?
#> fs -h duplicate
#Help for Action    -duplicate <stage> <newfile.cp> : Copy the information from the current settings file, and then -reset it to <stage>.

# What was inferred from the data?
#> grep "cval" example2a.cp 
#cval:0.292178  # 'c' as inferred using chromopainter. This is only used for sanity checking. See s34 args for setting it manually.

## OK, lets rerun with a chosen value of c. 
#fs example2a.cp -duplicate 3 example2a_c1.0.cp -s34args:-c\ 1.0 -go
#fs example2a.cp -duplicate 3 example2a_c2.0.cp -s34args:-c\ 2.0 -go
#fs example2a.cp -duplicate 3 example2a_c0.1.cp -s34args:-c\ 0.1 -go
#fs example2a.cp -duplicate 3 example2a_c0.5.cp -s34args:-c\ 0.5 -go

#You can compare the pairwise coincidences with commands such as 
# finegui -c example2a_linked.chunkcounts.out -m example2a_linked_x30000_y30000_z60_mcmc_run0.xml -t example2a_linked_x30000_y30000_z60_tree_run0.xml -m2 example2a_linked_c1.0_x30000_y30000_z60_mcmc_run1.xml -t2 example2a_linked_c1.0_x30000_y30000_z60_tree_run1.xml &
# which shows that much of the substructure within the Orcadians is not clear at c=1.0 (though two pairs are significantly different to the rest). At c=2.0, the main Orcadian group and Italian group might be merged, even though the two pairs of Orcadians are not yet merged with the rest of them.
# At c=0.1 the Adygei are splitting up
# At c=0.5 looks mostly like c=1.0.
# Looking at the raw copy matrix, the structure claimed by the empirical value of 'c' does appear to be justified, and that claimed by c=0.1 is not clear by eye. 

# Similarly, if you wanted samples from chromopainter then you can rerun stage2 using
#fs example2a.cp -duplicate 2 example2a_samples.cp -s34args:-c\ 1.0 -go


##############################################
## Lets do an UNLINKED analysis
fs=`which fs`

#for chr in {1..22}; do
    time $fs camgwas.cp -v -n -phasefiles chr{1..22}_phasedWref.phase -recombfiles chr{1..22}_phasedWref.recombfile -idfile camgwasPhasedWref.ids -import example2_bestpractice.settings -s34args:"-X -Y" -numthreads 5 -go
#done

# Although the chunkcounts are on a different scale in an unlinked analysis, these SNPs have been thinned and therefore the pairwise coincidence is almost identical (with just a little less evidence of substructure within the Orcadians, but it is the same structure.)


##############################################
## An analysis of the linked data using R
#ln -s ../../FinestructureLibrary.R
#Rscript example2.R ## Take a look at how this works!
