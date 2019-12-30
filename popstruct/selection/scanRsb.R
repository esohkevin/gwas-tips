#!/usr/bin/Rscript

require(rehh)
#vignette(rehh)

## iHS and cross-Population or whole genome scans

args <- commandArgs(TRUE)

# #--------------------------------------------------------------------------------
# ##		Initialize parameter and output file names			
# ##
# hapFile <- args[1]
# outprfx <- args[2]
# numchr <- args[3]
# th <- args[4]
# t <- args[5]
# 
# scan_pops <- function(data = c(hapFile), 
#                       outname = outprfx,
#                       numchr = number_of_chr,
#                       thresh = th,
#                       threads = t){
#   for (i in data) {
#     #snpInfo <- read.table("snp.info", header = F, as.is = T)
#     iHSplot <- paste(outname,"iHS.png", sep="")
#     iHSresult <- paste(outname,"iHSresult.txt", sep="")
#     iHSfrq <- paste(outname,"iHSfrq.txt", sep="")
#     qqPlot <- paste(outname,"qqDist.png", sep="")
#     iHSmain <- paste(outname,"-iHS", sep="")
#     sigOut <- paste(outname,"Signals.txt",sep="")
#     
#     #--------------------------------------------------------------------------------
#     ##              Load .hap and .map files to create hap dataframe
#     ##              Run genome scan and iHS analysis                
#     
#     for(j in 1:numchr) {
#       hapFile <- paste0(i,j,".hap")
#       mapFile <- mapFile <- paste(args[1],j,".map",sep="")
#       data <- data2haplohh(hap_file=hapFile, map_file=mapFile, recode.allele = F,
#                            min_perc_geno.hap=100, min_maf=0.05, 
#                            haplotype.in.columns=TRUE, chr.name=j)
#       res <- list()
#       res <- scan_hh(data, threads = 10)
#       if(i==1){wg.res<-res}else{wg.res<-rbind(wg.res,res)}
#     }
#     wg.ihs<-ihh2ihs(wg.res)
#   }
# }
# 
# #--------------------------------------------------------------------------------
# ##              Extract iHS results ommitting missing value rows
# ##              Merge iHS results with .map file information
# ##		Extract positions with strong signal of selection iHS(p-val)>=4
# 
# ihs <- na.omit(wg.ihs$ihs)
# mapF <- snpInfo
# ns <- length(wg.res$POSITION)
# print("", quote=F)
# print("Effive number of SNPs (Total Number of SNPs that passed rehh filters)", quote=F)
# print(ns, quote=F)
# print("", quote=F)
# thr <- as.numeric(-log10(0.05/ns))
# 
# if (thr >= 8) {
# 	thresh <- 8
# } else {thresh <- thr}
# 
# print("", quote=F)
# print("Bonferoni Corrected threshold", quote=F)
# print(thresh, quote=F)
# print("", quote=F)
# map <- data.frame(ID=mapF$V1, POSITION=mapF$V3, Anc=mapF$V4, Der=mapF$V5)
# ihsMerge <- merge(map, ihs, by = "POSITION")
# signals <- ihsMerge[ihsMerge[,7]>=thresh,]
# signals <- signals[order(signals[,5]),]
# sigpos <- signals[,2]
# 
# #--------------------------------------------------------------------------------
# ##             			 Save results 
# ##             
# ##              
# 
# write.table(ihs, file = iHSresult, col.names=T, row.names=F, quote=F, sep="\t")
# write.table(wg.ihs$frequency.class, file = iHSfrq, col.names=T, row.names=F, quote=F, sep="\t")
# write.table(signals, file = sigOut, col.names=T, row.names=F, quote=F, sep="\t")
# 
# #----Add Multiple test corrections
# lopP <- read.table(iHSresult, header=T)
# lopP$P <- as.numeric(10^-(lopP$LOGPVALUE))
# lopP$BH_adj_P <- p.adjust(lopP$P, method="BH")
# lopP$Bonf <- p.adjust(lopP$P, method="bonferroni")
# write.table(lopP, file = iHSresult, col.names=T, row.names=F, quote=F, sep='\t')
# 
# # Manhattan PLot of iHS results
# png(iHSplot, height = 700, width = 640, res = NA, units = "px")
# layout(matrix(1:2,2,1))
# manhattanplot(wg.ihs, pval = F, main = iHSmain, threshold = c(-4, 4))
# manhattanplot(wg.ihs, pval = T, main = iHSmain, threshold = c(-thresh, thresh))
# dev.off()
# 
# # Gaussian Distribution and Q-Q plots
# IHS <- wg.ihs$ihs[["IHS"]]
# png(qqPlot, height = 700, width = 440, res = NA, units = "px", type = "cairo")
# layout(matrix(1:2,2,1))
# distribplot(IHS, main="iHS", qqplot = F)
# distribplot(IHS, main="iHS", qqplot = T)
# dev.off()


