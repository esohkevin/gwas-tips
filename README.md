# Pipeline (Workflow)

### Pre-QC Association analysis
 - Model: Logistic (95% confidence interval), 1df Chi square allelic test (adjusted to assess the genomic control inflation factor - λ).
 - Mode of inheritance (MOI): Additive, Recessive, HetHom, Allelic and Genotypic,
 - Tools: PLINK1.9, SNPTEST, R

### Sample (per individual) QC
 - Identification of individuals with discordant sex information.
 - Identification of individuals with high missing values or outlying heterozygosities.
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
 - Tools: Plink1.9, EIGENSOFT, fsStructure, ChromoPainter, GLOBETROTTER, R

### Haplotype Estimation (phasing)
 - SHAPEIT2, Eagle2

### Genotype Imputation
 - IMPUTE2, PBWT, MINIMACH

### Post-Imputation Association analyses
 - Models: Logistic regression, Linear mixed models (LMM)
 - Modes of inheritance: dominant, recessive, heterozygous, additive, allelic
 - Tools: PLINK1.9, SNPTEST2, R

### Follow-up Imputation of putative associations
 - Phasing with IMPUTE2 MCMC approach
 - Imputation with IMPUTE2

### Association analysis
 - Models: Logistic regression, Linear mixed models (LMM)
 - Modes of inheritance (MOI): dominant, recessive, heterozygous, additive, allelic
 - Tools: PLINK1.9, SNPTEST2, R

# License
<a rel="license" href="http://creativecommons.org/licenses/by-nc-sa/4.0/"><img alt="Creative Commons Licence" 
style="border-width:0" src="https://i.creativecommons.org/l/by-nc-sa/4.0/88x31.png" /></a><br />This work is 
licensed under a <a rel="license" href="http://creativecommons.org/licenses/by-nc-sa/4.0/">
Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License</a>.

