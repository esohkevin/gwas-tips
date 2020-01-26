#!/usr/bin/Rscript

args <- commandArgs(TRUE)
hHbC11 <- read.table(args[1], header=T, as.is=T)
bantu <- data.frame(hHbC11[hHbC11$R2>=0.5,6])
write.table(bantu, file="bantuTag.txt", col.names=F, row.names=F, quote=F) 
hHbC11semibantu <- read.table(args[2], header=T, as.is=T)
semibantu <- data.frame(hHbC11semibantu[hHbC11semibantu$R2>=0.5,6])
write.table(semibantu, file="semibantuTag.txt", col.names=F, row.names=F, quote=F)
hHbC11fulbe <- read.table(args[3], header=T, as.is=T)
fulbe <- data.frame(hHbC11fulbe[hHbC11fulbe$R2>=0.5,6])
write.table(fulbe, file="fulbeTag.txt", col.names=F, row.names=F, quote=F)
hHbC11cam <- read.table(args[4], header=T, as.is=T)
#lwk <- data.frame(hHbC11cam[hHbC11cam$R2>=0.5,6])
#write.table(bantu, file="lwkTag.txt", col.names=F, row.names=F, quote=F)
#hHbC11gbr <- read.table(args[5], header=T, as.is=T)
#gbr <- data.frame(hHbC11gbr[hHbC11gbr$R2>=0.5,6])
#write.table(bantu, file="gbrTag.txt", col.names=F, row.names=F, quote=F)
#hHbC11chb <- read.table(args[6], header=T, as.is=T)
#chb <- data.frame(hHbC11chb[hHbC11chb$R2>=0.5,6])
#write.table(bantu, file="chbTag.txt", col.names=F, row.names=F, quote=F)
recombMap <- read.table(args[8], header=T, as.is=T)
a <- as.integer(args[6])
b <- as.integer(args[7])
#c <- as.numeric(as.interger(HbC11[a,5])-300)
#d <- as.numeric(as.interger(hHbC11[b,5])+300)
recomRange <- recombMap[a:b,]

rbPal <- colorRampPalette(c("yellow","red"))
hHbC11$Col <- rbPal(10)[as.numeric(cut(hHbC11$R2,breaks = 10))]
rbPala <- colorRampPalette(c("yellow","red"))
hHbC11fulbe$Col <- rbPala(10)[as.numeric(cut(hHbC11fulbe$R2,breaks = 10))]
rbPalb <- colorRampPalette(c("yellow","red"))
hHbC11semibantu$Col <- rbPalb(10)[as.numeric(cut(hHbC11semibantu$R2,breaks = 10))]
rbPalc <- colorRampPalette(c("yellow","red"))
hHbC11cam$Col <- rbPalc(10)[as.numeric(cut(hHbC11cam$R2,breaks = 10))]
#rbPald <- colorRampPalette(c("yellow","red"))
#hHbC11gbr$Col <- rbPald(10)[as.numeric(cut(hHbC11gbr$R2,breaks = 10))]
#rbPale <- colorRampPalette(c("yellow","red"))
#hHbC11chb$Col <- rbPale(10)[as.numeric(cut(hHbC11chb$R2,breaks = 10))]



png(args[5], height=6, width=6, units="in", type="cairo")
par(mfrow=c(4,2))

par(fig=c(0, 0.5, 0.535, 1), bty="o", cex.main=1)
plot(hHbC11$BP_B, hHbC11$R2, pch=20, xlim=c(92000000,95000000), xaxt="n", xlab=" ", ylab="LD (r^2)", main="BANTU", col = hHbC11$Col)
abline(h=0.5,lty=2, col="grey")

par(fig=c(0.5, 1, 0.535, 1),new=T, bty="o", cex.main=1)
plot(hHbC11fulbe$BP_B, hHbC11fulbe$R2, pch=20, xlim=c(92000000,95000000), xaxt="n", xlab=" ", ylab="LD (r^2)", main="FULBE", col = hHbC11fulbe$Col)
abline(h=0.5, lty=2, col="grey")

par(fig=c(0,0.5, 0.15, 0.605),new=T, bty="o", cex.main=1)
plot(hHbC11semibantu$BP_B, hHbC11semibantu$R2, pch=20, xlim=c(92000000,95000000), xaxt="n", xlab=" ", ylab="LD (r^2)", main="SEMIBANTU", col = hHbC11semibantu$Col)
abline(h=0.5, lty=2, col="grey")

#plot(hHbC11gbr$BP_B, hHbC11gbr$R2, pch=20, xlim=c(92000000,95000000), xlab=" ", ylab="LD (r^2)", main="GBR", col = hHbC11gbr$Col)
#abline(h=0.5, lty=2, col="grey")

par(fig=c(0.5,1, 0.15, 0.605),new=T, bty="o", cex.main=1, cex.axis=0.9)
plot(hHbC11cam$BP_B, hHbC11cam$R2, pch=20, xlim=c(92000000,95000000), xaxt="n", xlab=" ", ylab="LD (r^2)", main="CAM", col = hHbC11cam$Col)
abline(h=0.5, lty=2, col="grey")

#plot(hHbC11chb$BP_B, hHbC11chb$R2, pch=20, xlim=c(92000000,95000000), xlab=" ", ylab="LD (r^2)", main="CHB", col = hHbC11chb$Col)
#abline(h=0.5, lty=2, col="grey")

par(fig=c(0, 0.5, 0, 0.25), new=TRUE, bty="n", cex.axis=1.2, cex.main=1.2)
plot(recomRange$position, recomRange$COMBINED_rate.cM.Mb., xlim=c(92000000,95000000), ylim=c(0,100), xlab="BP", ylab="cM/Mb", main="Recombination Rate (cM/Mb)", type="l")
par(fig=c(0.5, 1, 0, 0.25), new=TRUE, bty="n", cex.axis=1.2, cex.main=1.2)
plot(recomRange$position, recomRange$COMBINED_rate.cM.Mb., xlim=c(92000000,95000000), ylim=c(0,100), xlab="BP", ylab="cM/Mb", main="Recombination Rate (cM/Mb)", type="l")
dev.off()
