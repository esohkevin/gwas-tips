#!/usr/bin/Rscript

setwd("~/esohdata/GWAS/popstruct/selection/flk/flkout/")

library(ape)
library(qqman)
library(colorspace)
library(data.table)
neu.t=read.tree('camflk_tree.txt')
plot(neu.t,align=T)
axis(1,line=1.5)
title(xlab='F')

flk <- fread("cammslflk.flk", header=T, data.table = F)
flk$BH_adj_P <- p.adjust(flk$pvalue, method = "BH")
flk$Bonf <- p.adjust(flk$pvalue, method = "bonferroni")
write.table(flk, file = "camflk.flk", col.names=T, row.names = F, quote = F, sep = " ")

head(flk)
#--- Colors
#n <- length(unique(flk$chr))
#pcol <- qualitative_hcl(n, h=c(0,360*(n-1)/n), c = 80, l = 40)

#--- Make genome-wode threshold
p <- nrow(flk)
thresh <- 0.05/p  # genome-wide
sgl <- -log10(thresh) - 2 # suggestive line
png("flkmanhattan.png", width = 700, height = 480, units = "px", pointsize = 12, res = NA)
manhattan(flk, chr = "chr", bp = "pos", p = "pvalue", snp = "rs", 
          genomewideline = -log10(thresh), suggestiveline = sgl,
          col = c("grey10", "grey60"),
          highlight = flk$rs[-log10(flk$pvalue)>=sgl], annotatePval = 10^(-sgl),
          annotateTop = T)
dev.off()
#--- Q-Q plot
qq(flk$pvalue)

#--- Density plot
plot(density(flk$flk))
hist(flk$flk, n=200, f=F)
x <- seq(0,30,0.01)
lines(x, dchisq(x, df=2),lwd=2,col=2)
dev.off()

