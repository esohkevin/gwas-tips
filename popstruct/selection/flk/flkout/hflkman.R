#!/usr/bin/Rscript

require(data.table)
require(qqman)

#--- hapFLK manhattan plots for chr1-22
for (i in 1:22) {
  #-- Load FLK stats
  f <- fread(paste0("cam-chr",i,"flk.flk"), data.table=F, h=T)
  if(i==1){flk<-f}else{flk<-rbind(flk,f)}

  #-- Load hapFLK stats
  h <- fread(paste0("cam-chr",i,"flk.hapflk"), data.table=F, h=T)
  if(i==1){hflk<-h}else{hflk<-rbind(hflk,h)}

  #-- Load scaled hapFLK (with pvalues) stats
  s <- fread(paste0("cam-chr",i,"flk.hapflk_sc"), data.table=F, h=T)
  if(i==1){sflk<-s}else{sflk<-rbind(sflk,s)}
}

#-- Compute Threshold for FLK stats
ns <- length(flk$pos)
print("", quote=F)
print("Effive number of SNPs", quote=F)
print(ns, quote=F)
print("", quote=F)
thr <- as.numeric(-log10(0.05/ns))
print("Genome-wide threshold", quote=F)
print(thr, quote=F)
print("", quote=F)

if (thr >= 8) {
	thresh <- 8
} else {thresh <- thr}

#--- Write table of scaled hapFLK results
fwrite(sflk, "scaledhFLK.txt", buffMB = 10, nThread = 30, sep = " ")

#--- Plot scaled hFLK
png("hflk.png", height=650, width=650, units="px", res=NA, pointsize= 12)
par(mfrow=c(2,1))
par(fig=c(0,1,0,0.50), bty="o", mar=c(5,4,2,1))
#--- Scaled hapFLK manhattan
manhattan(sflk, chr = "chr", bp = "pos", 
          p = "pvalue", snp = "rs",
          col = c("grey10", "grey60"), 
          genomewideline = thresh,
	  highlight = sflk$rs[-log10(sflk$pvalue)>=-log10(1E-5)], 
          suggestiveline = -log10(1E-5))
par(fig=c(0,1,0.50,1), new=T, bty="o", mar=c(0,4,2,1))
#--- hapFLK manhattan
manhattan(hflk, chr = "chr", bp = "pos", 
          p = "hapflk", snp = "rs",
          col = c("grey10", "grey60"), 
          logp=F, type='l', lwd=2, #xaxt='n', 
          genomewideline = F, 
          suggestiveline = F, ylab = "hapFLK")
dev.off()

# #--- hapFLK manhattan
png("hflk_single.png", height=480, width=650, units="px", res=NA, pointsize= 12)
manhattan(sflk, chr = "chr", bp = "pos",
          p = "pvalue", snp = "rs",
          col = c("grey10", "grey60"),
          genomewideline = thresh,
          highlight = sflk$rs[-log10(sflk$pvalue)>=-log10(1E-5)],
          suggestiveline = -log10(1E-5))
dev.off()
