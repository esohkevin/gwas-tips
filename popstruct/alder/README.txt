
        |
        |      ALDER,   v1.03
     \..|./
    \ \  /       Admixture
     \ |/ /      Linkage
      \| /       Disequilibrium for
       |/        Evolutionary
       |         Relationships
       |

     Po-Ru Loh and Mark Lipson
           March 5, 2013



Table of Contents
-----------------
  1. Overview
  2. Installation
  3. Program Flow
  4. Basic Parameters; Input and Output
  5. Full Parameter List
  6. Change Log
  7. License
  8. Contact


==== 1. Overview ====

The ALDER software computes the weighted linkage disequilibrium (LD)
statistic for making inference about population admixture described
in:

  Loh P-R, Lipson M, Patterson N, Moorjani P, Pickrell JK, Reich D,
  and Berger B.  Inferring Admixture Histories of Human Populations
  Using Linkage Disequilibrium.  Genetics, 2013 (in press).
  http://arxiv.org/abs/1211.0251

In its basic form, ALDER takes as input diploid genotype data from a
test population C and two reference populations A and B.  For SNPs x
and y, define:

  w(x) = allele frequency divergence at site x between pops A and B
  D2(x,y) = sample covariance between genotypes at sites x and y in
            pop C (the diploid analog of the usual LD statistic D).

Then ALDER computes the weighted LD statistic:

  D2(x,y)*w(x)*w(y)

averaged over pairs of sites (x,y) at a given distance d.  If the test
population C is derived from an admixture between populations related
to A and B, then the weighted LD statistic exhibits an exponential
decay as a function of d, and parameters of the admixture can be
inferred from the decay constant and amplitude of the curve.  As an
initial step, ALDER can also use the weighted LD statistic to test for
the presence of admixture in the history of population C.

Admixture analysis using weighted LD decay curves was first proposed
by Moorjani et al. (PLoS Genetics, 2011), whose ROLLOFF software
package, described more fully in Patterson et al. (Genetics, 2012),
infers admixture dates from weighted LD curves.  ALDER extends the
general methodology of ROLLOFF, the most notable advances being:

  - a new form of the weighted LD statistic that is more robust and
    makes the amplitude of the weighted LD curve interpretable

  - a variant of the statistic that calculates unbiased weighted LD
    using the test population itself as one reference

  - a statistical test for admixture

  - automatic determination of the minimum genetic distance at which
    to start curve fitting (to avoid confounding signal from
    background LD)

  - calculation of the affine term (i.e., horizontal asymptote of the
    curve) using inter-chromosome SNP pairs

  - a fast Fourier transform (FFT) algorithm for computing weighted LD
    that provides speedup of multiple orders of magnitude.

For more details, please see our paper referenced above.  The
remainder of this README file will focus on use of the ALDER software.


==== 2. Installation ====

The ALDER package is designed for use in Linux environments.  To
compile it, run 'make' in the base directory.  Note that you will need
to have LAPACK, FFTW, and OpenMP installed on your system.

ALDER can be run as follows:

  $PATH_TO_BINARY/alder -p parfile

where $PATH_TO_BINARY is the directory containing the 'alder'
executable, and 'parfile' is a parameter file (format detailed below
in this document).

Note that the source code included in the admixtools_src/ subdirectory
contains minor modifications of I/O routines from Nick Patterson's
ADMIXTOOLS software suite; you may instead link to an existing install
of ADMIXTOOLS if you wish.  For instructions on how to do this, please
see the README.txt file in the admixtools_src/ subdirectory.


==== 3. Program Flow ====

The ALDER program flow splits into three main branches depending on
the number of reference populations provided.  We describe the
2-reference version first, which is the basic application of the
weighted LD statistic.

---- 2-reference weighted LD ----

When given genotype data from a test population C and two reference
populations A and B, ALDER attempts to detect a signal for admixture
in the LD curve of population C weighted by the allele frequency
divergences between A and B.  Importantly, the weighted LD statistic
can exhibit a decay curve owing to LD arising from sources other than
admixture (e.g., a shared population bottleneck in the demographic
history of C and either reference).  To filter out such spurious
signals, ALDER performs the following multi-step procedure:

1. Determine the extent of LD correlation between C and refs A and B.

   Background LD is typically present at short range even in
   non-admixed populations and can have a confounding effect on the
   weighted LD curve.  To reduce this effect, we determine the
   distance to which LD in C is significantly correlated to LD in
   either reference; all further computation will be performed using
   only data from SNP pairs separated by more than this minimum
   distance.  Details are discussed in our manuscript.

