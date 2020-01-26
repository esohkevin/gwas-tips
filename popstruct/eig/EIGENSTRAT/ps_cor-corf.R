#!/usr/bin/Rscript

setwd("/home/esoh/Git/GWAS/popstruct/eig/EIGENSTRAT")

#----Load libraries
require(colorspace)
require(data.table)
#require(ggbiplot)
require(RColorBrewer)
# Save evec data into placeholder
args <- commandArgs(TRUE)

#----Initialize files
fa <- "cor.pca.evec"
fb <- "cor-fst.pca.evec"
fsa <- "/home/esoh/Git/GWAS/phase/fs_4.0.1/project/cameig.csv"
fsb <- "/home/esoh/Git/GWAS/phase/fs_4.0.1/world/afreig.csv"

#fn <- "cor-fst.pca.evec"
fa <- args[1]
fb <- args[2]
fabase <- gsub(".pca.evec", "", fa)
fbbase <- gsub(".pca.evec", "", fb)
qc_eth <- "../../../popstruct/world/pca_eth_world_pops.txt"
qc_pops <- "../../../samples/qc-camgwas.pops"
ps_image <- paste0(fabase,"-",fbbase, ".png")

#----Define Colors
#n <- 3
#pcol <- qualitative_hcl(n, h =80, c = 50, l = 90, alpha = 0.9)

#----Load eigenvector file
corr <- fread(fa, header = T, nThread = 4)
corf <- fread(fb, header = T, nThread = 4)
fsa <- read.csv(fsa, header = T, comment.char = "#")
fsb <- read.csv(fsb, header = T, comment.char = "#")
head(fsa)

corr <- data.table(corr[,1], corr[,1], corr[,2], corr[,3], corr[,4],
                          corr[,5], corr[,6], corr[,7], corr[,8], corr[,9],
                          corr[,10], corr[,11], corr[,12])
    
colnames(corr) <- c("FID", "IID", "C1", "C2", "C3", "C4", "C5", "C6", 
                           "C7", "C8", "C9", "C10", "Status")


corf <- data.table(corf[,1], corf[,1], corf[,2], corf[,3], corf[,4],
                   corf[,5], corf[,6], corf[,7], corf[,8], corf[,9],
                   corf[,10], corf[,11], corf[,12])

colnames(corf) <- c("FID", "IID", "C1", "C2", "C3", "C4", "C5", "C6", 
                    "C7", "C8", "C9", "C10", "Status")

#--- FineStructure eigenvectors
fsa <- data.table(fsa[,1], fsa[,2], fsa[,3], fsa[,4],
                   fsa[,5], fsa[,6], fsa[,7], fsa[,8], fsa[,9],
                   fsa[,10], fsa[,11], fsa[,12])

colnames(fsa) <- c("FID", "C1", "C2", "C3", "C4", "C5", "C6", 
                    "C7", "C8", "C9", "C10", "Status")

fsb <- data.table(fsb[,1], fsb[,2], fsb[,3], fsb[,4],
                   fsb[,5], fsb[,6], fsb[,7], fsb[,8], fsb[,9],
                   fsb[,10], fsb[,11], fsb[,12])

colnames(fsb) <- c("FID", "C1", "C2", "C3", "C4", "C5", "C6", 
                    "C7", "C8", "C9", "C10", "Status")


#----Include ethnicity in evec file
eth <- fread(qc_eth, header = T, col.names = c("FID", "Sex", "ethnicity", "PopGroup"), nThread = 4)
correthn <- merge(corr, eth, by="FID")
corfethn <- merge(corf, eth, by="FID")
fsaethn <- merge(fsa, eth, by="FID")
fsbethn <- merge(fsb, eth, by="FID")
fsbethn$ord <- ifelse(fsbethn$ethnicity=="BA", "1", 
                      ifelse(fsbethn$ethnicity=="FO", "1", 
                             ifelse(fsbethn$ethnicity=="SB", "1", 
                                    ifelse(fsbethn$ethnicity=="YRI", "2",
                                           ifelse(fsbethn$ethnicity=="ESN", "2", 
                                                  ifelse(fsbethn$ethnicity=="MSL", "3",
                                                         ifelse(fsbethn$ethnicity=="GWD", "4",
                                                                ifelse(fsbethn$ethnicity=="LWK", "5", "NA"))))))))

#----Import the data file containing ethnicity column
#correthn=read.table("qc-camgwas-ethni.evec", header=T, as.is=T)
correthn <- correthn[order(ethnicity),]
corfethn <- corfethn[order(ethnicity),]
fsaethn <- fsaethn[order(ethnicity),]
fsbethn <- fsbethn[order(ord),]
View(fsbethn)
#----Plot First 2 evecs with ethnicity distinction
png(filename = ps_image, width = 23, height = 19, 
    units = "cm", pointsize = 14,
    bg = "white",  res = 100, type = c("cairo"))
par(mfrow = c(2,3))
par(mar=c(4,5,1,1), cex = 0.8)

#----Set Colors
hcl_palettes(type = "qualitative")
n <- length(levels(as.factor(correthn$ethnicity)))
pcol <- qualitative_hcl(n, palette = "Dark 2", 
                        h = c(0,260), c = 65,l = 55, rev = F)
pcol <- RColorBrewer::brewer.pal(6, "Dark2")

plot(correthn$C1, correthn$C2, xlab="PC1", 
     ylab="PC2", pch = 20, col = "black")
