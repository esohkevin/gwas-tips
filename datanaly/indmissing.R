############### Extract IDs of individuals that failed sex check from the .sexcheck file ##############
sexcheck=read.table("fail-checksex.qc", header = F, as.is = T)
write.table(sexcheck[,1:2], file = "fail-checksex.qc", col.names = F, row.names = F, quote = F, sep = "\t")

############### PER INDIVIDUAL QC ######################
### Plot Heterozygosity vs Missingness
het=read.table("raw-camgwas.het", header = T, as.is = T)
mis=read.table("raw-camgwas.imiss", header = T, as.is = T)

# save the file reformatted
write.table(het, file = "raw-camgwas.het", col.names = T, row.names = F, quote = F, sep = "\t")
write.table(mis, file = "raw-camgwas.imiss", col.names = T, row.names = F, quote = F, sep = "\t")

# Calculate the observed heterozygosity rate per individual by (N(NM) - O(HOM)/N(NM))
mishet=data.frame(FID=het$FID, IID=het$IID, het.rate=(het$N.NM. - het$O.HOM.)/het$N.NM., mis.rate=mis$F_MISS)
#meanhet=mean(mishet$het.rate)
#sdhet=sd(mishet$het.rate, na.rm = F)
#hetupper=meanhet + sdhet*3
#hetlower=meanhet - sdhet*3

# Plot the proportion of missing genotypes and the heterozygosity rate
png("mishet.png", res = 1200, height = 5, width = 7, units = "in")
par(mfrow=c(1,1))
plot(mishet$het.rate, mishet$mis.rate, xlab = "Heterozygous rate", ylab = "Proportion of missing genotype", pch=20)
#abline(v=c(hetlower, hetupper), h=0.1, lty=2)
abline(v=c(0.195,0.22), h=0.1, lty=2)
dev.off()

# Extract individuals that will be excluded from further analysis (who didn't pass the filter)
# Individuals with mis.rate > 0.1 (10% missingness)
fail_mis_qc=mishet[mishet$mis.rate > 0.1, ]
write.table(fail_mis_qc[,1:2], file = "fail-mis.qc", row.names = F, col.names = F, quote = F, sep = "\t")

# Individuals with het.rate < 0.18 (previously 0.195) and individuals with het.rate > o.23 (previously 0.22)
fail_het_qc=mishet[mishet$het.rate < 0.195 | mishet$het.rate > 0.22, ]
write.table(fail_het_qc[,1:2], file = "fail-het.qc", row.names = F, col.names = F, quote = F, sep = "\t")

################ Male Heterozygosity #####################################
#het2=read.table("malesxchr-het.het", header = T, as.is = T)
#mis2=read.table("malesxchr-miss.imiss", header = T, as.is = T)
#mishet2=data.frame(FID=het2$FID, IID=het2$IID, het.rate=(het2$N.NM. - het2$O.HOM.)/het2$N.NM., mis.rate=mis2$F_MISS)
#png("malehet.png", res = 1200, height = 5, width = 7, units = "in")
#par(mfrow=c(1,1))
#plot(mishet2$het.rate, mishet2$mis.rate, xlab = "Heterozygous rate", ylab = "Proportion of missing genotype", pch=20)
#dev.off()

################ Female Heterozygosity #####################################
#het3=read.table("femalesxchr-het.het", header = T, as.is = T)
#mis3=read.table("femalesxchr-miss.imiss", header = T, as.is = T)
#mishet3=data.frame(FID=het3$FID, IID=het3$IID, het.rate=(het3$N.NM. - het3$O.HOM.)/het3$N.NM., mis.rate=mis3$F_MISS)
#png("femalehet.png", res = 1200, height = 5, width = 7, units = "in")
#par(mfrow=c(1,1))
#plot(mishet3$het.rate, mishet3$mis.rate, xlab = "Heterozygous rate", ylab = "Proportion of missing genotype", pch=20)
#dev.off()

