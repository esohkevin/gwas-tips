#################### Association Test #########################
if (!requireNamespace("qqman")) 
	install.packages("qqman")
library(qqman)

assoc2=read.table("qc-camgwas.assoc.logistic", header = T, as.is = T)
#plot(assoc2$BP, -log10(assoc2$P), xlab = "position", ylab = "-log10 p-value", main = "-log10 p-values (after QC)", 
#     pch=16, col=assoc2$CHR)
#abline(h=7, col="red")

snpsofinterest=assoc2[-log10(assoc2$P)>=7,]
png("plinkassoc_qc.png", res = 1200, height = 7, width = 10, units = "in")
par(mfrow=c(1,1))
manhattan(assoc2, chr = "CHR", bp = "BP", p = "P", col = c("gray10", "gray60"), chrlabs = NULL, 
          suggestiveline = -log10(1e-05),  genomewideline = -log10(5e-08), highlight = NULL, logp = T, 
          annotatePval = NULL, annotateTop = T)
dev.off()

# Plot a Q-Q plot for the association analysis
png("qq_plots.png", res=1200, height=5, width=5, units="in")
par(mfrow=c(1,1))
qq(assoc2$P, main="Q-Q plot after QC")
dev.off()

