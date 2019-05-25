#!/usr/bin/Rscript

# PLot heatmap with upper triangular matrix of ld analysis
png(filename = "chr_mhc_hg19_heatmap.png", width = 800, height = 600, units = "px", pointsize = 12,
    bg = "white",  res = NA)
#ldMatrix <- as.matrix(read.table("chr6Mhc.ld", fill=T, skip = 0))

ldMatrix <- readBin('chr6Mhc-bin.ld.bin', what="numeric",n=9591, size=4)

#heatmap(ldMatrix)
image(lower.tri(ldMatrix))
dev.off()
