#!/usr/bin/Rscript

#setwd("~/esohdata/GWAS/analysis/")
args <- commandArgs(TRUE)
f <- args[1]
#?iconv()

library(qqman)
require(data.table)
#con <- file(description = "qc-camgwas-updated.stats.gz", "r+b")
#con <- socketConnection(host = "kevine@delgeme.icermali.org", port = 22, server = T, 
#                 blocking = F, open = "w+", encoding = "", timeout = 100000)
#con <- gzfile(description = "qc-camgwas-updated.stats.gz", "r+b")

#bolt_assoc <- readBin(con, numeric(), size = 4)

#dat <- "qc-camgwas-updated.stats.gz"

#con <- socketConnection(port = 22, blocking = TRUE)
#writeLines(paste0(system("whoami", intern = TRUE), "\r"), con)
#gsub(" *$", "", readLines(con))
#close(con)

#assoc <- readBin(dat, n = 20L)
#head(assoc)
#View(assoc)

#assoc <- fread("qc-camgwas-updated.stats", header = T, data.table = F)
#attach(assoc)
#assoc$P <- assoc$P_BOLT_LMM
#png("bolt_assoc.png", height = 480, width = 700, units = "px", res = NA, pointsize = 12)
#manhattan(assoc)
#dev.off()
#qq(assoc$P)

assoc <- fread(f, h=T, data.table=F, nThread = 30)
attach(assoc)
png("test_assoc.png", height = 440, width = 700, units = "px", res = NA, pointsize = 12)
manhattan(assoc)
dev.off()
png("test_qq.png", height = 480, width = 500, units = "px", res = NA, pointsize = 12)
qq(assoc$P)
dev.off()
