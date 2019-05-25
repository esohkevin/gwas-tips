#!/usr/bin/Rscript

#################### Association Test Accounting for Population Structure #########################
if (!requireNamespace("qqman")) 
	install.packages("qqman", repos="http://cloud.r-project.org", ask = F)
library(qqman)

### Import SNPTEST frequentist association with het MOI
# Using all PCs
psassoc=read.table("auto-imputed-rearranged-fhet.assoc", header = T, as.is = T)

# Now assess the genomic control inflation factor
median(qchisq(psassoc[,9], df=1, lower.tail = F), na.rm = T)/0.456  # 1.077156

# Now produce association plot
snpsofinterest=psassoc[-log10(psassoc$P)>=7,]
#png("im-assoc_qc.png", res = 1200, height =3, width = 7, units = "in")
png(filename = "im-assoc_qc.png", width = 680, height = 400, units = "px", pointsize = 12,
    bg = "white",  res = NA, type = c("quartz"))
#par(mfrow=c(1,1), cex=0.5, mai=c(0.5,0.3,0.5,0.3))
par(mfrow=c(1,1))
manhattan(psassoc, chr = "CHR", bp = "BP", p = "P", col = c("blue4", "orange3"), chrlabs = c(1:22),
          suggestiveline = -log10(1e-05),  genomewideline = -log10(5e-08), highlight = snpofinterest, logp = T,
          annotatePval = -log10(1e-07), annotateTop = T, ylim = c(0, 9), cex = 0.6, cex.axis = 0.9)
dev.off()

# Using PC1, PC5 and PC9
psassoc1=read.table("post-impc1c2.assoc.logistic", header = T, as.is = T)

# Now assess the genomic control inflation factor
median(qchisq(psassoc1[,9], df=1, lower.tail = F), na.rm = T)/0.456 # 1.061969

# Now produce association plot
snpsofinterest=psassoc1[-log10(psassoc1$P)>=7,]
#png("im1-assoc_qc.png", res = 1200, height = 3, width = 7, units = "in")
#par(mfrow=c(1,1), cex=0.5, mai=c(0.5,0.3,0.5,0.3))
png(filename = "im1-assoc_qc.png", width = 680, height = 400, units = "px", pointsize = 12,
    bg = "white",  res = NA, type = c("quartz"))
par(mfrow=c(1,1))
manhattan(psassoc1, chr = "CHR", bp = "BP", p = "P", col = c("blue4", "orange3"), chrlabs = c(1:22),
          suggestiveline = -log10(1e-05),  genomewideline = -log10(5e-08), highlight = snpofinterest, logp = T,
          annotatePval = -log10(1e-07), annotateTop = T, ylim = c(0, 9), cex = 0.6, cex.axis = 0.9)
dev.off()

# Using all PCs
psassoc2=read.table("post-impc1c5c9.assoc.logistic", header = T, as.is = T)

# Now assess the genomic control inflation factor
#median(qchisq(psassoc2[,9], df=1, lower.tail = F), na.rm = T)/0.456

# Now produce association plot
snpsofinterest=psassoc2[-log10(psassoc2$P)>=7,]
#png("im2-assoc_qc.png", res = 1200, height = 3, width = 7, units = "in")
#par(mfrow=c(1,1), cex=0.5, mai=c(0.5,0.3,0.5,0.3))
png(filename = "im2-assoc_qc.png", width = 680, height = 400, units = "px", pointsize = 12,
    bg = "white",  res = NA, type = c("quartz"))
par(mfrow=c(1,1))
manhattan(psassoc2, chr = "CHR", bp = "BP", p = "P", col = c("blue4", "orange3"), chrlabs = c(1:22),
          suggestiveline = -log10(1e-05),  genomewideline = -log10(5e-08), highlight = snpofinterest, logp = T,
          annotatePval = -log10(1e-07), annotateTop = T, ylim = c(0, 9), cex = 0.6, cex.axis = 0.9)
dev.off()

# Run Association for imputed dataset using additive MOI
psassoc3=read.table("post-impc1-c10.assoc.logistic", header = T, as.is = T)
snpsofinterest=psassoc3[-log10(psassoc3$P)>=7,]
#png("im-add-assoc_qc.png", res = 1200, height = 3, width = 6, units = "in")
#par(mfrow=c(1,1), cex=0.5, mai=c(0.5,0.3,0.5,0.3))
png(filename = "im-add-assoc_qc.png", width = 680, height = 400, units = "px", pointsize = 12,
    bg = "white",  res = NA, type = c("quartz"))
par(mfrow=c(1,1))
manhattan(psassoc3, chr = "CHR", bp = "BP", p = "P", col = c("blue4", "orange3"), chrlabs = c(1:22),
          suggestiveline = -log10(1e-05),  genomewideline = -log10(5e-08), highlight = snpofinterest, logp = T,
          annotatePval = -log10(1e-07), annotateTop = T, ylim = c(0, 9), cex = 0.6, cex.axis = 0.9)
dev.off()


# Run Association for imputed dataset using hethom MOI
psassoc4=read.table("post-impc1-c10-hethom-noNA.assoc.logistic", header = T, as.is = T)
snpsofinterest=psassoc4[-log10(psassoc4$P)>=7,]
#png("im-hethom-assoc_qc.png", res = 1200, height = 3, width = 6, units = "in")
#par(mfrow=c(1,1), cex=0.5, mai=c(0.5,0.3,0.5,0.3))
png(filename = "im-hethom-assoc_qc.png", width = 680, height = 400, units = "px", pointsize = 12,
    bg = "white",  res = NA, type = c("quartz"))
par(mfrow=c(1,1))
manhattan(psassoc4, chr = "CHR", bp = "BP", p = "P", col = c("blue4", "orange3"), chrlabs = c(1:22),
          suggestiveline = -log10(1e-05),  genomewideline = -log10(5e-08), highlight = snpofinterest, logp = T,
          annotatePval = -log10(1e-07), annotateTop = T, cex = 0.6, cex.axis = 0.9)
dev.off()


# Plot a Q-Q plot for the association analysis
#png("qq_plots.png", res=1200, height=7, width=7, units="in")
png(filename = "plinkassoc1_qc.png", width = 500, height = 500, units = "px", pointsize = 12,
    bg = "white",  res = NA, type = c("quartz"))
par(mfrow=c(2,2), cex=0.6)
qq(psassoc$P, main="Q-Q plot after QC")
qq(psassoc1$P, main="Q-Q plot after QC")
qq(psassoc2$P, main="Q-Q plot after QC")
dev.off()


