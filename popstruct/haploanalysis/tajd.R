#!/usr/bin/Rscript

setwd("~/esohdata/GWAS/popstruct/")
setwd("~/Git/popgen/")

require(data.table)

td <- fread(input = "test10.Tajima.D")
head(td)

attach(td)
td.nan <- na.omit(td)
attach(td.nan)

View(td.nan)

hbb <- td.nan

attach(hbb)

dev.off()
plot(spline(BIN_START, TajimaD))
plot(BIN_START, TajimaD)
dev.off()
