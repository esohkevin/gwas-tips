#!/usr/bin/Rscript

library(rehh)

## Load data set
args <- commandArgs(TRUE)

hap <- data2haplohh(hap_file = args[1], map_file = args[2], recode.allele = F, min_perc_geno.hap=100,min_perc_geno.snp=100, haplotype.in.columns=TRUE, chr.name = 11)

## Compute EHH
png(args[3], height = 700, width = 500, units = "px", type = "cairo")
par(mfrow=c(3,1))
res.ehh <- calc_ehh(hap, mrk = args[4],  ylab="EHH", main = args[4])
res.ehh <- calc_ehh(hap, mrk = args[5],  ylab="EHH", main = args[5])
res.ehh <- calc_ehh(hap, mrk = args[6],  ylab="EHH", main = args[6])
dev.off()

