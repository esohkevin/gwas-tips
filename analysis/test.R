getwd()
setwd("/home/esoh/esohdata/GWAS/analysis/")
dir()
dups <- read.table("duplicates.txt", col.names = c("#FID1", "#IID1", "#FID2", 
                                                   "#IID2", "RT", "EZ", "Z0", 
                                                   "Z1", "Z2", "PI_HAT", "PHE", 
                                                   "DST", "PPC", "RATIO") , as.is = T)
head(dups)
dups1 <- data.frame(dups[,1], dups[,2], dups[,10])
dups2 <- data.frame(FID1=dups[,3], IID2=dups[,4], PI_HAT=dups[,10])
write.table(dups1, file = "dups1.txt", col.names = c("#FID", "#IID", "PI_HAT"), row.names = F, quote = F)