d <- correthn[correthn$ethnicity=="BA",]
points(d$C1,d$C2, col=pcol[1], pch = 20)
d <- correthn[correthn$ethnicity=="FO",]
points(d$C1,d$C2, col=pcol[2], pch = 20)
d <- correthn[correthn$ethnicity=="SB",]
points(d$C1,d$C2, col=pcol[3], pch = 20)
legend("bottomleft", 
       legend=levels(as.factor(correthn$ethnicity)),
       col=pcol, pch = 20, bty="n", cex = 1)

plot(correthn$C1, correthn$C3, xlab="PC1", 
     ylab="PC3", pch = 20, col = "black")
d <- correthn[correthn$ethnicity=="BA",]
points(d$C1,d$C3, col=pcol[1], pch = 20)
d <- correthn[correthn$ethnicity=="FO",]
points(d$C1,d$C3, col=pcol[2], pch = 20)
d <- correthn[correthn$ethnicity=="SB",]
points(d$C1,d$C3, col=pcol[3], pch = 20)
legend("bottomleft", 
       legend=levels(as.factor(correthn$ethnicity)),
       col=pcol, pch = 20, bty="n", cex = 1)

plot(corfethn$C1, corfethn$C2, xlab="PC1", 
     ylab="PC2", pch = 20, col = "black")
d <- corfethn[corfethn$ethnicity=="BA",]
points(d$C1,d$C2, col=pcol[1], pch = 20)
d <- corfethn[corfethn$ethnicity=="FO",]
points(d$C1,d$C2, col=pcol[2], pch = 20)
d <- corfethn[corfethn$ethnicity=="SB",]
points(d$C1,d$C2, col=pcol[3], pch = 20)
legend("topright", 
       legend=levels(as.factor(corfethn$ethnicity)),
       col=pcol, pch = 20, bty="n", cex = 1)

plot(corfethn$C1, corfethn$C3, xlab="PC1", 
     ylab="PC3", pch = 20, col = "black")
d <- corfethn[corfethn$ethnicity=="BA",]
points(d$C1,d$C3, col=pcol[1], pch = 20)
d <- corfethn[corfethn$ethnicity=="FO",]
points(d$C1,d$C3, col=pcol[2], pch = 20)
d <- corfethn[corfethn$ethnicity=="SB",]
points(d$C1,d$C3, col=pcol[3], pch = 20)
legend("topleft", 
       legend=levels(as.factor(corfethn$ethnicity)),
       col=pcol, pch = 20, bty="n", cex = 1)

plot(fsaethn$C1, fsaethn$C2, xlab="PC1", 
     ylab="PC2", pch = 20, col = "black")
d <- fsaethn[fsaethn$ethnicity=="BA",]
points(d$C1,d$C2, col=pcol[1], pch = 20)
d <- fsaethn[fsaethn$ethnicity=="FO",]
points(d$C1,d$C2, col=pcol[4], pch = 20)
d <- fsaethn[fsaethn$ethnicity=="SB",]
points(d$C1,d$C2, col=pcol[6], pch = 20)
legend("topright", 
       legend=levels(as.factor(fsaethn$ethnicity)),
       col=c(pcol[1],pcol[4],pcol[6]), pch = 20, bty="n", cex = 1)

#--- AfrEvec Colors
n <- length(levels(as.factor(fsbethn$ethnicity)))
pcol <- qualitative_hcl(n, palette = "Dark 2", 
                        h = c(0,200), c = 65,l = 55, rev = F)
pcol<- RColorBrewer::brewer.pal(8, name = "Dark2")
pcol
plot(fsbethn$C1, fsbethn$C2, xlab="PC1", 
     ylab="PC2", pch = 20, col = "white", 
     xlim = c(-0.10,0.10), 
     ylim = c(-0.10,0.10))
d <- fsbethn[fsbethn$ethnicity=="BA",]
points(d$C1,d$C2, col=pcol[1], pch = 20)
d <- fsbethn[fsbethn$ethnicity=="FO",]
points(d$C1,d$C2, col=pcol[2], pch = 20)
d <- fsbethn[fsbethn$ethnicity=="SB",]
points(d$C1,d$C2, col=pcol[3], pch = 20)
d <- fsbethn[fsbethn$ethnicity=="YRI",]
points(d$C1,d$C2, col=pcol[4], pch = 20)
d <- fsbethn[fsbethn$ethnicity=="ESN",]
points(d$C1,d$C2, col=pcol[5], pch = 20)
d <- fsbethn[fsbethn$ethnicity=="MSL",]
points(d$C1,d$C2, col=pcol[6], pch = 20)
d <- fsbethn[fsbethn$ethnicity=="GWD",]
points(d$C1,d$C2, col=pcol[7], pch = 20)
d <- fsbethn[fsbethn$ethnicity=="LWK",]
points(d$C1,d$C2, col=pcol[8], pch = 20)
legend("bottomright", 
       legend = c("BA","FO","SB",
                  "YRI", "ESN",
                  "MSL",
                  "GWD",
                  "LWK"),
       col = c(pcol[1],pcol[2],pcol[3],
               pcol[4],pcol[5],
               pcol[6],
               pcol[7],
               pcol[8]),
       pch = 20, bty="n", cex = 1)
dev.off()


#n <- length(levels(as.factor(correthn$ethnicity)))
#pcol <- qualitative_hcl(n, h=c(0,360*(n-1)/n), c = 80, l = 60)
#plot(corr[,-c(1:2,13)], pch = 20, cex = 0.6, bty = "n", col = pcol)


