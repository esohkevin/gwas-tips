#!/usr/bin/env Rscript

# Prepare alternative individual files with ethnicity status
eth <- read.table("../merged-data-eth_template.txt", col.names=c("FID", "ETH"), as.is=T)
eigAnceMapInd <- read.table("../CONVERTF/world.ind", col.names=c("FID", "SEX", "Status"), as.is=T)
eigAnceMapIndNoStatus <- data.frame(FID=eigAnceMapInd[,1], SEX=eigAnceMapInd[,2])
neweth <- merge(eigAnceMapIndNoStatus, eth, by="FID")
write.table(neweth, file="../CONVERTF/world-eth.txt", col.names=T, row.names=F, quote=F)

# With region of sample collection
#region <- read.table("../merged-data-eth_template.txt", col.names=c("FID", "IID", "REGION"), as.is=T)
#regionNoIID <- data.frame(FID=region[,1], REGION=region[,3])
#newregion <- merge(eigAnceMapIndNoStatus, regionNoIID, by="FID")
#write.table(newregion, file="../CONVERTF/qc-camgwas-reg.ind", col.names=T, row.names=F, quote=F)
