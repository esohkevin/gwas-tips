#!/usr/bin/Rscript

if (!requireNamespace("qqman"))
        install.packages("qqman", repos="http://cloud.r-project.org", ask = F)
library(qqman)

# Prepare files for qqman to handle
# fhet
fhet <- read.table("auto-imputed-fhet-assoc.txt", col.names=c("ID", "rs", "CHR", "BP", "REF", "ALT", "P", "Beta"), header=T) 
rearrangefhet=data.frame(CHR=fhet[,3],SNP=fhet[,2],BP=fhet[,4],A1=fhet[,5],A2=fhet[,6],AltID=fhet[,1],altID=fhet[,1],OR=fhet[,8],P=fhet[,7])
write.table(rearrangefhet, file="auto-imputed-rearranged-fhet.assoc", col.names=T, row.names=F, quote=F, sep="\t")

# fadd
fadd <- read.table("auto-imputed-fadd-assoc.txt", col.names=c("ID", "rs", "CHR", "BP", "REF", "ALT", "P", "Beta"), header=T)
rearrangefadd=data.frame(CHR=fadd[,3],SNP=fadd[,2],BP=fadd[,4],A1=fadd[,5],A2=fadd[,6],AltID=fadd[,1],altID=fadd[,1],OR=fadd[,8],P=fadd[,7])
write.table(rearrangefadd, file="auto-imputed-rearranged-fadd.assoc", col.names=T, row.names=F, quote=F, sep="\t")

# fdom
fdom <- read.table("auto-imputed-fdom-assoc.txt", col.names=c("ID", "rs", "CHR", "BP", "REF", "ALT", "P", "Beta"), header=T)
rearrangefdom=data.frame(CHR=fdom[,3],SNP=fdom[,2],BP=fdom[,4],A1=fdom[,5],A2=fdom[,6],AltID=fdom[,1],altID=fdom[,1],OR=fdom[,8],P=fdom[,7])
write.table(rearrangefdom, file="auto-imputed-rearranged-fdom.assoc", col.names=T, row.names=F, quote=F, sep="\t")

# fgen
fgen <- read.table("auto-imputed-fgen-assoc.txt", col.names=c("ID", "rs", "CHR", "BP", "REF", "ALT", "P", "Beta"), header=T)
rearrangefgen=data.frame(CHR=fgen[,3],SNP=fgen[,2],BP=fgen[,4],A1=fgen[,5],A2=fgen[,6],AltID=fgen[,1],altID=fgen[,1],OR=fgen[,8],P=fgen[,7])
write.table(rearrangefgen, file="auto-imputed-rearranged-fgen.assoc", col.names=T, row.names=F, quote=F, sep="\t")

# rec
frec <- read.table("auto-imputed-frec-assoc.txt", col.names=c("ID", "rs", "CHR", "BP", "REF", "ALT", "P", "Beta"), header=T)
rearrangefrec=data.frame(CHR=frec[,3],SNP=frec[,2],BP=frec[,4],A1=frec[,5],A2=frec[,6],AltID=frec[,1],altID=frec[,1],OR=frec[,8],P=frec[,7])
write.table(rearrangefrec, file="auto-imputed-rearranged-frec.assoc", col.names=T, row.names=F, quote=F, sep="\t")

# Now import a merger of all the files created above
fall <- read.table("auto-imputed-rearranged-all.assoc", header=T, as.is=T)
snpsofinterest=fall[-log10(fall$P)>=4,]
# Now plot
png(filename = "fall.png", width = 780, height = 480, units = "px", pointsize = 12, 
    bg = "white",  res = NA)
par(mfrow=c(1,1))
manhattan(fall, chr = "CHR", bp = "BP", p = "P", col = c("blue4", "orange3"), 
	  suggestiveline = -log10(1e-05),  genomewideline = -log10(5e-08), highlight = snpsofinterest$SNP, logp = T,
	  annotatePval = 0.0004, annotateTop = T, ylim = c(0, 9))
dev.off()

# Display the SNPs of interest
snpsofinterest
