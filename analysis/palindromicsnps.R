#!/usr/bin/env R

# Extract palindromic SNPs
bim = read.table("qc-camgwas.bim", header=F, as.is=T)
# Get indices of A/T and G/C SNPs
w = which((bim$V5=="A" & bim$V6=="T") | (bim$V5=="T" & bim$V6=="A") | (bim$V5=="G" & bim$V6=="C") | (bim$V5=="C" & bim$V6=="G"))

# Extract A/T and G/C SNPs
at.cg.snps = bim[w,]

# Save A/T and G/C snps into a file at-cg.snps
write.table(at.cg.snps$V2, file="at-cg.snps", row.names=F, col.names=F, quote=F)

