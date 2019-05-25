#!/usr/bin/Rscript

# Check installation of qqman and load it if installed
if (!requireNamespace("qqman"))
        install.packages("qqman", repos="http://cloud.r-project.org", ask = F)
library(qqman)

################# IBD Calculation ###########################
genome=read.table("caseconpruned.genome", header = T, as.is = T)
genome=genome[genome$PI_HAT > 0.1875, ]

# Compute mean IBD
mean_ibd=0*genome$Z0 + 1*genome$Z1 + 2*genome$Z2

# Compute the variance of IBD
var.ibd=((0 - mean_ibd)^2)*genome$Z0 +
  ((1 - mean_ibd)^2)*genome$Z1 +
  ((2 - mean_ibd)^2)*genome$Z2

# Compute standard error
se.ibd=sqrt(var.ibd)
#png("ibd_analysis.png", res=1200, height = 5, width = 6, units = "in")
png(filename = "ibd_analysis.png", width = 480, height = 700, units = "px", pointsize = 12,
    bg = "white",  res = NA)
par(mfrow=c(2,1)) # Set parameters to plot ibd_analysis and ibd_se
plot(mean_ibd, se.ibd, xlab = "Mean IBD", ylab = "SE IBD", pch=20, main = "SE IBD of Pairs with Pi HAT > 0.1875")
plot(genome$Z0, genome$Z1, col=1, ylab = "Z1", xlab = "Z0", pch=20)
dev.off()

duplicate1=genome[mean_ibd == 2, ] # monozygotic twins
#duplicate1 # Result: 0. There are no monozygotic twins although the plot shows a close call. These must be duplicates
duplicate2=genome[mean_ibd > 1.98, ] # Equivalent to Z2 > 0.98. Apparently, there were no monozygotic twins but duplicates

write.table(duplicate2, file = "duplicates.txt", col.names = T, row.names = F, quote = F)
sibs=genome[mean_ibd == 1, ]

### Color code IBD plot ###
#png("ibd_colcode.png", res=1200, height = 5, width = 6, units = "in")
#png(filename = "ibd_colcode.png", width = 480, height = 600, units = "px", pointsize = 12,
#    bg = "white",  res = NA, type = c("quartz"))
#par(mfrow=c(1,1))
#with(genome, plot(Z0,Z1, xlim = c(0,1), ylim = c(0,1), type = "n", pch=20))
#with(subset(genome,RT=="FS"), points(Z0,Z1, col=3))
#with(subset(genome,RT=="HS"), points(Z0,Z1, col="darkorange"))
#with(subset(genome,RT=="OT"), points(Z0,Z1, col=4))
#with(subset(genome,RT=="PO"), points(Z0,Z1, col=2))
#with(subset(genome,RT=="UN"), points(Z0,Z1, col=1))
#with(subset(genome,RT=="OT"), points(Z0,Z1, col=4))
#with(subset(genome,RT=="HS"), points(Z0,Z1, col="darkorange"))
#legend(1,1, xjust = 1, yjust = 1, legend = levels(genome$RT), pch = 16, col = c(3, "darkorange", 4,2,1))
#dev.off()

# Extract IDs of the duplicate pairs and check in the original data set to see which have a lower call rate)
write.table(duplicate2[,1:2], file = "duplicate.ids1", col.names = F, row.names = F, quote = F, sep = "\t")
write.table(duplicate2[,3:4], file = "duplicate.ids2", col.names = F, row.names = F, quote = F, sep = "\t") # Has the higer missingness


