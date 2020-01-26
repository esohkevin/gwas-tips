#!/usr/bin/Rscript

args <- commandArgs(TRUE)
roh <- read.table(args[1], header=F, as.is=T)
png(args[2], height=250, width=700, units="px", type="cairo")
plot(roh$V4, roh$V5, type="S")
dev.off()