##-------------------------------------------------------------------------------
##                               Run Rsb
##             
##

#----------------------------First Pop-------------------------------------------
#--------------------------------------------------------------------------------
##		Initialize parameter and output file names
##

sb <- args[1]
ba <- args[2]
fu <- args[3]
outprfx <- args[4]
numchr <- args[5]
thresh <- args[6]
threads <- args[7]
#snpInfo <- read.table("snp.info", header = F, as.is = T)
iHSplot <- paste(outprfx,"iHS.png", sep="")
iHSresult <- paste(outprfx,"iHSresult.txt", sep="")
iHSfrq <- paste(outprfx,"iHSfrq.txt", sep="")
qqPlot <- paste(outprfx,"qqDist.png", sep="")
iHSmain <- paste(outprfx,"-iHS", sep="")
sigOut <- paste(outprfx,"Signals.txt",sep="")


#--------------------------------------------------------------------------------
##              Load .hap and .map files to create hap dataframe
##              Run genome scan and iHS analysis

for(i in 1:numchr) {

  hapFile <- paste(sb,i,".hap",sep="")
  mapFile <- mapFile <- paste(sb,i,".map",sep="")
  data <- data2haplohh(hap_file=hapFile, 
		       map_file=mapFile, 
		       recode.allele = F,
		       min_perc_geno.hap=100, 
		       min_maf=0.05,
		       haplotype.in.columns=TRUE, 
		       chr.name=i)
  res <- scan_hh(data, threads = 10)
  if(i==1){scan_sb<-res}else{scan_sb<-rbind(scan_sb,res)}

}
scan_sb <- na.omit(scan_sb)

#----------------------------Second Pop------------------------------------------
#--------------------------------------------------------------------------------
##              Load .hap and .map files to create hap dataframe
##              Run genome scan and iHS analysis

for(i in 1:numchr) {

  hapFile <- paste(ba,i,".hap",sep="")
  mapFile <- mapFile <- paste(ba,i,".map",sep="")
  data <- data2haplohh(hap_file=hapFile, 
		       map_file=mapFile, 
		       recode.allele = F,
		       min_perc_geno.hap=100, 
		       min_maf=0.05,
		       haplotype.in.columns=TRUE, 
		       chr.name=i)
  res <- scan_hh(data, threads = 10)
  if(i==1){scan_b<-res}else{scan_b<-rbind(scan_b,res)}

}
scan_b <- na.omit(scan_b)

#--------------------------Third Pop--------------------------------------------
#--------------------------------------------------------------------------------
##              Load .hap and .map files to create hap dataframe
##              Run genome scan and iHS analysis

for(i in 1:numchr) {

  hapFile <- paste(fu,i,".hap",sep="")
  mapFile <- mapFile <- paste(fu,i,".map",sep="")
  data <- data2haplohh(hap_file=hapFile, 
		       map_file=mapFile, 
		       recode.allele = F,
		       min_perc_geno.hap=100, 
		       min_maf=0.05,
		       haplotype.in.columns=TRUE, 
		       chr.name=i)
  res <- scan_hh(data, threads = 10)
  if(i==1){scan_fu<-res}else{scan_fu<-rbind(scan_fu,res)}

}
scan_fu <- na.omit(scan_fu)

##-------------------------Run Rsb---------------------------------------------
#--SB vs BA
rsb.res <- ines2rsb(scan_pop1=scan_sb, 
		     scan_pop2=scan_b, 
		     popname1="SB", 
		     popname2="BA")

#-- Make threshold
ns <- length(rsb.res$POSITION)
print("", quote=F)
print("Effive number of SNPs (Total Number of SNPs that passed rehh filters)", quote=F)
print(ns, quote=F)
print("", quote=F)
thr <- as.numeric(-log10(0.05/ns))

