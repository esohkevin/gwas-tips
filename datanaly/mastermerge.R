library(qqman)
###### Prepare sample files
mysamfile=read.table("casecon.sample", header = T, as.is = T)
oxfordsam=read.table("raw-camgwas-data.sample", header = T, as.is = T)
View(oxfordsam)
View(mysamfile)
View(mysamfile)
oxfsam=data.frame(oxfordsam[,1:3], mysamfile[,5:16])
View(oxfsam)
write.table(oxfsam, file = "raw-camgwas-data.sample", col.names = T, row.names = F, quote = F)

### Check Sex #########
## Extract all individuals flagged with problem
checksex=read.table("raw-camgwas-data.sexprob", header = F, as.is = T)
checksex
write.table(checksex[,1:2], file = "fail-checksex-qc.txt", col.names = F, row.names = F, quote = F)

############ Sample QC ######################
# Evaluate missing data rates and outlying heterozygosity rate from plink output files
# Load 'missing' and 'het' files
het=read.table("raw-camgwas-data.het", header = T, as.is = T)
mis=read.table("raw-camgwas-data.imiss", header = T, as.is = T)

# Calculate the observed heterozygosity rate per individual using the formula (N(NM) - O(HOM))
# where N(NM)=number of non-missing genotypes and O(HOM)=number of homozygous genotypes
mishet=data.frame(FID=het$FID, IID=het$IID, het.rate=(het$N.NM. - het$O.HOM.)/het$N.NM., mis.rate=mis$F_MISS)
png("mishet.png", res = 1200, height = 5, width = 7, units = "in")
par(mfrow=c(1,1))
plot(mishet$het.rate, mishet$mis.rate, xlab = "Heterozygous rate", ylab = "Proportion of missing genotype", pch=20)
abline(v=c(0.195,0.22), h=0.1, lty=2)
legend("bottomright", legend = "dashed line: y = 0.1, x = 0.195-0.22")
dev.off()

# Extract individuals that will be excluded from further analysis (who didn't pass the filter)
# Individuals with mis.rate > 0.1 (10% missingness)
fail_mis_qc=mishet[mishet$mis.rate > 0.1, ]
write.table(fail_mis_qc[,1:2], file = "fail-mis-qc.txt", row.names = F, col.names = F, quote = F)
View(fail_mis_qc)

# Individuals with het.rate < 0.19 and individuals with het.rate > 0.22
fail_het_qc=mishet[mishet$het.rate < 0.195 | mishet$het.rate > 0.22, ]
write.table(fail_het_qc[,1:2], file = "fail-het-qc.txt", row.names = F, col.names = F, quote = F)
View(fail_het_qc)

# IBD Calculation
genome=read.table("caseconpruned.genome", header = T, as.is = T)
genome=genome[genome$PI_HAT > 0.1875, ]
genome
# Compute mean IBD
mean_ibd=0*genome$Z0 + 1*genome$Z1 + 2*genome$Z2

# Compute the variance of IBD
var.ibd=((0 - mean_ibd)^2)*genome$Z0 +
          ((1 - mean_ibd)^2)*genome$Z1 +
           ((2 - mean_ibd)^2)*genome$Z2

# Compute standard error
se.ibd=sqrt(var.ibd)
png("ibd_analysis.png", res=1200, height = 10, width = 10, units = "in")
par(mfrow=c(2,1)) # Set parameters to plot ibd_analysis and ibd_se
plot(mean_ibd, se.ibd, xlab = "Mean IBD", ylab = "SE IBD", pch=20, main = "SE IBD of Pairs with Pi HAT > 0.1875")
plot(genome$Z0, genome$Z1, col=1, ylab = "Z1", xlab = "Z0", pch=20)
dev.off()

duplicate1=genome[mean_ibd == 2, ] # monozygotic twins
duplicate1 # Result: 0. There are no monozygotic twins although the plot shows a close call. These must be duplicates
duplicate2=genome[mean_ibd > 1.98, ] # Equivalent to Z2 > 0.98. Apparently, there were no monozygotic twins but duplicates
duplicate2
write.table(duplicate2, file = "duplicates.txt", col.names = T, row.names = F, quote = F)
sibs=genome[mean_ibd == 1, ]
sibs

