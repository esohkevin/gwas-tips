#!/usr/bin/Rscript

setwd("/home/esoh/Git/GWAS/popstruct/eig/EIGENSTRAT")

#----Load libraries
require(colorspace)
require(data.table)
#require(ggbiplot)
# Save evec data into placeholder
args <- commandArgs(TRUE)

#----Initialize files
#fa <- "cor.pca.evec"
#fb <- "cor-fst.pca.evec"
fn <- "cor-fst.pca.evec"
fn <- args[1]
fbase <- gsub(".pca.evec", "", fn)
out_text <- paste0(fbase, ".pca.txt")
qc_eth <- "../../../samples/qc-camgwas.eth"
qc_pops <- "../../../samples/qc-camgwas.pops"
ps_image <- paste0(fbase, ".png")

#----Define Colors
#n <- 3
#pcol <- qualitative_hcl(n, h =80, c = 50, l = 90, alpha = 0.9)

#----Load eigenvector file
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


#----Save rearranged PCA file
fm <- evecDat
write.table(fm, file = out_text, col.names=T, row.names=F, quote=F, sep="\t")

#----Include ethnicity in evec file
eth <- fread(qc_eth, header = T, col.names = c("FID", "ethnicity"), nThread = 4)
evecthn <- merge(evecDat, eth, by="FID")

#----Import Population groups from popstruct directory
popGroups <- read.table(qc_pops, col.names=c("FID", "PopGroup"))
mergedEvecDat <- merge(evecDat, popGroups, by="FID")

#----Import the data file containing ethnicity column
#evecthn=read.table("qc-camgwas-ethni.evec", header=T, as.is=T)
evecthn <- evecthn[order(ethnicity),]

#----Plot First 2 evecs with ethnicity distinction
png(filename = ps_image, width = 18, height = 15, 
    units = "cm", pointsize = 10,
    bg = "white",  res = 200, type = c("cairo"))
par(mfrow = c(2,2))
par(mar=c(4,5,1,1), cex = 0.8)

#----Set Colors
hcl_palettes(type = "qualitative")
n <- length(levels(as.factor(evecthn$ethnicity)))
pcol <- qualitative_hcl(n, palette = "Dark 2", 
                        h = c(0,200), c = 85,l = 45, rev = F)

plot(evecthn$C1, evecthn$C2, xlab="PC1", 
     ylab="PC2", pch = 20, col = "white")
d <- evecthn[evecthn$ethnicity=="BA",]
points(d$C1,d$C2, col="green", pch = 20)
d <- evecthn[evecthn$ethnicity=="FO",]
points(d$C1,d$C2, col="red", pch = 20)
d <- evecthn[evecthn$ethnicity=="SB",]
points(d$C1,d$C2, col="blue", pch = 20)
#d <- evecthn[evecthn$ethnicity=="SB",]
#points(d$C1,d$C3, col=pcol[4], pch = 20)
#d <- evecthn[evecthn$ethnicity=="SBM",]
#points(d$C1,d$C3, col=pcol[5], pch = 20)
legend("topleft", 
       legend=levels(as.factor(evecthn$ethnicity)),
       col=c("green","red","blue"), pch=18, bty="n", cex = 1)
#dev.off()

plot(evecthn$C1, evecthn$C3, xlab="PC1", 
     ylab="PC3", pch = 20, col = "white")
d <- evecthn[evecthn$ethnicity=="BA",]
points(d$C1,d$C3, col="green", pch = 20)
d <- evecthn[evecthn$ethnicity=="FO",]
points(d$C1,d$C3, col="red", pch = 20)
d <- evecthn[evecthn$ethnicity=="SB",]
points(d$C1,d$C3, col="blue", pch = 20)
#d <- evecthn[evecthn$ethnicity=="SB",]
#points(d$C1,d$C3, col=pcol[4], pch = 20)
#d <- evecthn[evecthn$ethnicity=="SBM",]
#points(d$C1,d$C3, col=pcol[5], pch = 20)
legend("topleft", 
       legend=levels(as.factor(evecthn$ethnicity)),
       col=c("green","red","blue"), pch=18, bty="n", cex = 1)
#dev.off()

plot(evecthn$C1, evecthn$C4, xlab="PC1", 
     ylab="PC4", pch = 20, col = "white")
d <- evecthn[evecthn$ethnicity=="BA",]
points(d$C1,d$C4, col="green", pch = 20)
d <- evecthn[evecthn$ethnicity=="FO",]
points(d$C1,d$C4, col="red", pch = 20)
d <- evecthn[evecthn$ethnicity=="SB",]
points(d$C1,d$C4, col="blue", pch = 20)
#d <- evecthn[evecthn$ethnicity=="SB",]
#points(d$C1,d$C3, col=pcol[4], pch = 20)
#d <- evecthn[evecthn$ethnicity=="SBM",]
#points(d$C1,d$C3, col=pcol[5], pch = 20)
legend("bottomright", 
       legend=levels(as.factor(evecthn$ethnicity)),
       col=c("green","red","blue"), pch=18, bty="n", cex = 1)
#dev.off()

plot(evecthn$C2, evecthn$C3, xlab="PC2", 
     ylab="PC3", pch = 20, col = "white")
d <- evecthn[evecthn$ethnicity=="BA",]
points(d$C2,d$C3, col="green", pch = 20)
d <- evecthn[evecthn$ethnicity=="FO",]
points(d$C2,d$C3, col="red", pch = 20)
d <- evecthn[evecthn$ethnicity=="SB",]
points(d$C2,d$C3, col="blue", pch = 18)
#d <- evecthn[evecthn$ethnicity=="SB",]
#points(d$C1,d$C3, col=pcol[4], pch = 20)
#d <- evecthn[evecthn$ethnicity=="SBM",]
#points(d$C1,d$C3, col=pcol[5], pch = 20)
legend("topright", 
       legend=levels(as.factor(evecthn$ethnicity)),
       col=c("green","red","blue"), pch=18, bty="n", cex = 1)
dev.off()

n <- length(levels(as.factor(evecthn$ethnicity)))
pcol <- qualitative_hcl(n, h=c(0,360*(n-1)/n), c = 80, l = 60)
plot(evecDat[,-c(1:2,13)], pch = 20, cex = 0.6, bty = "n", col = pcol)


