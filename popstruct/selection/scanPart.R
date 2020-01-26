#!/usr/bin/Rscript

library(rehh)
library(data.table)

##---------------------------------------------------------------------------------
##                                        LOCAL
#setwd("~/esohdata/GWAS/popstruct/selection/")
#hapFile <- "chr_chr6.hap"
#mapFile <- "chr_chr6.map"
#chr <- 6
## iHS and cross-Population or whole genome scans

args <- commandArgs(TRUE)

##---------------------------------------------------------------------------------
##		Initialize parameter and output file names			
##			
chr <- args[2]
hapFile <- paste(args[1],".hap", sep="")
mapFile <- paste(args[1],".map", sep="")
iHSplot <- paste(args[3],"iHS.png", sep="")
iHSresult <- paste(args[3],"iHSresult.txt", sep="")
iHSfrq <- paste(args[3],"iHSfrq.txt", sep="")
qqPlot <- paste(args[3],"qqDist.png", sep="")
iHSmain <- paste("chr",chr,"-iHS", sep="")
sigOut <- paste(args[3],"chr",chr,"Signals.txt",sep="")

nsnp <- as.integer(nrow(read.table(mapFile, header=F)))
thresh <- as.integer(0.05/nsnp)

##---------------------------------------------------------------------------------
##              Load .hap and .map files to create hap dataframe
##              Run genome scan and iHS analysis                

hap <- data2haplohh(hap_file = hapFile, map_file = mapFile, recode.allele = F, 
                    min_perc_geno.hap=100,min_maf=0.05, haplotype.in.columns=TRUE, 
                    chr.name = chr)
wg.res <- scan_hh(hap)
wg.ihs <- ihh2ihs(wg.res, freqbin = 0.05)

##---------------------------------------------------------------------------------
##              Extract iHS results ommitting missing value rows
##              Merge iHS results with .map file information
##		Extract positions with strong signal of selection iHS(p-val)>=4

ihs <- na.omit(wg.ihs$ihs)
mapF <- read.table(mapFile)
map <- data.frame(ID=mapF$V1, POSITION=mapF$V3, Anc=mapF$V4, Der=mapF$V5)
ihsMerge <- merge(map, ihs, by = "POSITION")
signals <- ihsMerge[ihsMerge[,7]>=thresh,]
sigpos <- signals[,4]

##---------------------------------------------------------------------------------
##             			 Save results 
##             
##              

write.table(ihs, file = iHSresult, col.names=T, row.names=F, quote=F, sep="\t")
write.table(wg.ihs$frequency.class, file = iHSfrq, col.names=T, row.names=F, quote=F, sep="\t")
write.table(signals, file = sigOut, col.names=T, row.names=F, quote=F, sep="\t")

# Manhattan PLot of iHS results
png(iHSplot, height = 700, width = 640, res = NA, units = "px")
layout(matrix(1:2,2,1))
manhattanplot(wg.ihs, pval = F, main = iHSmain, threshold = c(-as.integer(thresh), as.integer(thresh)))
manhattanplot(wg.ihs, pval = T, main = iHSmain, threshold = c(-thresh, thresh))
dev.off()

# Gaussian Distribution and Q-Q plots
IHS <- wg.ihs$ihs[["IHS"]]
png(qqPlot, height = 700, width = 440, res = NA, units = "px", type = "cairo")
layout(matrix(1:2,2,1))
distribplot(IHS, main="iHS", qqplot = F)
distribplot(IHS, main="iHS", qqplot = T)
dev.off()

##--------------------------------------------------------------------------------
##              Produce bifurcation plot for each signal locus
##             
##             

## # Bifurcation plot
## for (locus in sigpos) {
##   bifurc <- paste(args[3],"bif",locus,".png", sep="")
##   bifAncestMain <- paste(locus,": Ancestral allele", sep="")
##   bifDerivMain <- paste(locus,": Derived allele", sep="")
##   png(bifurc, height = 700, width = 640, res = NA, units = "px", type = "cairo")
##   layout(matrix(1:2,2,1))
##   bifurcation.diagram(hap, mrk_foc = locus, all_foc = 1, nmrk_l = 10, nmrk_r = 10, refsize = 0.05,
##                       main = bifAncestMain)
##   bifurcation.diagram(hap, mrk_foc = locus, all_foc = 2, nmrk_l = 10, nmrk_r = 10, refsize = 0.05,
##                       main=bifDerivMain)
##   dev.off()
## }

