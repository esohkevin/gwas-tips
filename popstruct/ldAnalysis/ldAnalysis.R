#!/usr/bin/Rscript


hHbC11 <- read.table("chr11hHbCrs2445284.ld", header=T, as.is=T)
cam <- data.frame(hHbC11[hHbC11$R2>=0.5,6])
write.table(cam, file="camTag.txt", col.names=F, row.names=F, quote=F) 
hHbC11gwd <- read.table("chr11hHbCrs2445284gwd.ld", header=T, as.is=T)
gwd <- data.frame(hHbC11gwd[hHbC11gwd$R2>=0.5,6])
write.table(cam, file="gwdTag.txt", col.names=F, row.names=F, quote=F)
hHbC11yri <- read.table("chr11hHbCrs2445284yri.ld", header=T, as.is=T)
yri <- data.frame(hHbC11yri[hHbC11yri$R2>=0.5,6])
write.table(cam, file="yriTag.txt", col.names=F, row.names=F, quote=F)
hHbC11lwk <- read.table("chr11hHbCrs2445284lwk.ld", header=T, as.is=T)
lwk <- data.frame(hHbC11lwk[hHbC11lwk$R2>=0.5,6])
write.table(cam, file="lwkTag.txt", col.names=F, row.names=F, quote=F)
hHbC11gbr <- read.table("chr11hHbCrs2445284gbr.ld", header=T, as.is=T)
gbr <- data.frame(hHbC11gbr[hHbC11gbr$R2>=0.5,6])
write.table(cam, file="gbrTag.txt", col.names=F, row.names=F, quote=F)
hHbC11chb <- read.table("chr11hHbCrs2445284chb.ld", header=T, as.is=T)
chb <- data.frame(hHbC11chb[hHbC11chb$R2>=0.5,6])
write.table(cam, file="chbTag.txt", col.names=F, row.names=F, quote=F)


rbPal <- colorRampPalette(c("yellow","red"))
hHbC11$Col <- rbPal(10)[as.numeric(cut(hHbC11$R2,breaks = 10))]
rbPala <- colorRampPalette(c("yellow","red"))
hHbC11yri$Col <- rbPala(10)[as.numeric(cut(hHbC11yri$R2,breaks = 10))]
rbPalb <- colorRampPalette(c("yellow","red"))
hHbC11gwd$Col <- rbPalb(10)[as.numeric(cut(hHbC11gwd$R2,breaks = 10))]
rbPalc <- colorRampPalette(c("yellow","red"))
hHbC11lwk$Col <- rbPalc(10)[as.numeric(cut(hHbC11lwk$R2,breaks = 10))]
rbPald <- colorRampPalette(c("yellow","red"))
hHbC11gbr$Col <- rbPald(10)[as.numeric(cut(hHbC11gbr$R2,breaks = 10))]
rbPale <- colorRampPalette(c("yellow","red"))
hHbC11chb$Col <- rbPale(10)[as.numeric(cut(hHbC11chb$R2,breaks = 10))]



png("hHbCld.png", height=480, width=700, units="px")
par(mfrow=c(2,3))
plot(hHbC11$BP_B, hHbC11$R2, pch=20, xlab="BP", ylab="LD (r^2)", main="CAM", col = hHbC11$Col)
abline(h=0.5, lty=2, col="blue")
plot(hHbC11yri$BP_B, hHbC11yri$R2, pch=20, xlab="BP", ylab="LD (r^2)", main="YRI", col = hHbC11yri$Col)
abline(h=0.5, lty=2, col="blue")
plot(hHbC11gwd$BP_B, hHbC11gwd$R2, pch=20, xlab="BP", ylab="LD (r^2)", main="GWD", col = hHbC11gwd$Col)
abline(h=0.5, lty=2, col="blue")
plot(hHbC11lwk$BP_B, hHbC11lwk$R2, pch=20, xlab="BP", ylab="LD (r^2)", main="LWK", col = hHbC11lwk$Col)
abline(h=0.5, lty=2, col="blue")
plot(hHbC11gbr$BP_B, hHbC11gbr$R2, pch=20, xlab="BP", ylab="LD (r^2)", main="GBR", col = hHbC11gbr$Col)
abline(h=0.5, lty=2, col="blue")
plot(hHbC11chb$BP_B, hHbC11chb$R2, pch=20, xlab="BP", ylab="LD (r^2)", main="CHB", col = hHbC11chb$Col)
abline(h=0.5, lty=2, col="blue")
dev.off()