2. Compute 2-reference weighted LD for population C using A-B weights.

   The results from this computation comprise the primary data of
   interest for admixture analysis.  ALDER fits the curve as an
   exponential decay plus an affine (constant) term; the latter term
   can arise from heterogeneous mixture and is computed using pairs of
   SNPs from different chromosomes (effectively at infinite genetic
   distance).  The decay rate -- corresponding to the number of
   generations since admixture in the case of admixture -- and the
   amplitude of the curve -- related to mixture proportions and branch
   lengths -- are displayed with standard errors estimated by
   jackknifing on chromosomes.
   
   Note that the reported standard errors should be viewed as
   approximations of uncertainty.  The procedure we use leaves each
   chromosome out in turn and computes the parameter in question on
   the remaining chromosomes; we then apply the jackknife (weighting
   each chromosome equally, ignoring the number of SNPs on each
   chromosome).  Also note that we do not use the jackknife to
   estimate bias: i.e., for any inference of the form "x +/- y", x is
   computed using data from all chromosomes and y is the standard
   error obtained from the jackknife.

3. Compute 1-reference weighted LD using A-C and B-C weights.

   As noted above, the existence of a weighted LD decay curve with A-B
   weights is by itself not enough to conclude that population C is
   admixed.  The remainder of the ALDER procedure consists of a series
   of additional computations to provide further evidence for or
   against admixture.  These checks focus on comparing the 2-reference
   curve from A-B weights with the weighted LD curves obtained using C
   itself as one reference and either population A or B as the other
   reference.  If C is in fact admixed, the weighted LD statistics
   using A-C and B-C weights should still exhibit decay curves.

4. Compare the three weighted LD curves to test for admixture.

   Additionally, if C is actually an admixture of populations related
   to A and B, then the three curves computed with A-B, A-C, and B-C
   weights should all exhibit a statistically significant signal of
   exponential decay and concur in their decay rates (corresponding to
   age of admixture).  Bringing all of this information together,
   ALDER thus applies a pre-test (to decide if A and B are reliable
   reference populations for C) checking that the 1-reference A-C and
   B-C curves exist.  (If the decay curves exist but their decay rates
   are not in concordance with the 2-reference A-B decay rate, ALDER
   prints a warning.)  Note that both of these tests are intended to
   be conservative; failure of either the pre-test or the test can
   happen even if C is admixed, particularly if one reference is very
   closely related to C (in which case the pre-test should prevent use
   of that population for testing admixture) or simply as a result of
   insufficient power.

   If the pre-test passes, ALDER then estimates a p-value for
   admixture using the 2-reference data, computed as follows.
   Standard errors for the fitted amplitude and decay rate are
   estimated by jackknifing over chromosomes.  ALDER then divides each
   mean by its estimated standard error to obtain z-scores for the
   amplitude and decay rate being significantly nonzero.  The final
   p-value is computed from the minimum of the two z-scores under a
   standard normal model.  (In our manuscript, we provide empirical
   evidence that this procedure produces conservative p-values.)

---- 1-reference weighted LD ----

As part of the 2-reference admixture test outlined above, ALDER
computes 1-reference weighted LD curves using weights derived from the
test population itself and one other population.  ALDER will compute
and output this curve directly if the user specifies only one
population in the list of references.  In this case, the program flow
starts as before, determining the extent of correlated LD between the
test population and the reference population, and then computing and
fitting the weighted LD curve.  It is not possible to test for
admixture using only one reference because of the possible sources of
confounding LD; however, the 1-reference computation can still be
useful in situations in which there is external evidence that the test
population is admixed, in which case the 1-reference weighted LD curve
can be used for inferring admixture parameters.

---- 3+ references (multiple admixture tests) ----

ALDER can also test a population for admixture using a suite of
references.  When three or more reference populations are provided,
ALDER effectively runs all possible 2-reference tests using pairs of
references in the suite.  To avoid unnecessary work, the order in
which the steps of the tests are performed is slightly different from
the 2-reference case:

1. Determine the extent of LD correlation between the test population
   and each reference population.  Eliminate reference populations
   exhibiting long-range LD correlation with the test population.

2. Compute 1-reference weighted LD using the test population and each
   reference population (individually).  Eliminate reference
   populations that do not produce a decay curve.

3. For all pairs {A, B} of remaining reference populations, compute
   2-reference weighted LD and compare the 2-reference curve with the
   1-reference curves (using A and B individually) to test for
   admixture as above.

In determining statistical significance of test results, we apply a
multiple-hypothesis correction that takes into account the number of
tests being run.  Because some populations in the reference set may be
very similar, the tests may not be independent, however.  We therefore
compute an effective number of distinct references by running PCA on
the allele frequency matrix of the reference populations; we take the
number of effective references to be the number of singular values
required to account for 90% of the total variance.


==== 4. Basic Parameters; Input and Output ====

ALDER requires genotype data to be provided in EIGENSTRAT format
(.geno, .snp, and .ind files).  Format conversion from several other
common formats can be performed using the CONVERTF program provided
with the EIGENSOFT package.  For more information about the file
format and format conversion, please see the readme for CONVERTF.

