#!/usr/bin/Rscript

#################### Association Test #########################
if (!requireNamespace("qqman")) 
	install.packages("qqman", repos="http://cloud.r-project.org", ask = F)
library(qqman)

assoc=read.table("qc-camgwas.assoc.logistic", header = T, as.is = T)
#plot(assoc2$BP, -log10(assoc2$P), xlab = "position", ylab = "-log10 p-value", main = "-log10 p-values (after QC)", 
#     pch=16, col=assoc2$CHR)
#abline(h=7, col="red")

#snpsofinterest=assoc[-log10(assoc$P)>=7,]
png("plinkassoc_qc.png", res = 1200, height = 7, width = 10, units = "in")
par(mfrow=c(1,1))
manhattan(assoc, chr = "CHR", bp = "BP", p = "P", col = c("gray10", "gray60"), chrlabs = NULL, 
          suggestiveline = -log10(1e-05),  genomewideline = -log10(5e-08), highlight = NULL, logp = T, 
          annotatePval = NULL, annotateTop = T)
dev.off()

# Association plot for tests including x-chr with different models
# With --xchr-model 1
assoc1=read.table("xchr1.assoc.logistic", header = T, as.is = T)
#snpsofinterest=assoc1[-log10(assoc1$P)>=7,]
png("plinkassoc1_qc.png", res = 1200, height = 7, width = 10, units = "in")
par(mfrow=c(1,1))
manhattan(assoc1, chr = "CHR", bp = "BP", p = "P", col = c("gray10", "gray60"), chrlabs = NULL,
          suggestiveline = -log10(1e-05),  genomewideline = -log10(5e-08), highlight = NULL, logp = T,
          annotatePval = NULL, annotateTop = T)
dev.off()

# With --xchr-model 2
assoc2=read.table("xchr2.assoc.logistic", header = T, as.is = T)
#snpsofinterest=assoc2[-log10(assoc2$P)>=7,]
png("plinkassoc2_qc.png", res = 1200, height = 7, width = 10, units = "in")
par(mfrow=c(1,1))
manhattan(assoc2, chr = "CHR", bp = "BP", p = "P", col = c("gray10", "gray60"), chrlabs = NULL,
          suggestiveline = -log10(1e-05),  genomewideline = -log10(5e-08), highlight = NULL, logp = T,
          annotatePval = NULL, annotateTop = T)
dev.off()

# With --xchr-model 3
assoc3=read.table("xchr3.assoc.logistic", header = T, as.is = T)
#snpsofinterest=assoc3[-log10(assoc3$P)>=7,]
png("plinkassoc3_qc.png", res = 1200, height = 7, width = 10, units = "in")
par(mfrow=c(1,1))
manhattan(assoc1, chr = "CHR", bp = "BP", p = "P", col = c("gray10", "gray60"), chrlabs = NULL,
          suggestiveline = -log10(1e-05),  genomewideline = -log10(5e-08), highlight = NULL, logp = T,
          annotatePval = NULL, annotateTop = T)
dev.off()

# Plot a Q-Q plot for the association analysis
png("qq_plots.png", res=1200, height=10, width=10, units="in")
par(mfrow=c(2,2))
qq(assoc$P, main="Q-Q plot after QC")
qq(assoc1$P, main="Q-Q plot after QC")
qq(assoc2$P, main="Q-Q plot after QC")
qq(assoc3$P, main="Q-Q plot after QC")
dev.off()

# Assess the genomic control inflation factor of the association tests
median(qchisq(assoc[,12], df=1, lower.tail = F), na.rm = T)/0.456   # 1.101992
median(qchisq(assoc1[,12], df=1, lower.tail = F), na.rm = T)/0.456  # 1.162316
median(qchisq(assoc2[,12], df=1, lower.tail = F), na.rm = T)/0.456  # 1.161274
median(qchisq(assoc3[,12], df=1, lower.tail = F), na.rm = T)/0.456  # 1.158149

