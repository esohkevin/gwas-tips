require(ggplot2)
library(qqman)
?manhattan
######## First Association Trend Test ###########
# Load in plink association test result of chr1-22
assoc=read.table("camresults.assoc.logistic", header = T, as.is = T)

# Plot BP position against -log10 p-values (mahattan plot)
# Save the plot (uncomment the png line and run again to save)
png("plinkassoc.png", res = 1200, height = 7, width = 10, units = "in")
par(mfrow=c(1,1))
plot(assoc$BP, -log10(assoc$P), main="-log10 p-values",
     ylab = "-log10 p-values", xlab = "position", pch=16,
     abline(h=8, v=NULL, col="red"))
#legend("topright", "c(x,y)", unique(assoc$CHR), col=1:length(assoc$CHR))
dev.off()

# The -log10(p-values) are too large to be plotted by manhattan
#manhattan(assoc, chr = "CHR", bp = "BP", p = "P", col = c("gray10", "gray60"), chrlabs = NULL, 
#          suggestiveline = -log10(1e-05),  genomewideline = -log10(5e-08), highlight = NULL, logp = T, 
#          annotatePval = NULL, annotateTop = T)

# Plot BP position against log10 Bayes factor (Load snptest result. NB: Plink does not compute Bayes factor)
#plot(assoc$BP, -log10(assoc$), main="-log10 p-values",
#     ylab = "-log10 p-values", xlab = "position", pch=16,
#     abline(h=8, v=NULL, col="green"))

############ Sample QC ######################
# Evaluate missing data rates and outlying heterozygosity rate from plink output files
# Load 'missing' and 'het' files
het=read.table("cam.het.het", header = T, as.is = T)
mis=read.table("cam.mis.imiss", header = T, as.is = T)

# Calculate the observed heterozygosity rate per individual using the formula (N(NM) - O(HOM))
# where N(NM)=number of non-missing genotypes and O(HOM)=number of homozygous genotypes
png("mishet.png", res = 1200, height = 5, width = 5, units = "in")
mishet=data.frame(FID=het$FID, IID=het$IID, het.rate=(het$N.NM. - het$O.HOM.)/het$N.NM., mis.rate=mis$F_MISS)
plot(mishet$het.rate, mishet$mis.rate, xlab = "Heterozygous rate", ylab = "Proportion of missing genotype")
abline(v=c(0.19,0.22), h=0.1, lty=2)
legend("bottomright", legend = "dashed line: y = 0.1, x = 0.195-0.22")
dev.off()

# Save the dataframe created as a table 
write.table(mishet, file = "mishet.txt", sep = "\t", row.names = F, col.names = T, quote = F)

# Extract individuals that will be excluded from further analysis (who didn't pass the filter)
# Individuals with mis.rate > 0.1 (10% missingness)
fail_mis_qc=mishet[mishet$mis.rate > 0.1, ]
write.table(fail_mis_qc, file = "fail_mis_qc.txt", row.names = F, col.names = T, quote = F)
View(fail_mis_qc)

# Individuals with het.rate < 0.19 and individuals with het.rate > 0.22
fail_het_qc=mishet[mishet$het.rate < 0.19 | mishet$het.rate > 0.22, ]
write.table(fail_het_qc, file = "fail_het_qc.txt", row.names = F, col.names = T, quote = F)
View(fail_het_qc)

# Computing IBD to identify duplicate or related individuals
genome=read.table("caseconpruned.genome", header = T, as.is = T)
png("ibd.png", res = 1200, height = 5, width = 5, units = "in")
plot(genome$Z0, genome$Z1, col=1, ylab = "Z1", xlab = "Z0", pch=16)
dev.off()

# Color code IBD plot
par(pch=16)
with(genome, plot(Z0,Z1, xlim = c(0,1), ylim = c(0,1), type = "n"))
with(subset(genome,RT=="FS"), points(Z0,Z1, col=3))
with(subset(genome,RT=="HS"), points(Z0,Z1, col="darkorange"))
with(subset(genome,RT=="OT"), points(Z0,Z1, col=4))
with(subset(genome,RT=="PO"), points(Z0,Z1, col=2))
with(subset(genome,RT=="UN"), points(Z0,Z1, col=1))
with(subset(genome,RT=="OT"), points(Z0,Z1, col=4))
with(subset(genome,RT=="HS"), points(Z0,Z1, col="darkorange"))
legend(1,1, xjust = 1, yjust = 1, legend = levels(genome$RT), pch = 16, col = c(3, "darkorange", 4,2,1))

# Look for pairs with Pi hat > 0.1875 corresponding to half way between second and hird degree relatives
genome=genome[genome$PI_HAT > 0.1875, ]

# Compute mean IBD
mean_ibd=0*genome$Z0 + 1*genome$Z1 + 2*genome$Z2

# Compute the variance of IBD
var.ibd=((0 - mean_ibd)^2*genome$Z0 +
           (1 - mean_ibd)^2*genome$Z1 +
           (2 - mean_ibd)^2*genome$Z2)

# Compute standard error
se.ibd=sqrt(var.ibd)

