#!/usr/bin/Rscript

#setwd("~/esohdata/GWAS/analysis/")


#?iconv()

library(qqman)

#con <- file(description = "qc-camgwas-updated.stats.gz", "r+b")
#con <- socketConnection(host = "kevine@delgeme.icermali.org", port = 22, server = T, 
#                 blocking = F, open = "w+", encoding = "", timeout = 100000)
con <- gzfile(description = "qc-camgwas-updated.stats.gz", "r+b")



bolt_assoc <- readBin(con, numeric(), size = 4)

dat <- "qc-camgwas-updated.stats.gz"


con <- socketConnection(port = 22, blocking = TRUE)
writeLines(paste0(system("whoami", intern = TRUE), "\r"), con)
gsub(" *$", "", readLines(con))
close(con)

assoc <- readBin(dat, n = 20L)
head(assoc)
View(assoc)
