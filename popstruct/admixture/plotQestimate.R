#!/usr/bin/env Rscript

library(data.table)

setwd("~/esohdata/GWAS/popstruct/admixture/")

#--- Load files
args <- commandArgs(TRUE)
fn <- args[1]
fn <- "adm-data.3.Q"
fo <- "eth.txt"
cv <- "adm-k-parameters.txt"
outimg <- gsub(".Q",".png",fn)

tbl=read.table(fn)
n <- ncol(tbl)
fsb <- "../../phase/fs_4.0.1/project/camgwas_all.csv" #1073
fsa <- "../../phase/fs_4.0.1/project/cameig.csv"
qc_eth <- "../world/pca_eth_world_pops.txt"

# cameig.csv
fsa <- read.csv(fsa, header = T, comment.char = "#")
fsa <- data.table(fsa[,1], fsa[,2], fsa[,3], fsa[,4],
                  fsa[,5], fsa[,6], fsa[,7], fsa[,8], fsa[,9],
                  fsa[,10], fsa[,11], fsa[,12])
colnames(fsa) <- c("FID", "C1", "C2", "C3", "C4", "C5", "C6", 
                   "C7", "C8", "C9", "C10", "Status")
eth <- fread(qc_eth, header = T, col.names = c("FID", "Sex", "ethnicity", "PopGroup"), nThread = 4)
fsaethn <- merge(fsa, eth, by="FID")
fsaethn <- fsaethn[order(ethnicity),]

# camgwas_all.csv
fsb <- read.csv(fsb, header = T, comment.char = "#")
fsb <- data.table(fsb[,1], fsb[,2], fsb[,3], fsb[,4],
                  fsb[,5], fsb[,6], fsb[,7], fsb[,8], fsb[,9],
                  fsb[,10], fsb[,11], fsb[,12])
colnames(fsb) <- c("FID", "C1", "C2", "C3", "C4", "C5", "C6", 
                   "C7", "C8", "C9", "C10", "Status")
fsbethn <- merge(fsb, eth, by="FID")
fsbethn <- fsbethn[order(ethnicity),]

# Colors
pcol <- RColorBrewer::brewer.pal(6, "Dark2")
pcol <- rainbow(n)

# Q estimates
sam_names <- read.table(fo, h=F, as.is = T)
fm <- data.frame(FID=sam_names[,1],
                 Q1=tbl[,1],
                 Q2=tbl[,2],
                 Q3=tbl[,3],
                 eth=sam_names[,3])


# Make a 2x2 image
png("all-model-based.png", height = 9, width = 12, res = 200, points = 6, units = "cm")
par(mfrow=c(2,2), mar = c(4,4,1,1))

# Read in cross validation error
cv <- read.table(cv, header=T, as.is=T)
#png(outimg, height=14, width=14, res=100, units="cm", points=12)
plot(cv, xlab="K", ylab="Cross-validation error", pch = 20,  type="b")
d#ev.off()

#-- Admixture (k=3)
#png("adm.png", height = 8, 
#    width = 9, res = 200, 
#    pointsize = 5, units = "cm")
pcol <- rainbow(n)
plot(fm$Q1,fm$Q3, pch=20, cex.main=0.9, 
     main = "Model-based clustering",
     xlab = "Q1", 
     ylab = "Q3")
d <- fm[fm$eth=="BA",]
points(d$Q1,d$Q3, col=pcol[2], pch = 20)
d <- fm[fm$eth=="FO",]
points(d$Q1,d$Q3, col=pcol[1], pch = 20)
d <- fm[fm$eth=="SB",]
points(d$Q1,d$Q3, col=pcol[3], pch = 20)
legend("topright", 
       legend=levels(as.factor(fm$eth)),
       col=c(pcol[2],pcol[1],pcol[3]), pch = 20, bty="n", cex = 1)
#par(fig=c(0.40,1,0.45,0.951), new=T)
barplot(t(as.matrix(tbl)), col=c(pcol[1],pcol[2],pcol[3]), 
        ylab="Ancestry", border=NA, space=0,
        cex.lab=0.8, 
        main = "ancestral proportions", 
        cex.axis=0.7)
#dev.off()

#-- FineStructure (cameig.csv)
#png("fs.png", height = 8, 
#    width = 9, res = 200, 
#    pointsize = 5, units = "cm")
pcol <- rainbow(n)
plot(fsaethn$C1, fsaethn$C2, xlab="PC1", 
     ylab="PC2", pch = 20, col = "black",
     main="Coancestry by Chromosome Painting",
     cex.main=0.9)
d <- fsaethn[fsaethn$ethnicity=="BA",]
points(d$C1,d$C2, col=pcol[2], pch = 20)
d <- fsaethn[fsaethn$ethnicity=="FO",]
points(d$C1,d$C2, col=pcol[1], pch = 20)
d <- fsaethn[fsaethn$ethnicity=="SB",]
points(d$C1,d$C2, col=pcol[3], pch = 20)
legend("topright", 
       legend=levels(as.factor(fsaethn$ethnicity)),
       col=c(pcol[2],pcol[1],pcol[3]), pch = 20, bty="n", cex = 1)
dev.off()
#width=500, height=300, units="px"

#-- FineStructure (camgwas_all.csv)
plot(fsb)
png("fs.png", height = 8, 
    width = 9, res = 200, 
    pointsize = 5, units = "cm")
pcol <- rainbow(n)
plot(fsbethn$C1, fsbethn$C2, xlab="PC1", 
     ylab="PC2", pch = 20, col = "black",
     main="Coancestry by Chromosome Painting",
     cex.main=0.9)
d <- fsbethn[fsbethn$ethnicity=="BA",]
points(d$C1,d$C2, col=pcol[2], pch = 20)
d <- fsbethn[fsbethn$ethnicity=="FO",]
points(d$C1,d$C2, col=pcol[1], pch = 20)
d <- fsbethn[fsbethn$ethnicity=="SB",]
points(d$C1,d$C2, col=pcol[3], pch = 20)
legend("topright", 
       legend=levels(as.factor(fsbethn$ethnicity)),
       col=c(pcol[2],pcol[1],pcol[3]), pch = 20, bty="n", cex = 1)
dev.off()

#-- Admixture K=2
png("adm.png", height = 8, 
    width = 9, res = 200, 
    pointsize = 5, units = "cm")
pcol <- rainbow(n)
plot(fm$Q1,fm$Q2, pch=20, cex.main=0.9, 
     main = "Model-based clustering",
     xlab = "Q1", 
     ylab = "Q2")
d <- fm[fm$eth=="BA",]
points(d$Q1,d$Q2, col=pcol[2], pch = 20)
d <- fm[fm$eth=="FO",]
points(d$Q1,d$Q2, col=pcol[1], pch = 20)
d <- fm[fm$eth=="SB",]
points(d$Q1,d$Q2, col=pcol[3], pch = 20)
legend("bottomleft", 
       legend=levels(as.factor(fm$eth)),
       col=c(pcol[2],pcol[1],pcol[3]), pch = 20, bty="n", cex = 1)
par(fig=c(0.40,1,0.45,0.951), new=T)
barplot(t(as.matrix(tbl)), col=c(pcol[1],pcol[2],pcol[3]), 
        ylab="Ancestry", border=NA, space=0,
        cex.lab=0.8, 
        cex.axis=0.9)
dev.off()
