#!/usr/bin/Rscript

args <- commandArgs(TRUE)
inlog <- args[1]
outimg <- gsub(".txt",".png",inlog)

cv <- read.table(inlog, header=T, as.is=T)
png(outimg, height=14, width=14, res=100, units="cm", points=12)
plot(cv, xlab="K", ylab="Cross-validation error", pch = 20,  type="b")
dev.off()