All parameters to ALDER are specified in a parameter file, which in
its basic form is simply a text file with one parameter specified per
line in the format:

  parameter_name: value

The simplest invocation of ALDER uses the following parameters:

  genotypename: /path/to/data.geno
  snpname:      /path/to/data.snp
  indivname:    /path/to/data.ind
  admixpop:     testpopC
  refpops:      refpopA;refpopB

ALDER writes diagnostic output, program progress, and results of
weighted LD curve fitting and admixture tests to the command line
(stdout).  You can redirect output to a file using the standard Unix
methods:

  ./alder -p parfile > logfile       (write output to logfile)
  ./alder -p parfile | tee logfile   (display output and write file)

Additionally, if you want to save raw weighted LD curve output, you
can specify a raw output file using the 'raw_outname' parameter.


==== 5. Full Parameter List ====

Input data files:

  genotypename:   'geno' file
  snpname:        'snp' file
  indivname:      'ind' file
  badsnpname:     file containing list of SNP IDs to ignore, one per line
                  (default: use all autosomal SNPs)
  
Admixed population:

  admixpop:       name of test population

Reference populations/weights (specify exactly one):

  refpops:        semicolon-delimited list of reference pop names
  poplistname:    file containing list of ref pop names, one per line
  weightname:     file containing list of weights to use instead of ref pops;
                    each line should contain a SNP ID followed by a weight

Raw weighted LD curve output:

  raw_outname:    file to which to write raw weighted LD data
                  (default: do not write raw output)
  jackknife:      write raw weighted LD data for jackknife reps? (default=NO)
		  if YES, write data to files "raw_outname-chrom_left_out"

Parameter fits corresponding to individual jackknife reps:

  print_jackknife_fits: if YES, print decay and amplitude fits for each
                  jackknife rep on a line following the usual mean +/- std;
                  the last value corresponds to leaving no chromosomes out, so
		  it will match the reported mean 

Output file for IDs of SNPs used:

  snp_outname:    file to which to write IDs of SNPs used
                  (default: do not write output file)

Data filtering:

  mincount:       minimum number of individuals from the test population
                    that must have successful genotype calls at a SNP
		    (i.e., not missing data) for the SNP to be used (default=4)
  chrom:          semicolon-delimited list of chromosomes to use
  nochrom:        semicolon-delimited list of chromosomes to ignore
                  (specify at most 1 of 'chrom' and 'nochrom')

Curve fitting:

  binsize:        genetic distance resolution (in Morgans) at which SNPs are
                    binned for computation and fitting (default=0.0005)
  mindis:         minimum genetic distance (in Morgans) at which to start
                    curve fitting (default: determined using LD correlation)
  maxdis:         maximum genetic distance (in Morgans) at which to stop
                    curve fitting (default=0.5)
  
Input checks:

  fast_snp_read:  skip error-checking of snp file? (default=NO)
  checkmap:       perform basic check on genetic map? (default=YES)

Computational options:

  num_threads:    number of CPUs to use if multithreading available;
                    speedup typically tapers off at 4 (default=1)
  approx_ld_corr: approximate the LD correlation computation for faster
                    performance? (default=YES)
  use_naive_algo: compute weighted LD naively without using FFT? (default=NO)
                    the naive algorithm is much slower but makes better use of
		    SNPs with missing data; this may offer slightly better
                    power, especially for 1-reference weighted LD curves, if
		    significant amounts of data are missing


==== 6. Change Log ====

Version 1.03 (Mar 5, 2013):

- Applied compatibility patch for Mac OS X contributed by Ryan Rauum.
  (Program behavior is identical to v1.02.)

Version 1.02 (Feb 9, 2013):

- Added support for input in "packed geno" format (2 bits/genotype).
- Added option 'print_jackknife_fits' to display decay and amplitude fits
  corresponding to individual jackknife reps.
- Fixed bug causing crash in cases with long-range LD.
- Added check for empty parameters; exit with error message instead of
  crashing.
- Fixed bug in LD correlation check output when parameter
  'approx_ld_corr: NO' is set.
- Fixed bug causing failure to set LD correlation threshold to
  infinity in cases where long-range correlated LD is discovered on a
  pass after the first.

Version 1.01 (Nov 15, 2012):

- Added 'snp_outname' param: filename to which to write IDs of SNPs
  used in the analysis.


==== 7. License ====

This software is licensed for academic and non-profit use only.  The
source code included in the admixtools_src/ subdirectory is derived
from Nick Patterson's ADMIXTOOLS software suite:

  http://genetics.med.harvard.edu/reich/Reich_Lab/Software.html


==== 8. Contact ====

If you have comments or questions about this software, please visit
our website for additional documentation and our contact info:

  http://groups.csail.mit.edu/cb/alder/

Future updates will also be made available at the above link.
