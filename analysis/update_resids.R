#setwd("~/esohdata/GWAS/popstruct/selection/")

if (!require(data.table))
  install.packages("data.table", repos = "https://www.cloud.r-project.org")
if (!require(R.utils))
  install.packages("R.utils", repos = "https://ftp.acc.umu.se/mirror/CRAN/")
require(R.utils)
require(data.table)

#a <- "~/esohdata/GWAS/popstruct/selection/chr6_reg2.vcf"
#b <- "~/esohdata/GWAS/popstruct/selection/chr6_reg.vcf"

args <- commandArgs(TRUE)
a <- args[1]
b <- args[2]
p <- gsub(".vcf.gz", "_updated.vcf.gz", a)

system(sprintf("bcftools view -h -o hdr.txt %s", a))
h <- "hdr.txt"
#system(sprintf("zgrep -v ^\# %s | cut -f1-2 > tmp1.txt", a))
system(sprintf("zcat %s | sed 's/#CHROM/CHROM/g' | zgrep -v ^# > tmp2.txt", a))
#system(sprintf("zgrep -v ^# %s | cut -f3- > tmp2.txt", a))
system(sprintf("zgrep -v ^# %s | cut -f1-3 > tmp3.txt", b))

fa <- "tmp2.txt"
fb <- "tmp3.txt"


vcf <- fread(fa, data.table = F, nThread = 5)
vcf_names <- names(vcf)
ref <- fread(fb, header = F, data.table = F, nThread = 5)
#vcf$ID <- "."
vcf_a <- vcf[,c(1:3)]
colnames(vcf_a) <- c("#CHROM","POS","ID")
vcf_b <- vcf[,-c(1:3)]
vcf_a$key <- paste0(vcf_a$`#CHROM`,":",vcf_a$POS)
vcf_ref <- ref[,c(1:3)]
vcf_ref$key <- paste0(vcf_ref$`#CHROM`,":",vcf_ref$POS)
#res <- merge(vcf_a,vcf_ref[,c(3,4)], by = "key")
#for (chr in as.factor(unique(vcf_a$`#CHROM`))){
#  if (vcf_a$`#CHROM`==chr){
    cpos <- which(vcf_a$key %in% vcf_ref$key)
    for (i in cpos){
      ifelse(vcf_a$key[i] == vcf_ref$key[i], 
             vcf_a$ID[i] <- vcf_ref$ID[i], 
             vcf_a$ID[i] <- '.')
      #if (vcf_a$`#CHROM`[i] == vcf_b$`#CHROM`[i]){
      #  if (vcf_a$POS[i] == vcf_b$POS[i]){
      #    vcf_a$ID[i] <- vcf_b$ID[i]
      #  }
      #} else {
      #  vcf_a$ID[i] <- as.factor('.')
      #}
    }
#  }
#}

str(vcf_a)

vcf <- data.frame(vcf_a[,c(1:3)], vcf_b)
colnames(vcf) <- vcf_names
fwrite(vcf, "vcf_a.vcf", sep = "\t", col.names=F)
vcf <- "vcf_a.vcf"
system(sprintf("cat %s %s | bgzip -c > %s", h, vcf, p))
system(sprintf("rm %s tmp* hdr.txt", vcf))
print("Done!", quote = F)