# Extract IDs of the duplicate pairs and check in the original data set to see which are cases and which are controls (extract
# separately into 2 files)
write.table(duplicate2[,1:2], file = "duplicate_ids1.txt", col.names = F, row.names = F, quote = F)
write.table(duplicate2[,3:4], file = "duplicate_ids2.txt", col.names = F, row.names = F, quote = F) # Has the higer missingness

######## SNP QC ###############
lmiss=read.table("ind-qc-camgwas-data.lmiss", header = T, as.is = T)
png("ind_qc_camgwas_data_missing.png", res = 1200, height = 5, width = 5, units = "in")
par(mfrow=c(1,1))
hist(log10(lmiss$F_MISS), ylab = "Number of SNPs", xlab = "Fraction of missing genotypes", main = "Fraction of missing data")
# placing a line at 3% missing data point
abline(v=log10(0.03), lty=2)
dev.off()

# Examining minor allele frequency
freq=read.table("ind-qc-camgwas-data.frq", header = T, as.is = T)
png("ind_qc_camgwas_data_freq.png", res = 1200, height = 5, width = 5, units = "in")
par(mfrow=c(1,1))
hist(freq$MAF, ylab = "Number of SNPs", xlab = "MAF", main = "Minor Allele Frequencies")
# Include lines for 1% (0.01) and 5% (0.05) MAFs 
abline(v=0.01, lty=2, col="red")
abline(v=0.05, lty=2, col="green")
legend("topright", "red dashed line: MAF=0.01 (1%)", xjust = 1, yjust = 1, bty = "n")
dev.off()

# Assess differential genotype call rate between cases and controls
diffmiss=read.table("ind-qc-camgwas-data.missing", header = T, as.is = T)
# save SNPs with missing call rate at p-value < 0.000001 (I choose to use 1x10^-8 since its the same genome-wide significance threshold I'll use)
diffmiss=diffmiss[diffmiss$P<0.000001, ]
write.table(diffmiss$SNP, file = "fail-diffmiss-qc.txt", row.names = F, col.names = F, quote = F)

############# Second Association Trend Test ##############
assoc2=read.table("qc-camgwas.assoc.logistic", header = T, as.is = T)
#plot(assoc2$BP, -log10(assoc2$P), xlab = "position", ylab = "-log10 p-value", main = "-log10 p-values (after QC)", 
#     pch=16, col=assoc2$CHR)
#abline(h=7, col="red")
snpsofinterest=assoc2[-log10(assoc2$P)>=7,]
png("plinkassoc_qc.png", res = 1200, height = 7, width = 10, units = "in")
par(mfrow=c(1,1))
manhattan(assoc2, chr = "CHR", bp = "BP", p = "P", col = c("gray10", "gray60"), chrlabs = NULL, 
          suggestiveline = -log10(1e-05),  genomewideline = -log10(5e-08), highlight = NULL, logp = T, 
          annotatePval = NULL, annotateTop = T)
dev.off()
png("qq_plots.png", res=1200, height=5, width=5, units="in")
par(mfrow=c(1,1))
qq(assoc$P, main="Q-Q plot before QC")
qq(assoc2$P, main="Q-Q plot after QC")
dev.off()

## Prepare qc-ed file for snptest
qcsam=read.table("qc-camgwas-data.sample", header = T, as.is = T)
View(qcsam)
qcsex=read.table("qcsex.txt", header = T, as.is = T)
qc_sam=read.table("qc_sam.sample", header = T, as.is = T)
View(qc_sam)
qcsamfile=data.frame(ID_1=qc_sam$ID_2, qc_sam[,2:3], qcsex, qc_sam[,5:15])
qcsamfile
write.table(qcsamfile, file = "qc-camgwas.sample", col.names = T, row.names = F, quote = F)
