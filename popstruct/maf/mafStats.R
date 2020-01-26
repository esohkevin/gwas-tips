#!/bin/bash

setwd("/home/esoh/Git/GWAS/popstruct/maf/")

require(data.table)
require(colorspace)
require(RColorBrewer)

hcl_palettes(type = "sequential", plot = T)
pcol <- RColorBrewer::brewer.pal(3, "Set3")

frq <- fread("cam.frq.strat.txt")
frq <- fread("maf.frq")
#colnames(maf) <- c("CHR","POS","RAF","MAF")

hist(frq$MAF)

attach(frq)
pcol <- sequential_hcl(3, h=260, c=80, l=c(0,200))
png("maf.png", height=15, width=15, units="cm", res=100, points=12)
hist(frq$MAF[frq$CLST=="BA"], xlim = c(0,0.50), breaks = 200, xlab="MAF bin", main = "MAF Spectrum", col = pcol)
hist(frq$MAF[frq$CLST=="FO"], xlim=c(0,0.50),breaks=100, labels =F, add=T, col = pcol)
hist(frq$MAF[frq$CLST=="SB"], xlim=c(0,0.50),breaks=200, labels =F, add=T, col = pcol)
abline(v=c(0.01,0.05), col=c(2,4,1), lty=2)
dev.off()
plot(density(frq$MAF[frq$CLST=="FO"]))

head(frq)
#frq <- read.table("camall.frq.txt", header = T, as.is = T)
#png("mafHbbAfr.png", height=550, width=550, units="px", points=14)
#hist(frq$MAF[frq$CLST=="LWK"], xlim=c(0,0.50),breaks=300, ylim=c(0,500), col=3, labels =F, main="Minor Allele Frequency Spectrum - HBB Region", xlab="MAF", ylab="Allele Count") 
#hist(frq$MAF[frq$CLST=="GWD"], xlim=c(0,0.50),breaks=300, col=2, labels =F, add=T)
#hist(frq$MAF[frq$CLST=="YRI"], xlim=c(0,0.50),breaks=300, col=4, labels =F, add=T)   
#hist(frq$MAF[frq$CLST=="ESN"], xlim=c(0,0.50),breaks=300, col=5, labels =F, add=T)   
#hist(frq$MAF[frq$CLST=="MSL"], xlim=c(0,0.50),breaks=100, col=6, labels =F, add=T)    
#hist(frq$MAF[frq$CLST=="CAM"], xlim=c(0,0.50),breaks=100, col=7, labels =F, add=T)     
#legend("topright", c("LWK", "GWD","YRI","ESN","MSL","CAM"), pch=16, col = c(3,2,4,5,6,7), horiz=F, bty="n")
#dev.off()
