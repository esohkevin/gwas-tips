#!/usr/bin/Rscript

setwd("~/esohdata/GWAS/popstruct/selection/tajimaD/")

t <- "test.Tajima.D"
p <- "test.sites.pi"

f <- na.omit(read.table(t, h=T))
p <- na.omit(read.table("test.sites.pi", h=T))

head(f)
for (i in f$TajimaD) {
  if (i == "NaN"){
    f$TajimaD[i] <- 0
  }
}

head(f)
plot(f$BIN_START, f$TajimaD, pch =20, type = "l", lwd = 0.9)
lines(p$POS, p$PI)
abline(v=c(32205174,33273993), lty = 2, )
d <- density(na.omit(f$TajimaD))
plot(d)
polygon(d)
dev.off()
