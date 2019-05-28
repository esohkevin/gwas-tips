#!/bin/bash


# Examining minor allele frequency
camFreq <- read.table("cam.frq", header = T, as.is = T)
yriFreq <- read.table("yri.frq", header = T, as.is = T)
gwdFreq <- read.table("gwd.frq", header = T, as.is = T)
lwkFreq <- read.table("lwk.frq", header = T, as.is = T)
gbrFreq <- read.table("gbr.frq", header = T, as.is = T)
chbFreq <- read.table("chb.frq", header = T, as.is = T)

png(filename = "worldMAF.png", height = 480, width = 700, units = "px")
par(mfrow=c(2,3))
hist(camFreq$MAF, ylab = "SNPs #", xlab = "MAF", main = "CAM")
abline(v=c(0.01,0.05), lty=2, col=c("red","blue"))
hist(yriFreq$MAF, ylab = "SNPs #", xlab = "MAF", main = "YRI")
abline(v=c(0.01,0.05), lty=2, col=c("red","blue"))
hist(gwdFreq$MAF, ylab = "SNPs #", xlab = "MAF", main = "GWD")
abline(v=c(0.01,0.05), lty=2, col=c("red","blue"))
hist(lwkFreq$MAF, ylab = "SNPs #", xlab = "MAF", main = "LWK")
abline(v=c(0.01,0.05), lty=2, col=c("red","blue"))
hist(gbrFreq$MAF, ylab = "SNPs #", xlab = "MAF", main = "GBR")
abline(v=c(0.01,0.05), lty=2, col=c("red","blue"))
hist(chbFreq$MAF, ylab = "SNPs #", xlab = "MAF", main = "CHB")
abline(v=c(0.01,0.05), lty=2, col=c("red","blue"))
dev.off()

