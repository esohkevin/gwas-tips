#!/usr/bin/Rscript


args <- commandArgs(TRUE)

# Make rehh map file from Plink bim file
bim <- read.table(args[1], col.names=c("CHR", "RSID", "cM", "BP", "A1", "A2"), as.is=T)
newBim <- data.frame(bim$RSID, bim$CHR, bim$BP, bim$A2, bim$A1)
write.table(newBim, file=args[2], col.names=F, row.names=F, quote=F, sep = "\t")

# Update transposed haplotype file
haps <- read.table(args[3])
newhaps <- haps[,6:ncol(haps)]
#hapsUpdated <- data.frame(newBim[,1:3], newhaps)
write.table(newhaps, file = args[4], col.names = F, row.names = F, quote = F)

