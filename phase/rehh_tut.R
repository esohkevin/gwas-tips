#!/usr/bin/Rscript

setwd("../popstruct")
library(rehh)
?rehh
## Tutorial
#make.example.files()
#dir()
#
#map <- read.table("map.inp")
#hap <- data2haplohh(hap_file = "bta12_cgu.hap", map_file = "map.inp", recode.allele = TRUE, chr.name = 12)
#head(haps)
#dim(haps)
#head(map)
#dim(map)
#data("haplohh_cgu_bta12")
#res.ehh <- calc_ehh(haplohh_cgu_bta12, mrk = "F1205400")
#res.ehh$ehh[1:2,454:458]
#res.ehh$nhaplo_eval[1:2,454:458]
#res.ehh$freq_all1
#res.ehh$ihh
#
#res.ehhs <- calc_ehhs(haplohh_cgu_bta12, mrk = "F1205400")
#
#res.scan <- scan_hh(haplohh_cgu_bta12)
#dim(res.scan)
#res.scan[453:459,]
#
## iHHS and iHH
#data("wgscan.cgu")
#ihs.cgu <- ihh2ihs(wgscan.cgu)
#head(ihs.cgu$iHS)
#head(ihs.cgu$frequency.class)
#
## Manhattan plot of iHS results
#layout(matrix(1:2,2,1))
#ihsplot(ihs.cgu,plot.pval = TRUE,ylim.scan = 2,main = "iHS (CGU cattle breed)")
#

### Whole genome Manhattan
for(i in 1:29){
  hap_file=paste("hap_chr_",i,".pop1",sep="")
  data<-data2haplohh(hap_file="hap_file","snp.info",chr.name=i)
  res<-scan_hh(data)
  if(i==1){wg.res<-res}else{wg.res<-rbind(wg.res,res)}
}
wg.ihs<-ihh2ihs(wg.res)
### My Data Test
#
## Convert Plink bim file to rehh map file format
#bim <- read.table("chr11.bim", col.names=c("CHR", "RSID", "cM", "BP", "A1", "A2"), as.is=T)
#newBim <- data.frame(bim$RSID, bim$CHR, bim$BP, bim$A2, bim$A1)
#write.table(newBim, file="chr11.map", col.names=F, row.names=F, quote=F, sep = "\t")
#
## Updated transposed haplotype file by switching 1st and 2nd columns
#haps <- read.table("chr11.tped")
#newhaps <- haps[,5:ncol(haps)]
#hapsUpdated <- data.frame(newBim[,1:3], newhaps)
#write.table(hapsUpdated, file = "chr11-updated.haps", col.names = F, row.names = F, quote = F)
#
## Load data set
hap <- data2haplohh(hap_file = "chr11hbb.hap", map_file = "chr11hbb.map", recode.allele = F, min_perc_geno.hap=100,min_perc_geno.snp=100, haplotype.in.columns=TRUE, chr.name = 11)
#
## Compute EHH
res.ehh <- calc_ehh(hap, mrk = "rs73407039")
#
## Get statistics
#res.ehh$ehh
#res.ehh$nhaplo_eval
#res.ehh$freq_all1
#res.ehh$ihh
#
## Compute EHHS
#res.ehhs <- calc_ehhs(hap, mrk = "rs10742584")
#res.ehhs$nhaplo_eval
#res.ehhs$EHHS_Tang_et_al_2007
#res.ehhs$IES_Tang_et_al_2007  
#res.ehhs$EHHS_Sabeti_et_al_2007
#res.ehhs$IES_Sabeti_et_al_2007
#
## Scan the entire SNPs
#res.scan <- scan_hh(hap)
#dim(res.scan)

# iHS and cross-Population or whole genome scans
hap <- data2haplohh(hap_file = "chr11.hap", map_file = "chr11.map", recode.allele = F, min_perc_geno.hap=100,min_perc_geno.snp=100, haplotype.in.columns=TRUE, chr.name = 11)
wg.res <- scan_hh(hap)
wg.ihs <- ihh2ihs(wg.res)
#head(wg.ihs$iHS)
#head(wg.ihs$frequency.class)

# Gaussian Distribution and Q-Q plot
head(wg.ihs$iHS)
layout(matrix(1:2,2,1))
distribplot(wg.ihs$iHS[,3], xlab = "iHS")
dev.off()

#rs73407039
#rs73404549
#rs73400351
#rs113660949
#rs7102501
#rs75301276
#rs74373495
#rs1905055
#rs116480398
#rs116573934
#rs114519170
#rs76011226
#rs7117421
#rs76186525
#rs80047940
#rs17132555
#rs7924842
#rs112890356

# Bifurcation plot
bifurcation.diagram(hap,mrk_foc="rs114519170",all_foc=1,nmrk_l=20,nmrk_r=20, refsize = 0.01,
                    main="rs114519170")
bifurcation.diagram(hap,mrk_foc="rs76011226",all_foc=2,nmrk_l=20,nmrk_r=20, refsize = 0.08,
                    main="rs76011226")

?bifurcation.diagram()
# Manhattan PLot of iHS results
#png("iHSmanhattan.png", height = 7, width = 7, units = "px", type = "cairo")
#layout(matrix(1:2,2,1))
#ihsplot(wg.ihs, plot.pval = TRUE, ylim.scan = 2, main = "iHS (CAM - Chr11)")
#dev.off()

ihs <- read.table("cam-simiHSresult.txt", header = T, as.is = T)
ihs <- na.omit(ihs)
head(ihs)
args <- commandArgs(TRUE)

hapFile <- paste("chr11Sim",".hap", sep="")
mapFile <- paste("chr11Sim",".map", sep="")
chr <- 11
iHSplot <- paste("cam","iHS.png", sep="")
iHSresult <- paste("cam","iHSresult.txt", sep="")
iHSfrq <- paste("cam","iHSfrq.txt", sep="")
qqPlot <- paste("cam","qqDist.png", sep="")
bifurcA <- paste("cam","bifurc1.png", sep="")
bifurcB <- paste("cam","bifurc2.png", sep="")
iHSmain <- paste("chr",chr,"-","cam","-iHS", sep="")
map <- read.table(mapFile)
map <- data.frame(ID=map$V1, POSITION=map$V3, Ancestral=map$V4, Derived=map$V5)
ihsMerge <- merge(map, ihs, by = "POSITION")
ihsMerge
signals <- ihsMerge[ihsMerge[,7]>=4,]
sigpos <- signals[,2]
sigpos
for (locus in sigpos) {
  print(locus)
}
