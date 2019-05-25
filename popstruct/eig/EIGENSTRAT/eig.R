#!/usr/bin/Rscript

# Save evec data into placeholder
fn <- "eig-corr-camgwas.pca.evec"
pcaDat <- read.table(fn, header=F, as.is=T)

evecDat <- data.frame(FID=pcaDat[,1], IID=pcaDat[,1], C1=pcaDat[,2], C2=pcaDat[,3], C3=pcaDat[,4], 
			C4=pcaDat[,5], C5=pcaDat[,6], C6=pcaDat[,7], C7=pcaDat[,8], C8=pcaDat[,9], 
			C9=pcaDat[,10], C10=pcaDat[,11], Status=pcaDat[,32])
fm <- evecDat[,1:12]
write.table(fm, file = "eig-corr-camgwas.pca.txt", col.names=T, row.names=F, quote=F, sep="\t")

ethnicity <- read.table("../../../samples/qc-camgwas.eth", header = T, as.is = T)
evecthn <- merge(evecDat, ethnicity, by="FID")

############## Import Population groups from popstruct directory ################
popGroups <- read.table("../../../samples/qc-camgwas.pops", col.names=c("FID", "PopGroup"))
mergedEvecDat <- merge(evecDat, popGroups, by="FID")


####################### Plot for top 2 vectors ##################################
png(filename = "evec1vc2.png", width = 450, height = 750, units = "px", pointsize = 12, 
    bg = "white",  res = NA, type = c("quartz"))
# type =c("cairo", "cairo-png", "Xlib", "quartz")
par(mfrow=c(2,1))
plot(evecDat$C1, evecDat$C2, xlab="eigenvalue1", ylab="eigenvalue2", main="Eigenanalysis With Sample Status")
d <- evecDat[evecDat$Status=="Case",]
points(d$C1, d$C2, col=2, pch=20)
d <- evecDat[evecDat$Status=="Control",]
points(d$C1, d$C2, col=1, pch=20)
legend("topleft", c("Case", "Control"), col=c(2,1), pch=20)
plot(mergedEvecDat$C1, mergedEvecDat$C2, col=mergedEvecDat$PopGroup, 
	main="Eigenanalysis With Sample Region", xlab="eigenvalue1", ylab="eigenvalue2", pch=20)
legend("topleft", legend=levels(mergedEvecDat$PopGroup), col=1:length(levels(mergedEvecDat$PopGroup)), pch=20)
dev.off()

################### Plot for 6 pairs of eigenvalues #######################
png(filename = "eigenv1-v10.png", width = 890, height = 600, units = "px", pointsize = 12,
    bg = "white",  res = NA, type = c("cairo-png"))
par(mfrow=c(2,3))
plot(evecDat$C1, evecDat$C2, xlab="C1", ylab="C2", pch=20, main="C1 Vs C2")
d <- evecDat[evecDat$Status=="Case",]
points(d$C1, d$C2, col=2, pch=20)
d <- evecDat[evecDat$Status=="Control",]
points(d$C1, d$C2, col=1, pch=20)
legend("topleft", c("Case", "Control"), col=c(2,1), pch=20, bty="n")
plot(evecDat$C3, evecDat$C4, xlab="C3", ylab="C4", pch=20, main="C3 Vs C4")
d <- evecDat[evecDat$Status=="Case",]
points(d$C3, d$C4, col=2, pch=20)
d <- evecDat[evecDat$Status=="Control",]
points(d$C3, d$C4, col=1, pch=20)
legend("topright", c("Case", "Control"), col=c(2,1), pch=20, bty="n")
plot(evecDat$C5, evecDat$C6, xlab="C5", ylab="C6", pch=20, main="C5 Vs C6")
d <- evecDat[evecDat$Status=="Case",]
points(d$C5, d$C6, col=2, pch=20)
d <- evecDat[evecDat$Status=="Control",]
points(d$C5, d$C6, col=1, pch=20)
legend("topright", c("Case", "Control"), col=c(2,1), pch=20, bty="n")
plot(evecDat$C7, evecDat$C8, xlab="C7", ylab="C8", pch=20, main="C7 Vs C8")
d <- evecDat[evecDat$Status=="Case",]
points(d$C7, d$C8, col=2, pch=20)
d <- evecDat[evecDat$Status=="Control",]
points(d$C7, d$C8, col=1, pch=20)
legend("topright", c("Case", "Control"), col=c(2,1), pch=20, bty="n")
plot(evecDat$C9, evecDat$C10, xlab="C9", ylab="C10", pch=20, main="C9 Vs C10")
d <- evecDat[evecDat$Status=="Case",]
points(d$C9, d$C10, col=2, pch=20)
d <- evecDat[evecDat$Status=="Control",]
points(d$C9, d$C10, col=1, pch=20)
legend("topright", c("Case", "Control"), col=c(2,1), pch=20, bty="n")
plot(evecDat$C1, evecDat$C5, xlab="C1", ylab="C5", pch=20, main="C1 Vs C5")
d <- evecDat[evecDat$Status=="Case",]
points(d$C1, d$C5, col=2, pch=20)
d <- evecDat[evecDat$Status=="Control",]
points(d$C1, d$C5, col=1, pch=20)
legend("topleft", c("Case", "Control"), col=c(2,1), pch=20, bty="n")
dev.off()

