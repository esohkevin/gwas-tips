#!/usr/bin/Rscript

args <- commandArgs(TRUE)
he <- args[1]
imis <- args[2]
oput <- paste0("mishet_", gsub(".het", ".png", args[1]))

############### Extract IDs of individuals that failed sex check from the .sexcheck file ##############
#sexcheck=read.table("fail-checksex.qc", header = F, as.is = T)
#write.table(sexcheck[,1:2], file = "fail-checksex.qc", col.names = F, row.names = F, quote = F, sep = "\t")

############### PER INDIVIDUAL QC ######################
### Plot Heterozygosity vs Missingness
het=read.table(he, header = T, as.is = T)
mis=read.table(imis, header = T, as.is = T)

# save the file reformatted
write.table(het, file = he, col.names = T, row.names = F, quote = F, sep = "\t")
write.table(mis, file = imis, col.names = T, row.names = F, quote = F, sep = "\t")

# Calculate the observed heterozygosity rate per individual by (N(NM) - O(HOM)/N(NM))
mishet=data.frame(FID=het$FID, IID=het$IID, het.rate=(het$N.NM. - het$O.HOM.)/het$N.NM., mis.rate=mis$F_MISS)
#meanhet=mean(mishet$het.rate)
#sdhet=sd(mishet$het.rate, na.rm = F)
#hetupper=meanhet + sdhet*3
#hetlower=meanhet - sdhet*3

# Plot the proportion of missing genotypes and the heterozygosity rate
png(filename = oput, width = 500, height = 480, units = "px", pointsize = 14,
    bg = "white",  res = NA)
par(mfrow=c(1,1))
plot(mishet$het.rate, mishet$mis.rate, xlab = "Heterozygous rate", ylab = "Proportion of missing genotype", main="Individual Missingness", pch=20)
abline(v=c(0.180,0.230), h=0.1, lty=2)
dev.off()

# Extract individuals that will be excluded from further analysis (who didn't pass the filter)
# Individuals with mis.rate > 0.1 (10% missingness)
fail_mis_qc=mishet[mishet$mis.rate > 0.1, ]
write.table(fail_mis_qc[,1:2], file = "fail-mis.qc", row.names = F, col.names = F, quote = F, sep = "\t")

# Individuals with het.rate < 0.18 (previously 0.195) and individuals with het.rate > o.23 (previously 0.22)
fail_het_qc=mishet[mishet$het.rate < 0.180 | mishet$het.rate > 0.230, ]
write.table(fail_het_qc[,1:2], file = "fail-het.qc", row.names = F, col.names = F, quote = F, sep = "\t")

