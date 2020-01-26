#!/usr/bin/Rscript

wld <- read.table("igsr_pops.txt", header=T, as.is=T)
wld_sorted <- wld[order(wld[,4], wld[,3]),]
write.table(wld_sorted, file = "sorted_igsr_pops.txt", col.names=T, row.names=F, quote=F, sep="\t")


cam <- read.table("qc-camgwas1185.eth", col.names = c("Sample", "Sex", "popCode", "popGroup"), as.is=T)
cam_sorted <- cam[order(cam[,4], cam[,3]),]
write.table(cam_sorted, file = "sorted_cam1185.eth", col.names=T, row.names=F, quote=F, sep="\t")



#all <- rbind(wld,cam)
#all_sorted <- all[order(all[,4], all[,3]),]
#
#write.table(all_sorted, file = "eth_world_pops.txt", col.names=T, row.names=F, quote=F, sep="\t")
