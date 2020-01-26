setwd("~/esohdata/GWAS/popstruct/haploanalysis/")

#install.packages("plot3D")

library(data.table)
library(plot3D)
maf <- fread(input = "qc-camgwas-cntr.frq.strat")
head(maf)
attach(maf)

barplot(maf_tab_filt, col = 1:length(levels(CLST)), beside = T)
dev.off()
plot()

sba_only <- maf[MAF==0]
head(sba_only)

hist(MAF[CLST=="BA"],breaks=200, col=2, labels =F, 
     main="Minor Allele Frequency Spectrum - HBB Region", xlab="MAF", ylab="Allele Count", plot = T, probability = !freq) 
hist(MAF[CLST=="SB"],breaks=200, col=1, labels =F, add=T, density = T, plot = T)
#hist(MAF[CLST=="FO"],breaks=200, col=3, labels =F, add=T)   
#hist(CLST=="ESN", xlim=c(0,0.50),breaks=300, col=5, labels =F, add=T)   
#hist(CLST=="MSL", xlim=c(0,0.50),breaks=100, col=6, labels =F, add=T)    
#hist(CLST=="CAM", xlim=c(0,0.50),breaks=100, col=7, labels =F, add=T)     
legend("topright", c("BA", "SB","FO"), pch=16, col = c(2,1,3), horiz=F, bty="n")
dev.off()

