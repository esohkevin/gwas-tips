Population Structure Analysis for CAMGWAS Dataset
---
Workflow
----
- QC
- Eigenstrat outlier removal
- Haplotype estimation (Phasing)
- MAF spectrum
- Fst: Hudson + WC
- LD
- Recombination map - LDHat
- Admixture - admixture, alder, malder
- Structurama/Structure
- fsStructure
- IBD (hmmIBD)/isoRelate
- iHS, EHH, Rsb, XEHH

Design
---
- Get recent ensembl release for human allele frequencies (ftp://ftp.ensembl.org/pub/release-97/variation/vcf/homo_sapiens/)
to ascertain for anc/der allele assignment.
- Extract allele frequencies of variants from QCed dataset
```
vcftools --gzvcf file.vcf.gz --freq --stdout | gzip -c > file.frq.gz
```
Analysis Pipeline
---
#### Quality control on genotype data: Sample and SNP exclusion criteria
- Genotyping rate &lt; 0.04
- Related individuals based on IBD analysis (PI_HAT &gt; 0.1895)
- Individual missing data rate &gt; 0.10
- Individuals with discordant sex information
- Individuals with outlying ancestry based on eigen-analysis

#### Data priming
- Extract allele frequencies for IBD analysis with hmmIBD.
- Haplotype estimation (phasing)
- Modeling of recombination map using ldHat
- Linkage disequilibrium (LD) pattern
- Ascertainment of ancestral alleles using the 1000 Genomes dataset

#### Analysis
*__Minor allele frequency (MAF) Spectrum__*

We would expect an excess of rare alleles which may be due to either population expansion,
selective sweeps (“genetic hitchhiking” ), or incomplete purifying selections.

*__Principal Component Analysis: Select ancestry informative markers (LAPSTRUCT)__*

We would not expected a complete resolution of all the clusters (subpopulations) due to
numerous ancestry uninformative markers. However, if fine-scale structure occurs within the
population, we would expect to already see distinct clusters at this level. This level should
allow us select markers that are most informative regarding ancestry

*__Fst Analysis using ancestry informative markers__*

Population differentiation based on the per-locus statistic Fst is usually a low resolution
method in terms of differentiating sub-populations within the population. However, with the
use of selected ancestry-informative markers, we would expect to start seeing clusters.

*__Further PCA using ancestry informative markers__*

Using the selected ancestry-informative markers, we would expect to see more resolved
clusters or sub-populations.

*__IBD using ancestry informative markers and extracted allele frequencies__*

IBD with ancestry-informative markers should also produce distinct clusters of sub-
populations

*__Structurama: Estimate most likely k (number of substructures or clusters)__*

Furthermore, structurama should be able to predict, with greater accuracy, the number of sub-
populations in the dataset given ancestry-informative markers.

*__Structure: Run with estimated k__*

In addition, we should be able to visualize clearly the distinct clusters using structure fed the k
value from structurama

*__Admixture: Supervised while regressing for ancestry and geography__*

A supervised admixture analysis using the k parameter obtained from structurama while
regressing for ancestry and geography should be able to resolved clusters as well.

*__Whole genome and cross-population scan for selection signals (integrated haplotype
score - iHS-Rsb) with confirmed clusters__*

Following clusters resolution, we would expect to observe at least subtle differences in the
way the genome of each cluster (sub-population) has been shaped for over the years.

*__Tajima’s D test to inform directionality of selection signals__*

While iHS is powerful at scanning for all types of selection signatures, it can produce very little
to no information on the directionality of the signatures. However, Tajima’s D can conveniently
show whether selection is directional, or balancing.

*__FineStructure and Chromosome painting using phased data and recombination map__*

Given haplotypes and ancestry informative markers, we would expect the chromosomes of
each sub-population to be painted differently
