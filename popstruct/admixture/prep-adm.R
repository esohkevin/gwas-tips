#!/usr/bin/Rscript

mergeData <- read.table("adm-data.fam", col.names=c("FID","IID","C1","C2","SEX","PHE"), as.is=T)
mergePops <- read.table("../eig/CONVERTF/pop-ald.ind", col.names=c("FID","SEX","ETH"), as.is=T)
admPops <- merge(mergeData, mergePops, by="FID")
attach(admPops)
admOrd <- admPops[order(ETH),]
write.table(admOrd, file="admPopsTemplate.txt", col.names=T, row.names=F, quote=F, sep="\t")
write.table(admOrd[,8], file="adm-data.pop", col.names=F, row.names=F, quote=F, sep="\t")

