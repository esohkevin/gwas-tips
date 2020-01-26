#!/usr/bin/Rscript

args <- commandArgs(TRUE)

############### PER INDIVIDUAL QC ######################
### Plot Heterozygosity vs Missingness
het=read.table(args[1], header = T, as.is = T)
mis=read.table(args[2], header = T, as.is = T)

# save the file reformatted
write.table(het, file = args[1], col.names = T, row.names = F, quote = F, sep = "\t")
write.table(mis, file = args[2], col.names = T, row.names = F, quote = F, sep = "\t")

# Calculate the observed heterozygosity rate per individual by (N(NM) - O(HOM)/N(NM))
mishet=data.frame(FID=het$FID, IID=het$IID, het.rate=(het$N.NM. - het$O.HOM.)/het$N.NM., mis.rate=mis$F_MISS)

# Plot the proportion of missing genotypes and the heterozygosity rate
png(args[3], width = 500, height = 480, units = "px", pointsize = 12,
    bg = "white",  res = NA)
par(mfrow=c(1,1))
plot(mishet$het.rate, mishet$mis.rate, xlab = "Heterozygous rate", ylab = "Proportion of missing genotype", pch=20)
abline(v=c(0.180,0.230), h=0.1, lty=2)
dev.off()

# Extract individuals that will be excluded from further analysis (who didn't pass the filter)
# Individuals with mis.rate > 0.1 (10% missingness)
fail_mis_qc=mishet[mishet$mis.rate > 0.1, ]
write.table(fail_mis_qc[,1:2], file = "fail-mis.qc", row.names = F, col.names = F, quote = F, sep = "\t")

# Individuals with het.rate < 0.18 (previously 0.195) and individuals with het.rate > o.23 (previously 0.22)
#fail_het_qc=mishet[mishet$het.rate < 0.180 | mishet$het.rate > 0.230, ]
#write.table(fail_het_qc[,1:2], file = "fail-het.qc", row.names = F, col.names = F, quote = F, sep = "\t")

