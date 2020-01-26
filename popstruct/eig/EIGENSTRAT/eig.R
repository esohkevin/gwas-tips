#!/usr/bin/Rscript

#setwd("/home/esoh/esohdata/GWAS/popstruct/eig/EIGENSTRAT")

#-------Load libraries
require(colorspace)
require(data.table)

# Save evec data into placeholder
args <- commandArgs(TRUE)

#-------Initialize files
fn <- "pop.pca.evec"
fn <- args[1]
fbase <- gsub(".pca.evec", "", fn)
out_text <- paste0(fbase, ".pca.txt")
eth_image <- paste0(fbase, "c1v2.eth.png")
reg_image <- paste0(fbase, "c1v2.reg.png")
evec10 <- paste0(fbase, "c1-10.png")
evec2 <- paste0(fbase, "c1v2.png")
qc_eth <- "../../../samples/qc-camgwas.eth"
qc_pops <- "../../../samples/qc-camgwas.pops"

#----Define Colors
n <- 3
pcol <- qualitative_hcl(n, h =80, c = 50, l = 90, alpha = 0.9)

#--------Load eigenvector file
pcaDat <- fread(fn, header=F, nThread = 4)

if (ncol(pcaDat) == 31) {
    evecDat <- data.table(pcaDat[,1], pcaDat[,1], pcaDat[,2], pcaDat[,3], pcaDat[,4], 
                          pcaDat[,5], pcaDat[,6], pcaDat[,7], pcaDat[,8], pcaDat[,9], 
                          pcaDat[,10], pcaDat[,11], pcaDat[,12], pcaDat[,13], pcaDat[,14],
                          pcaDat[,15], pcaDat[,16], pcaDat[,17], pcaDat[,18], pcaDat[,19],
                          pcaDat[,20], pcaDat[,21], pcaDat[,22], pcaDat[,23], pcaDat[,24],
                          pcaDat[,25], pcaDat[,26], pcaDat[,27], pcaDat[,28], pcaDat[,29],
                          pcaDat[,30], pcaDat[,31], pcaDat[,32])
    
    colnames(evecDat) <- c("FID", "IID", "C1", "C2", "C3", "C4", "C5", "C6", 
                          "C7", "C8", "C9", "C10", "C11", "C12", "C13", "C14", 
                          "C15", "C16", "C17", "C18", "C19", "C20", "C21", "C22", 
                          "C23", "C24", "C25", "C26", "C27", "C28", "C29", "C30", 
                          "Status")

} else {
    evecDat <- data.table(pcaDat[,1], pcaDat[,1], pcaDat[,2], pcaDat[,3], pcaDat[,4],
                          pcaDat[,5], pcaDat[,6], pcaDat[,7], pcaDat[,8], pcaDat[,9],
                          pcaDat[,10], pcaDat[,11], pcaDat[,12])
    
    colnames(evecDat) <- c("FID", "IID", "C1", "C2", "C3", "C4", "C5", "C6", 
                          "C7", "C8", "C9", "C10", "Status")
}


#-------Save rearranged PCA file
fm <- evecDat
write.table(fm, file = out_text, col.names=T, row.names=F, quote=F, sep="\t")

#-------Include ethnicity in evec file
eth <- fread(qc_eth, header = T, nThread = 4)
evecthn <- merge(evecDat, eth, by="FID")

#-------Import Population groups from popstruct directory
popGroups <- read.table(qc_pops, col.names=c("FID", "PopGroup"))
mergedEvecDat <- merge(evecDat, popGroups, by="FID")

#-------Plot for top 2 vectors for casecontrol status
png(filename = evec2, width = 450, height = 750, units = "px", pointsize = 12, 
    bg = "white",  res = NA, type = c("quartz"))
n <- 1:length(levels(mergedEvecDat$Status))
par(mfrow=c(2,1))
plot(evecDat$C1, evecDat$C2, xlab="PC1", ylab="PC2", main="Eigenanalysis With Sample Status")
d <- evecDat[evecDat$Status=="Case",]
points(d$C1, d$C2, col=2, pch=20)
d <- evecDat[evecDat$Status=="Control",]
points(d$C1, d$C2, col=1, pch=20)
legend("topleft", c("Case", "Control"), col=pcol, pch=20)
plot(mergedEvecDat$C1, mergedEvecDat$C2, col=pcol, 
	main="Eigenanalysis With Sample Region", xlab="PC1", ylab="PC2", pch=20)
n <- 1:length(levels(mergedEvecDat$PopGroup))
legend("topleft", legend=levels(mergedEvecDat$PopGroup), col=pcol, pch=20)
dev.off()

#-------Plot for 6 pairs of eigenvalues for casecontrol status
png(filename = evec10, width = 890, height = 600, units = "px", pointsize = 12,
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

#--------Import the data file containing ethnicity column
#evecthn=read.table("qc-camgwas-ethni.evec", header=T, as.is=T)
evecthn <- evecthn[order(ethnicity),]
hcl_palettes(type = "qualitative")
#--------Plot First 2 evecs with ethnicity distinction
png(filename = eth_image, width = 16, height = 17, units = "cm", pointsize = 14,
    bg = "white",  res = 100, type = c("cairo"))
n <- length(levels(as.factor(evecthn$ethnicity)))
pcol <- qualitative_hcl(n, palette = "Dark 3", alpha = 0.6, h = 195, c = 200, l = 20, fixup = TRUE)
plot(evecthn$C1, evecthn$C2, xlab="PC1", ylab="PC2", pch = 1)
d <- evecthn[evecthn$ethnicity=="BA",]
points(d$C1,d$C2, col=pcol[1], pch = 20)
d <- evecthn[evecthn$ethnicity=="FO",]
points(d$C1,d$C2, col=pcol[2], pch = 20)
d <- evecthn[evecthn$ethnicity=="SB",]
points(d$C1,d$C2, col=pcol[3], pch = 20)
legend("topright", legend=levels(as.factor(evecthn$ethnicity)),
       col=pcol, pch=20, bty="n")
dev.off()

#--------Project Case-Control status and Ethnicity Along the three interesting eigenvalues
png(filename = "eigenv-select.png", width = 890, height = 600, units = "px", pointsize = 12,
    bg = "white",  res = NA, type = c("cairo-png"))
par(mfrow=c(2,3))

#--------Ethnic affiliations
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

#-------Involving mixed reports
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
