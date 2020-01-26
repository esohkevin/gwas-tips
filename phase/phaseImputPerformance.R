#!/usr/bin/Rscript

args <- commandArgs(TRUE)
chrlog <- read.table(args[1], header=T, as.is=T)
print('______________ ', quote=F)
print(args[1], quote=F)
print("Mean", quote=F)
mean(chrlog$PHASE_CONFIDENCE)
print("SD", quote=F)
sdev <- sd(chrlog$PHASE_CONFIDENCE)
sdev
print("SE", quote=F)
me <- 1.644854*(sdev/sqrt(1185))
me
print("Upper 95% CI bound", quote=F)
mean(chrlog$PHASE_CONFIDENCE) + me
print("Lower 95% CI bound", quote=F)
mean(chrlog$PHASE_CONFIDENCE) - me

