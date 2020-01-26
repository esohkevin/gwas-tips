#!/usr/bin/Rscript

#args <- commandArgs(TRUE)
#
#fn <- args[1]
#
#ldMatrix <- as.matrix(read.table(fn, fill=T, skip = 0))
#
## PLot heatmap with upper triangular matrix of ld analysis
#png(args[2], width = 800, height = 600, units = "px", pointsize = 12,
#    bg = "white",  res = NA)
##ldMatrix <- as.matrix(read.table("chr6Mhc.ld", fill=T, skip = 0))
#
##ldMatrix <- readBin('chr6Mhc-bin.ld.bin', what="numeric",n=9591, size=4)
#
##heatmap(ldMatrix)
#image(lower.tri(ldMatrix))
#dev.off()

args <- commandArgs(TRUE)
camldMatrix <- as.matrix(read.table(args[1], fill=T, skip = 0))
bantuldMatrix <- as.matrix(read.table(args[2], fill=T, skip = 0))
semibantuldMatrix <- as.matrix(read.table(args[3], fill=T, skip = 0))
fulbeldMatrix <- as.matrix(read.table(args[4], fill=T, skip = 0))
#png("hbbregion.png", height=500, width=580, units="px")
#par(mfrow=c(2,2))
#image(camldMatrix, useRaster=T, add = TRUE)
#image(bantuldMatrix, useRaster=T, add = TRUE)
#image(fulbeldMatrix, useRaster=T, add = TRUE)
#image(semibantuldMatrix, useRaster=T, add = TRUE)
#dev.off()


# Plot pairwise LD
recombMap <- read.table(args[5], header=T, as.is=T)
recomRange <- recombMap[5428:5947,]
png(args[6], height=680, width=680, units="px", res=NA, points=14)
par(mfrow=c(4,2))
par(fig=c(0, 0.5, 0.535, 1), bty="o", mar=c(4,2,4,2))
image(bantuldMatrix, useRaster=T, axes=F, main="Bantu", col=c(1,2))
par(fig=c(0.5, 1, 0.535, 1),new=T, bty="o")
image(fulbeldMatrix, useRaster=T, axes=F, main="Fulbe", col=c(1,2))
par(fig=c(0.5,1, 0.15, 0.605),new=T, bty="o")
image(camldMatrix, useRaster=T, axes=F, main="CAM", col=c(1,2))
par(fig=c(0,0.5, 0.15, 0.605),new=T, bty="o")
image(semibantuldMatrix, useRaster=T, axes=F, main="Semi-Bantu", col=c(1,2))
par(fig=c(0, 0.5, 0, 0.25), new=TRUE, bty="n")
plot(recomRange$position, recomRange$COMBINED_rate.cM.Mb., xlim=c(5150000,5400000), ylim=c(0,100), xlab="BP", ylab="cM/Mb", main="Recombination Rate (cM/Mb)", type="l")
abline(v=c(5230000,5300000), lty=2)
par(fig=c(0.5, 1, 0, 0.25), new=TRUE, bty="n")
plot(recomRange$position, recomRange$COMBINED_rate.cM.Mb., xlim=c(5150000,5400000), ylim=c(0,100), xlab="BP", ylab="cM/Mb", main="Recombination Rate (cM/Mb)", type="l")
abline(v=c(5230000,5300000), lty=2)
dev.off()
