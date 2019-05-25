#!/usr/bin/Rscript
if (!requireNamespace("qqman"))
        install.packages("qqman", repos="http://cloud.r-project.org", ask = F)
library(qqman)

psassoc2=read.table("ps2-qc-camgwas.assoc.logistic", header = T, as.is = T)

# Now assess the genomic control inflation factor
median(qchisq(psassoc2[,9], df=1, lower.tail = F), na.rm = T)/0.456

# Now produce association plot
snpsofinterest=psassoc2[-log10(psassoc2$P)>=7,]
#png("ps2-assoc_qc.png", res = 1200, height = 4, width = 7, units = "in")
png(filename = "ps2-assoc_qc.png", width = 780, height = 450, units = "px", pointsize = 12,
    bg = "white",  res = NA, type = c("quartz"))
par(mfrow=c(1,1))
manhattan(psassoc2, chr = "CHR", bp = "BP", p = "P", col = c("blue4", "orange3"), chrlabs = NULL,
          suggestiveline = -log10(1e-05),  genomewideline = -log10(5e-08), highlight = snpsofinterest$SNP, logp = T,
          annotatePval = 1e-6, annotateTop = T, ylim = c(0,9))
dev.off()


