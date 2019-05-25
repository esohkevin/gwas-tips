#!/usr/bin/Rscript

#################### Association Test Accounting for Population Structure #########################
if (!requireNamespace("qqman")) 
	install.packages("qqman", repos="http://cloud.r-project.org", ask = F)
library(qqman)

### Now read in assoc data of imputed set after including axes of genetic variation as covariats
###################### Using PC1 and PC2 ##############################
imassoc=read.table("eagle-post-impc1c2.assoc.logistic", header = T, as.is = T)

# Now assess the genomic control inflation factor
median(qchisq(imassoc[,12], df=1, lower.tail = F), na.rm = T)/0.456  

# Now produce association plot
snpsofinterest=imassoc[-log10(imassoc$P)>=6,]
snpsofinterest
#png("im-assoc_qc.png", res = 1200, height =3, width = 6, units = "in")
png(filename = "plink-imp-assocC1C2.png", width = 780, height = 480, units = "px", pointsize = 12, 
    bg = "white",  res = NA)
par(mfrow=c(1,1))
manhattan(imassoc, chr = "CHR", bp = "BP", p = "P", col = c("blue4", "orange3"), 
	  suggestiveline = -log10(1e-05),  genomewideline = -log10(5e-08), highlight = NULL, 
	  logp = T, annotatePval = NULL, annotateTop = T, ylim = c(0, 9))
dev.off()

############################## Using PC1, PC5 and PC9 ################################
imassoc1=read.table("eagle-post-impc1c5c9.assoc.logistic", header = T, as.is = T)

# Now assess the genomic control inflation factor
median(qchisq(imassoc1[,12], df=1, lower.tail = F), na.rm = T)/0.456

# Now produce association plot
snpsofinterest=imassoc1[-log10(imassoc1$P)>=6,]
snpsofinterest
#png("im-assoc_qc.png", res = 1200, height =3, width = 6, units = "in")
png(filename = "plink-imp-assocC1C5C9.png", width = 780, height = 480, units = "px", 
    pointsize = 12, bg = "white",  res = NA)
par(mfrow=c(1,1))
manhattan(imassoc1, chr = "CHR", bp = "BP", p = "P", col = c("blue4", "orange3"),
          suggestiveline = -log10(1e-05),  genomewideline = -log10(5e-08), highlight = NULL, 
	  logp = T, annotatePval = NULL, annotateTop = T, ylim = c(0, 9))
dev.off()

############################# Using All PCs ######################################
imassoc2=read.table("eagle-post-impc1-c10.assoc.logistic", header = T, as.is = T)

# Now assess the genomic control inflation factor
median(qchisq(imassoc2[,12], df=1, lower.tail = F), na.rm = T)/0.456

# Now produce association plot
snpsofinterest=imassoc2[-log10(imassoc2$P)>=6,]
snpsofinterest
#png("im-assoc_qc.png", res = 1200, height =3, width = 6, units = "in")
png(filename = "plink-imp-assocC1-C10.png", width = 780, height = 480, units = "px", 
    pointsize = 12, bg = "white",  res = NA)
par(mfrow=c(1,1))
manhattan(imassoc2, chr = "CHR", bp = "BP", p = "P", col = c("blue4", "orange3"), 
	  suggestiveline = -log10(1e-05),  genomewideline = -log10(5e-08), highlight = NULL, 
	  logp = T, annotatePval = NULL, annotateTop = T, ylim = c(0, 9))
dev.off()

######################## Using All PCs with different MOI #############################
#imassoc3=read.table("eagle-post-impc1-c10-model-updated.model", header = T, as.is = T)

# Now assess the genomic control inflation factor
#median(qchisq(imassoc3[,9], df=1, lower.tail = F), na.rm = T)/0.456

# Now produce association plot
#snpsofinterest=imassoc3[-log10(imassoc3$P)>=6,]
#snpsofinterest
#png("im-assoc_qc.png", res = 1200, height =3, width = 6, units = "in")
#png(filename = "plink-imp-assoc-model.png", width = 780, height = 480, units = "px", pointsize = 12,
#    bg = "white",  res = NA)
#par(mfrow=c(1,1))
#manhattan(imassoc3, chr = "CHR", bp = "BP", p = "P", col = c("blue4", "orange3"),
#          suggestiveline = -log10(1e-05),  genomewideline = -log10(5e-08), highlight = snpsofinterest$SNP, logp = T,
#          annotatePval = 0.0000001, annotateTop = T, ylim = c(0, 9))
#dev.off()

############################ Using All PCs with hethom MOI ##########################
imassoc4=read.table("eagle-post-impc1-c10-hethom-noNA.assoc.logistic", header = T, as.is = T)

# Now assess the genomic control inflation factor
#median(qchisq(imassoc4[,9], df=1, lower.tail = F), na.rm = T)/0.456

# Now produce association plot
snpsofinterest=imassoc4[-log10(imassoc4$P)>=6,]
snpsofinterest
#png("im-assoc_qc.png", res = 1200, height =3, width = 6, units = "in")
png(filename = "plink-imp-assoc-hethom.png", width = 780, height = 480, units = "px", 
    pointsize = 12, bg = "white",  res = NA)
par(mfrow=c(1,1))
manhattan(imassoc4, chr = "CHR", bp = "BP", p = "P", col = c("blue4", "orange3"),
          suggestiveline = -log10(1e-05),  genomewideline = -log10(5e-08), highlight = NULL, 
	  logp = T, annotatePval = NULL, annotateTop = T, ylim = c(0, 9))
dev.off()


# Plot a Q-Q plot for the association analysis
png(filename = "qq-plink-assoc.png", width = 750, height = 800, units = "px", pointsize = 12, bg = "white",  res = NA)
par(mfrow=c(2,2))
qq(imassoc$P, main="Q-Q plot after QC")
qq(imassoc1$P, main="Q-Q plot after QC")
qq(imassoc2$P, main="Q-Q plot after QC")
qq(imassoc4$P, main="Q-Q plot after QC")
dev.off()


