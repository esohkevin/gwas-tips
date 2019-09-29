#!/usr/bin/Rscript

require(data.table)

args <- commandArgs(TRUE)

fn <- args[1]
pr <- args[2]
#pe <- paste0(pr, ".ped")
#ma <- paste0(pr, ".map")
fa <- paste0(pr, ".fam")
#outpe <- paste0(pr, "flk.ped")
#outma <- paste0(pr, "flk.map")
outfa <- paste0(pr, "flk.fam")

eth <- as.data.frame(fread(fn, header=F, nThread = 15))
fam <- as.data.frame(fread(fa, header = F, nThread = 20))
fam$V5 <- as.integer("1")
eth <- data.frame(V3=eth$V3,V2=eth$V2)
hap <- merge(eth, fam, by = "V2")
hap <- hap[,-c(1)]
fwrite(hap, file = outfa, col.names=F, sep = " ", 
	row.names=F, quote=F, nThread = 30, buffMB = 10)
#map <- as.data.frame(fread(ma, nThread = 15))
#fwrite(map, file = outma, col.names=F, row.names=F, 
#	quote=F, sep = " ", nThread = 30, buffMB = 10)