############# Import the data file containing ethnicity column #################
#evecthn=read.table("qc-camgwas-ethni.evec", header=T, as.is=T)

######### Plot First 2 evecs with ethnicity distinction ##########
png(filename = "evec_with_ethn.png", width = 510, height = 510, units = "px", pointsize = 12,
    bg = "white",  res = NA, type = c("quartz"))
plot(evecthn$C1, evecthn$C2, col=as.factor(evecthn$ethnicity), main="Eigenanalysis With Ethnicity", 
     xlab="eigenvalue1", ylab="eigenvalue2", pch=20)
legend("topleft", legend=levels(as.factor(evecthn$ethnicity)), 
       col=1:length(levels(as.factor(evecthn$ethnicity))), pch=20)
dev.off()

##### Project Case-Control status and Ethnicity Along the three interesting eigenvalues ######
png(filename = "eigenv-select.png", width = 890, height = 600, units = "px", pointsize = 12,
    bg = "white",  res = NA, type = c("cairo-png"))
par(mfrow=c(2,3))

# Ethnic affiliations
plot(evecthn$C1, evecthn$C2, xlab="C1", ylab="C2", pch=20, main="C1 Vs C2 - Ethnicity")
d <- evecthn[evecthn$ethnicity=="BA",]
points(d$C1, d$C2, col=2, pch=20)
d <- evecthn[evecthn$ethnicity=="SB",]
points(d$C1, d$C2, col=1, pch=20)
d <- evecthn[evecthn$ethnicity=="FO",]
points(d$C1, d$C2, col=3, pch=20)
legend("topleft", c("BA", "SB", "FO"), col=c(2,1,3), pch=20, bty="n")
plot(evecthn$C3, evecthn$C4, xlab="C3", ylab="C4", pch=20, main="C3 Vs C4 - Ethnicity")
d <- evecthn[evecthn$ethnicity=="BA",]
points(d$C3, d$C4, col=2, pch=20)
d <- evecthn[evecthn$ethnicity=="SB",]
points(d$C3, d$C4, col=1, pch=20)
d <- evecthn[evecthn$ethnicity=="FO",]
points(d$C3, d$C4, col=3, pch=20)
legend("topright", c("BA", "SB", "FO"), col=c(2,1,3), pch=20, bty="n")
plot(evecthn$C1, evecthn$C5, xlab="C1", ylab="C5", pch=20, main="C1 Vs C5 - Ethnicity")
d <- evecthn[evecthn$ethnicity=="BA",]
points(d$C1, d$C2, col=2, pch=20)
d <- evecthn[evecthn$ethnicity=="SB",]
points(d$C1, d$C5, col=1, pch=20)
d <- evecthn[evecthn$ethnicity=="FO",]
points(d$C1, d$C5, col=3, pch=20)
legend("topleft", c("BA", "SB", "FO"), col=c(2,1,3), pch=20, bty="n")

# Involving mixed reports
plot(mergedEvecDat$C1, mergedEvecDat$C2, xlab="C1", ylab="C2", pch=20, main="C1 Vs C2 - Population Group")
d <- mergedEvecDat[mergedEvecDat$PopGroup=="BUE",]
points(d$C1, d$C2, col=4, pch=20)
d <- mergedEvecDat[mergedEvecDat$PopGroup=="DOU",]
points(d$C1, d$C2, col=5, pch=20)
d <- mergedEvecDat[mergedEvecDat$PopGroup=="YDE",]
points(d$C1, d$C2, col=6, pch=20)
legend("topleft", c("BUE", "DOU", "YDE"), col=c(4,5,6), pch=20, bty="n")
plot(mergedEvecDat$C3, mergedEvecDat$C4, xlab="C3", ylab="C4", pch=20, main="C3 Vs C4 - Population Group")
d <- mergedEvecDat[mergedEvecDat$PopGroup=="BUE",]
points(d$C3, d$C4, col=4, pch=20)
d <- mergedEvecDat[mergedEvecDat$PopGroup=="DOU",]
points(d$C3, d$C4, col=5, pch=20)
d <- mergedEvecDat[mergedEvecDat$PopGroup=="YDE",]
points(d$C3, d$C4, col=6, pch=20)
legend("topright", c("BUE", "DOU", "YDE"), col=c(4,5,6), pch=20, bty="n")
plot(mergedEvecDat$C1, mergedEvecDat$C5, xlab="C1", ylab="C5", pch=20, main="C1 Vs C5 - Population Group")
d <- mergedEvecDat[mergedEvecDat$PopGroup=="BUE",]
points(d$C1, d$C5, col=4, pch=20)
d <- mergedEvecDat[mergedEvecDat$PopGroup=="DOU",]
points(d$C1, d$C5, col=5, pch=20)
d <- mergedEvecDat[mergedEvecDat$PopGroup=="YDE",]
points(d$C1, d$C5, col=6, pch=20)
legend("topleft", c("BUE", "DOU", "YDE"), col=c(4,5,6), pch=20, bty="n")

dev.off()

