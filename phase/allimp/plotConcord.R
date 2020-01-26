#!/usr/bin/env Rscript

require(qqman)
require(data.table)

args <- commandArgs(TRUE)

cf <- args[1]
sf <- args[2]

dname <- basename(getwd())
ocp <- paste0(dname,"_man_", gsub(".txt",".png",cf))
ocp2 <- paste0(dname,"_plot_", gsub(".txt",".png",cf))
ocp3 <- paste0(dname,"_plot_", gsub(".txt",".png",sf))

f <- fread(cf, h=T, nThread=30, data.table=F)
colnames(f) <- c("CHR","SNP","BP","a0","a1","exp_freq_a1","info","certainty","type", "info_type0", "P", "r2_type0")

s <- fread(sf, h=T, data.table=F)

attach(f)

png(ocp, height=450, width=750, points=10, units='px', res=NA)
manhattan(f, logp=F, genomewideline = 0.75)
dev.off()

png(ocp2, height=450, width=420, points=10, units='px', res=NA)
plot(P, info_type0, pch=20, xlab="concord_type0", ylab="info_type0", main="Imputation Performance")
abline(v=0.60, h=0.60, lty=2)
dev.off()
detach(f)

attach(s)
png(ocp3, height=450, width=420, points=10, units='px', res=NA)
plot(concord_type0, r2_type0, pch=20, xlab="concord_type0", ylab="info_type0", main="Imputation Performance")
abline(v=0.60, h=0.60, lty=2)
dev.off()

