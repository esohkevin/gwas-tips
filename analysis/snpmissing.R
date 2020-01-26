#!/usr/bin/Rscript

args <- commandArgs(TRUE)

lmis <- args[1]
frq <- args[2]
dmis <- args[3]
oput <- "fail-diffmiss.qc"

######################################### SNP QC ############################################
lmiss=read.table(lmis, header = T, as.is = T)
png(filename = "snp_qc_missing.png", width = 500, height = 500, units = "px", pointsize = 16,
    bg = "white",  res = NA)
par(mfrow=c(1,1))
hist(log10(lmiss$F_MISS), ylab = "Number of SNPs", xlab = "log10(lmiss$F_MISS)", main="")
abline(v=log10(0.04), lty=2) 			# placing a line at 4% missing data point
dev.off()

# Examining minor allele frequency
freq=read.table(frq, header = T, as.is = T)
png(filename = "snp_qc_maf.png", width = 500, height = 500, units = "px", pointsize = 16,
    bg = "white",  res = NA)
par(mfrow=c(1,1))
hist(freq$MAF, ylab = "Number of SNPs", xlab = "MAF", main="")
# Include lines for 1% (0.01) and 5% (0.05) MAFs 
abline(v=0.01, lty=2, col="red")
#abline(v=0.05, lty=2, col="green")
#legend("topright", "red dashed line: MAF=0.01 (1%)", xjust = 1, yjust = 1, bty = "n")
dev.off()

# Assess differential genotype call rate between cases and controls
diffmiss=read.table(dmis, header = T, as.is = T)

# save SNPs with missing call rate at p-value < 0.000001 (I'll choose to use 1x10^-8 since its the same genome-wide significance threshold I'll use)
diffmiss=diffmiss[diffmiss$P<0.000001, ]
write.table(diffmiss$SNP, file = "fail-diffmiss.qc", row.names = F, col.names = F, quote = F)

