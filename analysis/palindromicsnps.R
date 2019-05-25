#!/usr/bin/env R

# Check installation of qqman and load it if installed
if (!requireNamespace("qqman"))
        install.packages("qqman", repos="http://cloud.r-project.org", ask = F)
library(qqman)

# Extract palindromic SNPs
bim = read.table("qc-camgwas.bim", header=F, as.is=T)
# Get indices of A/T and G/C SNPs
w = which((bim$V5=="A" & bim$V6=="T") | (bim$V5=="T" & bim$V6=="A") | (bim$V5=="A" & bim$V6=="T") | (bim$V5=="A" & bim$V6=="T"))

# Extract A/T and G/C SNPs
at.cg.snps = bim[w,]

# Save A/T and G/C snps into a file at-cg.snps
write.table(at.cg.snps$V2, file="at-cg.snps", row.names=F, col.names=F, quote=F)

