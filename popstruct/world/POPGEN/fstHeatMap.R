#!/usr/bin/Rscript


args <- commandArgs(TRUE)
fstMat <- read.table(args[1], header=F, as.is=T)
m <- as.matrix(fstMat[,-c(1)])
rownames(m) <- fstMat[,c(1)]
colnames(m) <- fstMat[,c(1)]
png(gsub(".txt",".png",args[1]), width=680, height=680, units="px", type="cairo", points=14)
heatmap(m, scale = "column")
dev.off()
write.table(m, file = args[1], col.names=F, row.names=T,quote=F,sep="\t")


# afrMat <- read.table("afrMatrix.txt", header=T, as.is=T)
# a <- as.matrix(afrMat[, -1])
# rownames(a) <- afrMat$rows
# png("afrFst.png", width=680, height=680, units="px", type="cairo", points=14)
# heatmap(a)
# dev.off()

