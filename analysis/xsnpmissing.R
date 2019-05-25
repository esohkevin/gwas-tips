#!/usr/bin/Rscript

# Check installation of qqman and load it if installed
if (!requireNamespace("qqman"))
        install.packages("qqman", repos="http://cloud.r-project.org", ask = F)
library(qqman)

# X chromosome differential missingness
Xdiffmiss=read.table("qc-camgwas-chrX.missing", header = T, as.is = T)
Xdiffmiss=Xdiffmiss[Xdiffmiss$P<0.000001, ]
write.table(Xdiffmiss$SNP, file = "fail-Xdiffmiss.qc", row.names = F, col.names = F, quote = F)
~                                                                                               