if (thr >= 8) {
	sbb_thr <- as.numeric(8)
} else {sbb_thr <- thr}

rsb.sb_b <- na.omit(rsb.res)
cr.sbb <- calc_candidate_regions(rsb.sb_b, 
                                 threshold=4, 
                                 pval=T, 
                                 window_size=1E6, 
                                 overlap=1E5, 
                                 min_n_extr_mrk=2)

#--SB vs FU
rsb.res <- ines2rsb(scan_pop1=scan_sb, 
                     scan_pop2=scan_fu,
                     popname1="SB",
                     popname2="FO")
#-- Make threshold
ns <- length(rsb.res$POSITION)
print("", quote=F)
print("Effive number of SNPs (Total Number of SNPs that passed rehh filters)", quote=F)
print(ns, quote=F)
print("", quote=F)
thr <- as.numeric(-log10(0.05/ns))

if (thr >= 8) {
        sbfu_thr <- 8
} else {sbfu_thr <- thr}

rsb.sb_fu <- na.omit(rsb.res)
cr.sbfu <- calc_candidate_regions(rsb.sb_fu, 
                                  threshold=4, 
                                  pval=T, 
                                  window_size=1E6, 
                                  overlap=1E5, 
                                  min_n_extr_mrk=2)

#--BA vs FU
rsb.res <- ines2rsb(scan_pop1=scan_b,
                     scan_pop2=scan_fu,
                     popname1="BA",
                     popname2="FO")
#-- Make threshold
ns <- length(rsb.res$POSITION)
print("", quote=F)
print("Effive number of SNPs (Total Number of SNPs that passed rehh filters)", quote=F)
print(ns, quote=F)
print("", quote=F)
thr <- as.numeric(-log10(0.05/ns))

if (thr >= 8) {
        bfu_thr <- 8
} else {bfu_thr <- thr}

rsb.b_fu <- na.omit(rsb.res)
cr.bfu <- calc_candidate_regions(rsb.b_fu, 
                                 threshold=4, 
                                 pval=T, 
                                 window_size=1E6, 
                                 overlap=1E5, 
                                 min_n_extr_mrk=2)

#--Write results files
write.table(rsb.sb_b, file = "sbbRsb.txt", col.names=T, row.names=F, quote=F, sep="\t")
write.table(cr.sbb, file = "sbbCR.txt", col.names=T, row.names=F, quote=F, sep="\t")
write.table(rsb.sb_fu, file = "sbfuRsb.txt", col.names=T, row.names=F, quote=F, sep="\t")
write.table(cr.sbfu, file = "sbfuCR.txt", col.names=T, row.names=F, quote=F, sep="\t")
write.table(rsb.b_fu, file = "bfuRsb.txt", col.names=T, row.names=F, quote=F, sep="\t")
write.table(cr.bfu, file = "bfuCR.txt", col.names=T, row.names=F, quote=F, sep="\t")

#--Plot manhattan
png("sbbRsb.png", height = 700, width = 640, res = NA, units = "px")
layout(matrix(1:2,2,1))
manhattanplot(rsb.sb_b, 
              pval = F,
              main = "Rsb: SB vs BA", 
              threshold = c(-4,4))
manhattanplot(rsb.sb_b,
              pval = T,
              main = "Rsb: SB vs BA",
              threshold = c(-sbb_thr,sbb_thr))
dev.off()

png("sbfuRsb.png", height = 700, width = 640, res = NA, units = "px")
layout(matrix(1:2,2,1))
manhattanplot(rsb.sb_fu, 
              pval = F,
              main = "Rsb: SB vs FO", 
              threshold = c(-4,4))
manhattanplot(rsb.sb_fu,
              pval = T,
              main = "Rsb: SB vs FO",
              threshold = c(-sbfu_thr,sbfu_thr))
dev.off()

png("bfuRsb.png", height = 700, width = 640, res = NA, units = "px")
layout(matrix(1:2,2,1))
manhattanplot(rsb.b_fu, 
              pval = F,
              main = "Rsb: BA vs FO", 
              threshold = c(-4,4))
manhattanplot(rsb.b_fu,
              pval = T,
              main = "Rsb: BA vs FO",
              threshold = c(-bfu_thr,bfu_thr))
dev.off()
