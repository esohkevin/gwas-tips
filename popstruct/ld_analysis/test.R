#!/usr/bin/Rscript

args <- commandArgs(TRUE)
hHbC11 <- read.table(args[1], header=T, as.is=T)
cam <- data.frame(hHbC11[hHbC11$R2>=0.5,6])
write.table(cam, file="camTag.txt", col.names=F, row.names=F, quote=F) 
hHbC11gwd <- read.table(args[2], header=T, as.is=T)
gwd <- data.frame(hHbC11gwd[hHbC11gwd$R2>=0.5,6])
write.table(cam, file="gwdTag.txt", col.names=F, row.names=F, quote=F)
hHbC11yri <- read.table(args[3], header=T, as.is=T)
yri <- data.frame(hHbC11yri[hHbC11yri$R2>=0.5,6])
write.table(cam, file="yriTag.txt", col.names=F, row.names=F, quote=F)
hHbC11lwk <- read.table(args[4], header=T, as.is=T)
lwk <- data.frame(hHbC11lwk[hHbC11lwk$R2>=0.5,6])
write.table(cam, file="lwkTag.txt", col.names=F, row.names=F, quote=F)
#hHbC11gbr <- read.table(args[5], header=T, as.is=T)
#gbr <- data.frame(hHbC11gbr[hHbC11gbr$R2>=0.5,6])
#write.table(cam, file="gbrTag.txt", col.names=F, row.names=F, quote=F)
#hHbC11chb <- read.table(args[6], header=T, as.is=T)
#chb <- data.frame(hHbC11chb[hHbC11chb$R2>=0.5,6])
#write.table(cam, file="chbTag.txt", col.names=F, row.names=F, quote=F)
recombMap <- read.table(args[10], header=T, as.is=T)
a <- as.integer(args[8])
b <- as.integer(args[9])
e <- a - 300
f <- b + 300
c <- hHbC11[e,5]
d <- hHbC11[f,5]
recomRange <- recombMap[a:b,]
a
b
c
d
e
f

rbPal <- colorRampPalette(c("yellow","red"))
hHbC11$Col <- rbPal(10)[as.numeric(cut(hHbC11$R2,breaks = 10))]
rbPala <- colorRampPalette(c("yellow","red"))
hHbC11yri$Col <- rbPala(10)[as.numeric(cut(hHbC11yri$R2,breaks = 10))]
rbPalb <- colorRampPalette(c("yellow","red"))
hHbC11gwd$Col <- rbPalb(10)[as.numeric(cut(hHbC11gwd$R2,breaks = 10))]
rbPalc <- colorRampPalette(c("yellow","red"))
hHbC11lwk$Col <- rbPalc(10)[as.numeric(cut(hHbC11lwk$R2,breaks = 10))]
#rbPald <- colorRampPalette(c("yellow","red"))
#hHbC11gbr$Col <- rbPald(10)[as.numeric(cut(hHbC11gbr$R2,breaks = 10))]
#rbPale <- colorRampPalette(c("yellow","red"))
#hHbC11chb$Col <- rbPale(10)[as.numeric(cut(hHbC11chb$R2,breaks = 10))]



png(args[7], height=680, width=700, units="px")
par(mfrow=c(4,2))

par(fig=c(0, 0.5, 0.535, 1), bty="o", cex.main=0.8, cex.axis=0.7)
plot(hHbC11$BP_B, hHbC11$R2, pch=20, xlim=c(c,d), xlab=" ", ylab="LD (r^2)", main="CAM", col = hHbC11$Col)
abline(h=0.5,lty=2, col="grey")

par(fig=c(0.5, 1, 0.535, 1),new=T, bty="o", cex.main=0.8, cex.axis=0.7)
plot(hHbC11yri$BP_B, hHbC11yri$R2, pch=20, xlim=c(c,d), xlab=" ", ylab="LD (r^2)", main="YRI", col = hHbC11yri$Col)
abline(h=0.5, lty=2, col="grey")

par(fig=c(0.5,1, 0.15, 0.605),new=T, bty="o", cex.main=0.8, cex.axis=0.7)
plot(hHbC11gwd$BP_B, hHbC11gwd$R2, pch=20, xlim=c(c,d), xlab=" ", ylab="LD (r^2)", main="GWD", col = hHbC11gwd$Col)
abline(h=0.5, lty=2, col="grey")

#plot(hHbC11gbr$BP_B, hHbC11gbr$R2, pch=20, xlim=c(c,d), xlab=" ", ylab="LD (r^2)", main="GBR", col = hHbC11gbr$Col)
#abline(h=0.5, lty=2, col="grey")

par(fig=c(0,0.5, 0.15, 0.605),new=T, bty="o", cex.main=0.8, cex.axis=0.7)
plot(hHbC11lwk$BP_B, hHbC11lwk$R2, pch=20, xlim=c(c,d), xlab=" ", ylab="LD (r^2)", main="LWK", col = hHbC11lwk$Col)
abline(h=0.5, lty=2, col="grey")

#plot(hHbC11chb$BP_B, hHbC11chb$R2, pch=20, xlim=c(c,d), xlab=" ", ylab="LD (r^2)", main="CHB", col = hHbC11chb$Col)
#abline(h=0.5, lty=2, col="grey")

par(fig=c(0, 0.5, 0, 0.25), new=TRUE, bty="n", cex.axis=1)
plot(recomRange$position, recomRange$COMBINED_rate.cM.Mb., xlim=c(c,d), xlab="BP", ylab="cM/Mb", type="l")
par(fig=c(0.5, 1, 0, 0.25), new=TRUE, bty="n", cex.axis=1)
plot(recomRange$position, recomRange$COMBINED_rate.cM.Mb., xlim=c(c,d), xlab="BP", ylab="cM/Mb", type="l")
dev.off()
