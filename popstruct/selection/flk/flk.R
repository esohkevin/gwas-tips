#!/usr/bin/Rscript

#setwd("~/esohdata/GWAS/popstruct/selection/flk/flkout/")

#library(ape)
#neu.t=read.tree('camflk_tree.txt')
#plot(neu.t,align=T)
#axis(1,line=1.5)
#title(xlab='F')


flk <- read.table("flkout/camflk.flk", header=T, as.is=T)
flk$BH_adj_P <- p.adjust(flk$pvalue, method = "BH")
flk$Bonf <- p.adjust(flk$pvalue, method = "bonferroni")
write.table(flk, file = "flkout/camflk.flk", col.names=T, row.names = F, quote = F, sep = " ")
