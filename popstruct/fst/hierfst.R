#!/usr/bin/Rscritp

#setwd("~/esohdata/GWAS/popstruct/fst")
#setwd("~/Git/popgen/fst/")

#------- Load packages
require(hierfstat)
require(adegenet)
require(parallel)
require(data.table)
require(pegas)

args <- commandArgs(TRUE)

#------- Read in files
#for (i in 1:2) {

  i <- args[1]

  ph <- paste0("perm",i,".txt")
  pheno <- ph
  fpheno <- as.data.frame(fread(pheno, nThread = 4, header = F))
  colnames(fpheno) <- c("FID", "IID", "ETH")
  
  #-------- Load VCF
  f <- paste0("hier-",i,".vcf.gz")
  fn <- f
  x.1 <- VCFloci(fn)
  base <- c("A","T","G","C")
  snps <- which(x.1$REF %in% base & x.1$ALT %in% base)
  x <- read.vcf(fn, which.loci = snps)
  eth_dat <- genind2hierfstat(loci2genind(x), pop = fpheno$ETH)
  
  #-------- Initialize Output
  bstat1 <- paste0("bstats",i,".txt")
  bstat2 <- paste0("bstats",i,".Fst")
  hvc <- paste0("hier-",i,".vcomp.loc")
  hvcpng <- paste0("hier-",i,".png")


  #-------- Variance component
  eth_vc <-hierfstat::varcomp.glob(data.frame(fpheno$ETH), eth_dat[,-c(1)])
  eth_vc$F
  write.table(eth_vc$loc, file = hvc, col.names = F, 
  		row.names = T, quote = F, sep = " ")
  #fwrite(eth_vc$loc, file = hvc, buffMB = 10, nThread = 30, sep = " ")

  #-----------------------------------------------------------------------------#
  #plot(eth_vc$loc[,1], eth_vc$loc[,2], pch = 16)
  #hist(eth_vc$loc[,1])

  png(hvcpng, height = 16, width = 16, units = "cm", res = 100, points = 14)
  plot(density(eth_vc$loc[,2]))
  dev.off()
  
  #-------- Compute basic stat
  eth_bstat <- basic.stats(na.omit(eth_dat))
  print("Ethnicity", quote = FALSE)
  eth_bstat$overall
  write.table(eth_bstat$perloc, file = bstat1, row.names = T, 
  		col.names = T, quote = F, sep = " ")
  #fwrite(eth_bstat$perloc[,c(1:3,7)], file = bstat2, buffMB = 10, nThread = 30, sep = " ")
  
  
  #-------- Test Between levels
  #eth_tb <- test.between(alt_dat[,-c(1)], test.lev = fpheno$ALTCAT, 
  #                        rand.unit = fpheno$PARACAT)
  
  #-------- Test significance of the effect of level on differentiation
  #eth_g <- test.g(eth_dat[,-c(1)], level = fpheno$ETH, nperm = 1000)
  #eth_g$p.val

#}

#eth_boot <- boot.vc(data.frame(fpheno$ETH), eth_dat[,-c(1)], nboot = 100)
#eth_boot
#-----------------------------------------------------------------------------#

#require(shuffleSet)


#-------- Plot NJ tree
#png("bionj.png", height = 15, width = 15, units = "cm", res = 100, points = 12)
#for (i in c("eth_dat")) {
#  if (i == "eth_dat") {
#    i.name <- "ETH"
#    i.main <- "Ethnicity"
#    d <- genet.dist(na.omit(eth_dat))
#    d <- as.matrix(d)
#    dimnames(d)[[1]] <- dimnames(d)[[2]] <- as.character(levels(eth_dat[,1]))
#    my.col <- as.integer(fpheno$i.name)
#    x <- table(fpheno$i.name, my.col)
#    my.col <- apply(x,1, function(y) which(y>0))
#    plot(bionj(d), type = "unrooted", lab4ut = "axial", 
#         cex = 0.8, tip.color = my.col, main = i.main)
#    mtext(paste0("p-value ",eth_g$p.val), side = 3)
#    #text(6, 2, paste0("p-value ", eth_g$p.val),
#    #     cex = 0.8)
#    
#  }
#}
#dev.off()
#  
#
#png("boxplots.png", height = 13, width = 18, units = "cm", res = 100, points = 14)
#boxplot(eth_bstat$perloc[,c(1:3)], main = "Ethnicity")
#mtext(paste0("p-value ",eth_g$p.val), side = 3)
#dev.off()
