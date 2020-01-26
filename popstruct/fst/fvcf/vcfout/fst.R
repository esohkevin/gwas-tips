#!/usr/bin/Rscript

#setwd("~/esohdata/GWAS/popstruct/fst/fvcf/")

require(data.table)

n <- 100

fn <- "cam-1.weir.fst"
all.fst1 <- fread(fn, header = T, data.table = FALSE, nThread = 30)
perm.res <- all.fst1
head(perm.res)

for (i in 2:n) {
  
  fn <- paste0("cam-",i,".weir.fst")
  all.fst <- fread(fn, header = T, data.table = FALSE, nThread = 30)
  all.fst <- all.fst[,c(2,3)]
  perm.res <- merge(perm.res, all.fst, by = "POS", no.dups = F, suffixes = paste0("x.",i))

  #perm.res <- merge(all.fst1, all.fst, by = "POS")
  
}
#head(perm.res)
perm.res <- perm.res[order(perm.res[,c("CHROM","POS")]),]
all.fst <- perm.res
all.fst$mean <- rowMeans(all.fst[,-c(1:2)])
#head(all.fst)
fwrite(all.fst, file = "merge.fst", buffMB = 10, nThread = 30, sep = " ")


#head(perm.res)


#all.fst1 <- fread("cam-1.fst", header = T, data.table = FALSE, nThread = 4)
#all.fst2 <- fread("cam-2.fst", header = T, data.table = FALSE, nThread = 4)
#rsids <- all.fst1$SNP
#
#
#all.fst2 <- all.fst2[,c(3,5)]
#head(all.fst)
#all.fst <- merge(all.fst1, all.fst2, by = "POS")
#all.fst <- all.fst[order(all.fst[,c("CHR","POS")]),]

#all.fst$mean <- rowMeans(all.fst[,c(5:6)])
#all.fst.sd <- sd(all.fst[,c(5:6)])

#head(all.fst)
#str(all.fst)
png("density.png", height = 16, width = 16, units = "cm", res = 100, points = 14)
plot(density(na.omit(all.fst$mean)))
abline(v=0.00)
dev.off()

