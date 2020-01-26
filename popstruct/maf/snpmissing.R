#!/usr/bin/Rscript

######################################### SNP QC ############################################
args <- commandArgs(TRUE)

# Examining minor allele frequency
freq=read.table(args[1], header = T, as.is = T)
png(args[2], width = 400, height = 400, units = "px", pointsize = 12,
    bg = "white",  res = NA)
par(mfrow=c(1,1))
hist(freq$MAF, ylab = "Number of SNPs", xlab = "MAF", main = "Minor Allele Frequencies")
abline(v=0.01, lty=2, col="red")
dev.off()

