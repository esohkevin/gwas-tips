library(qqman)
############################ Cameroon GWAS Data Analysis ##############################
############################### Prepare Sample File ###################################
oldsam=read.table("raw-camgwas-data.sample", header = T, as.is = T)
newsam=read.table("raw-camgwas.sample", header = T, as.is = T)
View(oldsam)
View(newsam)

# change sample file name for sample file accompanying .gen file
write.table(newsam, file = "camgwas_template.sample", col.names = T, row.names = F, quote = F) 

# Now create new sample file with same name as .gen file  (for plink input)
newcamsam=data.frame(newsam[,1:3], oldsam[,4:15])
View(newcamsam)
write.table(newcamsam, file = "raw-camgwas.sample", col.names = T, row.names = F, quote = F)

# Now create new sample file for snptest input
#samsex=read.table("gwas.sample", header = T, as.is = T)
#snptestsamFile=data.frame(ID_1=oldsam$ID_2, ID_2=oldsam$ID_2, missing=newcamsam$missing, sex=samsex$sex, newcamsam[,5:15])
#View(snptestsamFile)
#write.table(snptestsamFile, file = "snptest.sample", col.names = T, row.names = F, quote = F)

############ Extract IDs of individuals that failed sex check from the .sexcheck file ##############
sexcheck=read.table("fail-checksex.qc", header = F, as.is = T)
write.table(sexcheck[,1:2], file = "fail-checksex.qc", col.names = F, row.names = F, quote = F, sep = "\t")

############ PER INDIVIDUAL QC ######################
### Plot Heterozygosity vs Missingness
het=read.table("raw-camgwas.het", header = T, as.is = T)
mis=read.table("raw-camgwas.imiss", header = T, as.is = T)
# save the file reformatted
write.table(het, file = "raw-camgwas.het", col.names = T, row.names = F, quote = F, sep = "\t")
write.table(mis, file = "raw-camgwas.imiss", col.names = T, row.names = F, quote = F, sep = "\t")

# Calculate the observed heterozygosity rate per individual by (N(NM) - O(HOM)/N(NM))
mishet=data.frame(FID=het$FID, IID=het$IID, het.rate=(het$N.NM. - het$O.HOM.)/het$N.NM., mis.rate=mis$F_MISS)
#meanhet=mean(mishet$het.rate)
#sdhet=sd(mishet$het.rate, na.rm = F)
#hetupper=meanhet + sdhet*3
#hetlower=meanhet - sdhet*3

# Plot the proportion of missing genotypes and the heterozygosity rate
png("mishet.png", res = 1200, height = 5, width = 7, units = "in")
par(mfrow=c(1,1))
plot(mishet$het.rate, mishet$mis.rate, xlab = "Heterozygous rate", ylab = "Proportion of missing genotype", pch=20)
#abline(v=c(hetlower, hetupper), h=0.1, lty=2)
abline(v=c(0.18,0.23), h=0.1, lty=2)
legend("bottomright", legend = "dashed line: y = 0.1, x = 0.195-0.22")
dev.off()

# Extract individuals that will be excluded from further analysis (who didn't pass the filter)
# Individuals with mis.rate > 0.1 (10% missingness)
fail_mis_qc=mishet[mishet$mis.rate > 0.1, ]
write.table(fail_mis_qc[,1:2], file = "fail-mis-qc.txt", row.names = F, col.names = F, quote = F, sep = "\t")
fail_mis_qc

# Individuals with het.rate < 0.18 (previously 0.195) and individuals with het.rate > o.23 (previously 0.22)
fail_het_qc=mishet[mishet$het.rate < 0.18 | mishet$het.rate > 0.23, ]
write.table(fail_het_qc[,1:2], file = "fail-het.qc", row.names = F, col.names = F, quote = F, sep = "\t")
fail_het_qc

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
dev.off()
# Extract IDs of the duplicate pairs and check in the original data set to see which have a lower call rate)
write.table(duplicate2[,1:2], file = "duplicate_ids1.txt", col.names = F, row.names = F, quote = F, sep = "\t")
write.table(duplicate2[,3:4], file = "duplicate_ids2.txt", col.names = F, row.names = F, quote = F, sep = "\t") # Has the higer missingness

######## SNP QC ###############
lmiss=read.table("ind-qc-camgwas.lmiss", header = T, as.is = T)
png("ind_qc_camgwas_data_missing.png", res = 1200, height = 5, width = 5, units = "in")
par(mfrow=c(1,1))
hist(log10(lmiss$F_MISS), ylab = "Number of SNPs", xlab = "Fraction of missing genotypes", main = "Fraction of missing data")
# placing a line at 4% missing data point
abline(v=log10(0.04), lty=2)
dev.off()

# Examining minor allele frequency
freq=read.table("ind-qc-camgwas.frq", header = T, as.is = T)
png("ind_qc_camgwas_data_freq.png", res = 1200, height = 5, width = 5, units = "in")
par(mfrow=c(1,1))
hist(freq$MAF, ylab = "Number of SNPs", xlab = "MAF", main = "Minor Allele Frequencies")
# Include lines for 1% (0.01) and 5% (0.05) MAFs 
abline(v=0.01, lty=2, col="red")
abline(v=0.05, lty=2, col="green")
legend("topright", "red dashed line: MAF=0.01 (1%)", xjust = 1, yjust = 1, bty = "n")
dev.off()

# Assess differential genotype call rate between cases and controls
diffmiss=read.table("ind-qc-camgwas.missing", header = T, as.is = T)
# save SNPs with missing call rate at p-value < 0.000001 (I'll choose to use 1x10^-8 since its the same genome-wide significance threshold I'll use)
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
