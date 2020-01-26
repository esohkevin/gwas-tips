#!/usr/bin/env R
setwd("/home/esoh/Git/GWAS/popstruct/world/EIGENSTRAT/")
require(colorspace) 
require(RColorBrewer)

#evecDat <- read.table("afr-data.pca.evec", col.names=c("Sample","PC1","PC2","PC3","PC4","PC5","PC6","PC7","PC8","PC9","PC10","Status"), as.is=T)
#popGrps <- read.table("africaGrops.txt", col.names=c("Sample","Pop","PopGroup"), as.is=T)
#pcaDat <- merge(evecDat, popGrps, by="Sample")
#write.table(pcaDat, file="afr-data.pca.txt", col.names=T, row.names=F, quote=F, sep="\t")

evecDat <- read.table("afr.pca.txt", header=T, as.is=T)
png("AfrPCA.png", height=18, width=15, units="cm", points=14, res=100)
par(mfrow=c(2,1), cex=0.8, cex.axis=1, cex.lab=1.2)
par(fig=c(0,1,0.35,1), bty="n", mar=c(4,4,3,2))
plot(evecDat[,2], evecDat[,3], xlab="PC1 (Africa-only)", ylab="PC2", type="n", cex.axis=0.6, cex.lab=0.8)
for(i in 1:nrow(evecDat)){                                                                      
if(evecDat[i,13]=='BA') points(evecDat[i,2], evecDat[i,3], col="green", pch=20)
if(evecDat[i,13]=='SB') points(evecDat[i,2], evecDat[i,3], col="blue", pch=20)
if(evecDat[i,13]=='FO') points(evecDat[i,2], evecDat[i,3], col="red", pch=20)
#if(evecDat[i,13]=='ACB') points(evecDat[i,2], evecDat[i,3], col="aquamarine", pch=20)
#if(evecDat[i,13]=='ASW') points(evecDat[i,2], evecDat[i,3], col="aquamarine4", pch=20)
if(evecDat[i,13]=='ESN') points(evecDat[i,2], evecDat[i,3], col="indianred4", pch=20)
if(evecDat[i,13]=='YRI') points(evecDat[i,2], evecDat[i,3], col="deeppink", pch=20)
if(evecDat[i,13]=='MSL') points(evecDat[i,2], evecDat[i,3], col="deepskyblue", pch=20)
if(evecDat[i,13]=='GWD') points(evecDat[i,2], evecDat[i,3], col="purple4", pch=20)
if(evecDat[i,13]=='LWK') points(evecDat[i,2], evecDat[i,3], col="goldenrod2", pch=20)
}
par(fig=c(0,1,0,0.575), new=T, bty="o", mar=c(1,0,2,1))
plot.new()
legend("center", c("BA=BANTU","SB=SEMI-BANTU","FO=FULBE",
                   "ESN=ESAN in Nigeria","YRI=Yoruba in Ibadan, Nigeria",
                   "MSL=Mende in Sierra Leone", "GWD=Gambian Mandinka", "LWK=Luhya in Webuye, Kenya"), 
		   col=c("green","blue", "red","indianred4","deeppink",
		   "deepskyblue","purple4","goldenrod2"), 
       pch=c(20,20,20,20,20,20,20,20), 
		   ncol=2, bty="n", cex=0.7)
dev.off()

#--- Plot Cameroon data from FineStructure
setwd("../../../phase/fs_4.0.1/project/")
cam <- read.csv("cameig.csv", header = T, comment.char = "#")
cam <- cam[,c(1:11)]
colnames(cam) <- c("FID","C1","C2","C3","C4","C5", "C6","C7","C8","C9","C10")
cameth <- merge(cam, eth, by = "FID")
n <- length(levels(as.factor(cameth$ethnicity)))
pcol <- RColorBrewer::brewer.pal(n, "Dark2")
plot(cameth$C1, cameth$C9, xlab="PC1", 
     ylab="PC6", pch = 20, col = "grey")
d <- cameth[cameth$ethnicity=="BA",]
points(d$C1,d$C9, col=pcol[1], pch = 20)
d <- cameth[cameth$ethnicity=="FO",]
points(d$C1,d$C9, col=pcol[2], pch = 20)
d <- cameth[cameth$ethnicity=="SB",]
points(d$C1,d$C9, col=pcol[3], pch = 20)
legend("topright", 
       legend=levels(as.factor(cameth$ethnicity)),
       col=pcol, pch = 20, bty="n", cex = 1)
dev.off()

#--- Plot Africa data from FineStructure
setwd("../../../phase/fs_4.0.1/world/")
afr <- read.csv("afreig.csv", header = T, comment.char = "#")
afr <- afr[,c(1:11)]
colnames(afr) <- c("FID","C1","C2","C3","C4","C5", "C6","C7","C8","C9","C10")
afreth <- merge(afr, eth, by = "FID")
head(afreth)
n <- length(levels(as.factor(afreth$ethnicity)))
pcol <- RColorBrewer::brewer.pal(n, "Dark2")
png("AfrfPCA.png", height=18, width=15, units="cm", points=14, res=100)
par(mfrow=c(2,1), cex=0.8, cex.axis=1, cex.lab=1.2)
par(fig=c(0,1,0.35,1), bty="n", mar=c(4,4,3,2))
plot(afreth$C1, afreth$C2, xlab="PC1", bty="n", 
     ylab="PC2", pch = 20, col = "grey")
for(i in 1:nrow(afreth)){                                                                      
  if(afreth[i,13]=='BA') points(afreth[i,2], afreth[i,3], col="deeppink", pch=20)
  if(afreth[i,13]=='SB') points(afreth[i,2], afreth[i,3], col="indianred4", pch=20)
  if(afreth[i,13]=='FO') points(afreth[i,2], afreth[i,3], col="purple4", pch=20)
  #if(afreth$ethnicity=='ACB') points(afreth$C1, afreth$C2, col="aquamarine", pch=20)
  #if(afreth$ethnicity=='ASW') points(afreth$C1, afreth$C2, col="aquamarine4", pch=20)
  if(afreth[i,13]=='ESN') points(afreth[i,2], afreth[i,3], col="chartreuse", pch=20)
  if(afreth[i,13]=='YRI') points(afreth[i,2], afreth[i,3], col="chartreuse4", pch=20)
  if(afreth[i,13]=='MSL') points(afreth[i,2], afreth[i,3], col="deepskyblue", pch=20)
  if(afreth[i,13]=='GWD') points(afreth[i,2], afreth[i,3], col="deepskyblue4", pch=20)
  if(afreth[i,13]=='LWK') points(afreth[i,2], afreth[i,3], col="goldenrod2", pch=20)
}
par(fig=c(0,1,0,0.575), new=T, bty="o", mar=c(1,0,2,1))
plot.new()
legend("center", c("BA=BANTU","SB=SEMI-BANTU","FO=FULBE",
                   "ESN=ESAN in Nigeria","YRI=Yoruba in Ibadan, Nigeria",
                   "MSL=Mende in Sierra Leone", "GWD=Gambian Mandinka", "LWK=Luhya in Webuye, Kenya"), 
       col=c("deeppink","indianred4", "purple4","chartreuse","chartreuse4",
             "deepskyblue","deepskyblue4","goldenrod2"), 
       pch=c(20,20,20,20,20,20,20,20), 
       ncol=2, bty="n", cex=0.8)
dev.off()
