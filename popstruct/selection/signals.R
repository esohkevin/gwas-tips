#!/bin/usr/Rscript

sig <- read.table("signals.rsids", h=F)
camsig <- read.table("camSignals.txt",h=F)
camsig$key <- paste0(camsig$V1,":",camsig$V2)
colnames(sig) <- c("rsid", "key")
cammerge <- merge(sig,camsig,by="key")
colnames(cammerge) <- c("key","rsid","chr","pos","ihs","logp","p","bh","bf")
annv <- read.table("annv.txt", h=T, fill=T)
colnames(annv) <- c("key","Ref","Alt",
		    "Func.refGene",
		    "Gene.refGene",
		    "GeneDetail.refGene",
		    "ExonicFunc.refGene",
		    "any","AAChange.refGene",
		    "cytoBand","SIFT_pred",
		    "Polyphen2_HVAR_pred")
annv$any <- NULL
m <- merge(cammerge,annv, by="key")
write.table(m, "signals.table", col.names=T, row.names=F,quote=F, sep="\t")

