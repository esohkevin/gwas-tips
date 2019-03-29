# MSc Project

## Genome-wide Screening of Candidate Markers Associated with Severe Malaria in Three Malaria-Endemic Regions of Cameroon

## Introduction
Severe *Plasmodium falciparum* malaria is a life-threatening disease that accounts for more than 
90% of malaria deaths world wide. Africans, particular children below the age of 5 are the most 
vulnerable. With increasing antimalarial and insecticide resistance, and no effective vaccine 
against all parasite strains, the disease threatens to escalate. An understanding of the mechanisms 
of disease resistance and susceptibility in humans is crucial to developing new intervention strategies.
Therefore, we seek to look for genetic variants that have not been discovered by previous 
studies in 693 case and 778 control participants from three ethnic groups (Bantu, Semi-bantu and Foulbe) 
and three malaria endemic regions of Cameroon (Center, Littoral and South West regions) that may 
improve understanding of the malaria disease process. Here, we utilize a genome-wide association 
study (GWAS) approach whereby 2.3 millions of single nucleotide polymorphisms (SNPs) genotyped in 
samples from the study participants will be tested for association with severe malaria. A quality 
control procedure will be applied on the genotype dataset using the QCTOOL2, VCFTOOLS, and PLINK1.9 
tools where poor quality samples and SNPs will be excluded. Also, a population stratification analysis 
by multidimensional scaling (MDS) and principal component analysis (PCA) will be performed to identify 
and eliminate all potential confounders and association testing will be performed using PLINK1.9 and 
SNPTEST2 tools with Bonferroni correction for multiple testing. Furthermore, haplotype estimation (phasing) 
and imputation against the 1000 Genomes reference panel (Phase 3) will be performed using SHAPEIT and 
IMPUTE2 respectively and then association of imputed SNPs will be performed with the aforementioned tools.
At the end of the study, we expect to find at least a SNP that is significantly associated with 
severe malaria in the study participants. This would be particularly important in gaining understanding 
into host-parasite interaction which will in turn be crucial in informing development of novel 
intervention strategies.

## Pipeline

### Pre-QC Association analysis
 - Model: Logistic (beta) at 95% confidence interval, 1df Chi square allelic test (adjusted to assess the genomic control inflation factor - λ).
 - Mode of inheritance (MOI): Additive, Allelic
 - Tools: PLINK1.9, R

### Sample (per individual) QC
 - Identification of individuals with discordant sex information.
 - Identification of individuals with discordant sex information.
 - Identification of duplicate or related individuals or individuals of divergent ancestry
 - Tools: QCTOOL, PLINK1.9, R

### SNP (per marker) QC
 - Identification of SNPs with excessive missing genotype
 - Exclusion of rare SNPs (MAF < 1%)
 - Identification of SNPs demonstrating significant deviation from HWE
 - Identification of SNPs with significant differential genotyping call rate between cases and controls
 - Tools: PLINK1.9, R
      
### Population Structure Determination
 - Multidimensional scaling (eliminate population outliers)
 - Principal component analysis with 10 axes of genetic variation (principal components)
 - Fst and Haplotype based fine structure analysis
 - Tools: fsStructure, ChromoPainter, GLOBETROTTER, R

### Haplotype Estimation (phasing)
 - SHAPEIT2

### Genotype Imputation
 - IMPUTE2

### Post-Imputation Association analyses
 - Models: Logistic regression, Linear mixed models (LMM),  1df Chi square
 - Modes of inheritance: dominant, recessive, heterozygous, additive, allelic
 - Tools: PLINK1.9, SNPTEST2, R

### Follow-up Imputation of putative associations
 - Phasing with IMPUTE2 MCMC approach
 - Imputation with IMPUTE2

### Association analysis
 - Models: Logistic regression, Linear mixed models (LMM),  1df Chi square
 - Modes of inheritance (MOI): dominant, recessive, heterozygous, additive, allelic
 - Tools: PLINK1.9, SNPTEST2, R

# License
<a rel="license" href="http://creativecommons.org/licenses/by-nc-sa/4.0/"><img alt="Creative Commons Licence" 
style="border-width:0" src="https://i.creativecommons.org/l/by-nc-sa/4.0/88x31.png" /></a><br />This work is 
licensed under a <a rel="license" href="http://creativecommons.org/licenses/by-nc-sa/4.0/">
Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License</a>.

