setwd("~/Git/popgen/")

library(data.table)

ibd2_hmm <- fread("~/bioTools/hmmIBD-2.0.4/samp_data/mytest_2pop.hmm.txt")
ibd2_fracs <- fread("~/bioTools/hmmIBD-2.0.4/samp_data/mytest_2pop.hmm_fract.txt")
head(ibd2_hmm)
head(ibd2_fracs)
dim(ibd2_hmm)
dim(ibd2_fracs)

plot(ibd2_hmm[,3:7])
plot(ibd2_hmm$chr,ibd2_hmm$different)

dev.off()
ibd_merge <- merge(ibd2_hmm, ibd2_fracs, by = .EACHI)
head(ibd_merge)
View(ibd_merge)

ibd_merge$BP <- ibd_merge$end - ibd_merge$start

d <- ibd_merge[order(ibd_merge$chr, ibd_merge$BP), ]
ind = 0
for (i in unique(d$chr)) {
  ind = ind + 1
  d[d$chr == i, ]$index = ind
}
head(d)

plot(ibd_merge$start, ibd_merge$fract_sites_IBD, ylim = c(0,1), pch = 20)