# Plot mean IBD against SE
png("ibd_se.png", res = 1200, height = 5, width = 5, units = "in")
plot(mean_ibd, se.ibd, xlab = "Mean IBD", ylab = "SE IBD", pch=16, main = "SE IBD of Pairs with Pi HAT > 0.1875")
dev.off()
png("ibd_analysis.png", res=1200, height = 10, width = 10, units = "in")
par(mfrow=c(2,1)) # Set parameters to plot ibd_analysis and ibd_se

# Check duplicates (This is just to visualize details in the data. Our goal remains to remove one individual
# of each pair with Pi HAT > 0.1875. NB: Take a look at the individuals in the original data set. Are you removing
# cases or controls???)
fail_ibd=genome[mean_ibd > 0.1875, ]
write.table(fail_ibd, "ibd_qc.txt", col.names = T, row.names = F, quote = F) # Save the list
duplicate1=genome[mean_ibd == 2, ] # monozygotic twins
duplicate # Result: 0. There are no monozygotic twins although the plot shows gives a close call. These must be duplicates
duplicate2=genome[mean_ibd > 1.98, ] # Equivalent to Z2 > 0.98. Apparently, there were no monozygotic twins but duplicates
duplicate2
write.table(duplicate2, file = "duplicates.txt", col.names = T, row.names = F, quote = F)
sibs=genome[mean_ibd == 1, ]
sibs

# Extract IDs of the duplicate pairs and check in the original data set to see which are cases and which are controls (extract
# separately into 2 files)
fids1=fail_ibd[, 1:2]
fids1
fids2=fail_ibd[, 3:4]
fids2
write.table(fids1, file = "fail_ibd_fids1.txt", col.names = F, row.names = F, quote = F)
write.table(fids2, file = "fail_ibd_fids2.txt", col.names = F, row.names = F, quote = F)
write.table(duplicate2[,1:2], file = "duplicate_ids1.txt", col.names = F, row.names = F, quote = F)
write.table(duplicate2[,3:4], file = "duplicate_ids2.txt", col.names = F, row.names = F, quote = F)


## IBS Analysis - Multidimensional scaling
ibs=as.matrix(read.table("ibsmat.mibs"))
mds=cmdscale(as.dist(1-ibs))
k=c(rep("green",693), rep("blue",778))
plot(mds, pch=20, col=k)

# Remove all individuals failing QC
fail_mis_qc=read.table("fail_mis_qc.txt", header = T, as.is = T)
fail_het_qc=read.table("fail_het_qc.txt", header = T, as.is = T)
fail_ibd_qc=read.table("duplicates.txt", header = T, as.is = T)
View(fail_ibd_qc)

fail_qc=data.frame(FID=c(fail_mis_qc$FID, fail_het_qc$FID, fail_ibd_qc$FID2), 
                   IID=c(fail_mis_qc$IID, fail_het_qc$IID, fail_ibd_qc$IID2))

fail_qc=unique(fail_qc)
fail_qc
View(fail_qc)
write.table(fail_qc, file = "fail_qc.txt", row.names = F, col.names = F, quote = F)

############## SNP QC #####################
# missing data rate
lmiss=read.table("casecon.qc.ind.miss.lmiss", header = T, as.is = T)
png("casecon_qcind_lmiss.png", res = 1200, height = 5, width = 5, units = "in")
par(mfrow=c(1,1))
hist(log10(lmiss$F_MISS), ylab = "Number of SNPs", xlab = "Fraction of missing genotypes", main = "Fraction of missing data")
# placing a line at 4% missing data point
abline(v=log10(0.05), lty=2)
dev.off()

# Examining minor allele frequency
freq=read.table("casecon.qc.ind.freq.frq", header = T, as.is = T)
png("casecon_qcind_freq.png", res = 1200, height = 5, width = 5, units = "in")
par(mfrow=c(1,1))
hist(freq$MAF, ylab = "Number of SNPs", xlab = "MAF", main = "Minor Allele Frequencies")

# Include lines for 1% (0.01) and 5% (0.05) MAFs 
abline(v=0.01, lty=2, col="red")
abline(v=0.05, lty=2, col="green")
legend("topright", "red: MAF=0.01, green: MAF=0.05", xjust = 1, yjust = 1, bty = "n")
dev.off()

# Assess differential genotype call rate between cases and controls
diffmiss=read.table("casecon.qc.ind.call.rate.missing", header = T, as.is = T)

# save SNPs with missing call rate at p-value < 0.000001
diffmiss=diffmiss[diffmiss$P<0.000001, ]
write.table(diffmiss, file = "fail_diffmiss_qc.txt", row.names = F, col.names = F, quote = F)

############# Second Association Trend Test ##############
assoc2=read.table("casecon.qc.logist.assoc.logistic", header = T, as.is = T)
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
png("qq_plots.png", res=1200, height=10, width=6, units="in")
par(mfrow=c(2,1))
qq(assoc$P, main="Q-Q plot before QC")
qq(assoc2$P, main="Q-Q plot after QC")
dev.off()
