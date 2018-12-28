############ GWAS TUTORIAL ######################
### Plot Heterozygosity vs Missingness
het=read.table("raw-GWA-data.het", header = T, as.is = T)
mis=read.table("raw-GWA-data.imiss", header = T, as.is = T)

# Calculate the observed heterozygosity rate per individual by (N(NM) - O(HOM)/N(NM))
misthet=data.frame(FID=het$FID, IID=het$IID, het.rate=(het$N.NM. - het$O.HOM.)/het$N.NM., mis.rate=mis$F_MISS)

# Plot the proportion of missing genotypes and the heterozygosity rate
png("mishet.png", res = 1200, height = 5, width = 5, units = "in")
plot(misthet$het.rate, misthet$mis.rate, xlab = "Heterozygosity rate", ylab = "Proportion of missing genotypes", pch=16)
abline(h=0.05, lty=2)
abline(v=c(0.315,0.37), lty=2)
dev.off()

# Extract IDs of individuals failing missing and heterozygoisity qc
fail.mis=misthet[misthet$mis.rate>0.05,]
fail.mis
fail.het=misthet[misthet$het.rate<0.315 | misthet$het.rate>9.37,]
fail.het
write.table(fail.mis, file = "fail-mis-qc.txt", col.names = T, row.names = F, quote = F)
write.table(fail.het, file = "fail-het-qc.txt", col.names = T, row.names = F, quote = F)

# Identify duplicate and related individuals
genome=read.table("raw-GWA-data.genome", header = T, as.is = T)
genome=genome[genome$PI_HAT>0.1875,]

# compute mean IBD
mean.ibd=0*genome$Z0 + 1*genome$Z1 + 2*genome$Z2

# compute var(IBD)
var.ibd=((0 - mean.ibd)^2) * genome$Z0 +
           ((1 - mean.ibd)^2) * genome$Z1 +
           ((2 - mean.ibd)^2) * genome$Z2

# Compute SE (IBD)
se.ibd=sqrt(var.ibd)
png("ibd.png", res = 1200, height = 5, width = 5, units = "in")
plot(mean.ibd, se.ibd, xlab = "Mean IBD", ylab = "SE IBD")
dev.off()

# Extract the IDs of duplicate or related individuals for subsequent removal
duplicate=genome[mean.ibd == 2,]
duplicate
related=genome[mean.ibd == 1,]

# Check each of the pairs in the .imiss file to remove those with low call rates
fail.ibd.qc=data.frame(FID=duplicate$FID2, IID=duplicate$IID2)
write.table(fail.ibd.qc, file = "fail_ibd_qc.txt", row.names = F, col.names = F, quote = F)
fail.ibd1.qc=data.frame(FID1=duplicate$FID1, IID1=duplicate$IID1)
write.table(fail.ibd1.qc, file = "fail_ibd1_qc.txt", row.names = F, col.names = F, quote = F)

# 