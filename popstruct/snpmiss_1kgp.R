#!/usr/bin/env Rscript

#########################################################################################
#											#
#      Assess the SNP missing data proportion of African populations in 1KGP            #
#											#
#########################################################################################

args <- commandArgs(TRUE)
lmiss <- read.table(args[1], header = T, as.is = T)
png(filename = args[2], width = 520, height = 520, units = "px", pointsize = 12,
    bg = "white",  res = NA)
par(mfrow=c(1,1))
hist(log10(lmiss$F_MISS), ylab = "Number of SNPs", xlab = "Fraction of missing genotypes", 
        main = "Fraction of missing data")
abline(v=log10(0.04), lty=2)                               
dev.off()


