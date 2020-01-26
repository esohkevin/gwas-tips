#!/usr/bin/Rscript

library(rehh)

args <- commandArgs(TRUE)

#--------------------------------------------------------------------------------
##		Initialize parameter and output file names			
##										
inprfx <- args[1]
outprfx <- args[2]
marker <- args[3]
outpng <- paste0(args[4],".png")
pmain <- paste0("Haplotype furcations around ",args[4])
iHSmain <- paste(outprfx,"-iHS", sep="")
sigOut <- paste(outprfx,"Signals.txt",sep="")


#--------------------------------------------------------------------------------
##              Load .hap and .map files to create hap dataframe
##              Run genome scan and iHS analysis                

for(i in 1:numchr) {
  
  hapFile <- paste(inprfx,i,".hap",sep="")
  mapFile <- mapFile <- paste(inprfx,i,".map",sep="")
  hap <- data2haplohh(hap_file=hapFile, 
                      map_file=mapFile, 
                      recode.allele = F,
                      min_perc_geno.hap=100, 
                      min_maf=0.05, 
                      haplotype.in.columns=TRUE, 
                      chr.name=i)
  #res <- scan_hh(data, threads = 10)
  #if(i==1){wg.res<-res}else{wg.res<-rbind(wg.res,res)}
  
}

#wg.ihs<-ihh2ihs(wg.res)

## Compute EHH
png(outpng, height = 700, width = 500, units = "px", type = "cairo")
par(mfrow=c(3,1))
res.ehh <- calc_furcation(hap, mrk = marker,  ylab="EHH", main = pmain)
dev.off()

