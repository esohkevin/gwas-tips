################## SNP QC ####################
lmiss=read.table("ind-qc-camgwas.lmiss", header = T, as.is = T)
png("snp_qc_missing.png", res = 1200, height = 5, width = 5, units = "in")
par(mfrow=c(1,1))
hist(log10(lmiss$F_MISS), ylab = "Number of SNPs", xlab = "Fraction of missing genotypes", main = "Fraction of missing data")
abline(v=log10(0.04), lty=2) # placing a line at 4% missing data point
dev.off()

# Examining minor allele frequency
freq=read.table("ind-qc-camgwas.frq", header = T, as.is = T)
png("snp_qc_maf.png", res = 1200, height = 5, width = 5, units = "in")
par(mfrow=c(1,1))
hist(freq$MAF, ylab = "Number of SNPs", xlab = "MAF", main = "Minor Allele Frequencies")
# Include lines for 1% (0.01) and 5% (0.05) MAFs 
abline(v=0.01, lty=2, col="red")
#abline(v=0.05, lty=2, col="green")
#legend("topright", "red dashed line: MAF=0.01 (1%)", xjust = 1, yjust = 1, bty = "n")
dev.off()

# Assess differential genotype call rate between cases and controls
diffmiss=read.table("ind-qc-camgwas.missing", header = T, as.is = T)

# save SNPs with missing call rate at p-value < 0.000001 (I'll choose to use 1x10^-8 since its the same genome-wide significance threshold I'll use)
diffmiss=diffmiss[diffmiss$P<0.000001, ]
write.table(diffmiss$SNP, file = "fail-diffmiss.qc", row.names = F, col.names = F, quote = F)


