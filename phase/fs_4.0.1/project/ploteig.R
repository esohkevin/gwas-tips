#!/usr/bin/Rscript

e <- "camgwasPhasedWref.ids"
g <- "eigenv.csv" 
eth <- read.table(e, header=F, as.is=T)
eig <- read.csv(g, header=T, comment.char="#")
colnames(eth) <- c("Label", "eth", "status")
eigPop <- merge(eth, eig, by = "Label")
eigPop <- merge(eth[,-c(3)], eig, by = "Label")

png("eig.png", height=18, width=18, units="cm", res=100, points=14)
plot(eigPop$Component.1, eigPop$Component.3, xlab="PC1", ylab = "PC2", pch = 20)
d <- eigPop[eigPop$eth=="BA",]
points(d$Component.1, d$Component.3, col = "green", pch = 20)
d <- eigPop[eigPop$eth=="FO",]
points(d$Component.1, d$Component.3, col = "blue", pch = 20)
d <- eigPop[eigPop$eth=="SB",]
points(d$Component.1, d$Component.3, col = "red", pch = 20)
legend("bottomright", c("BA", "FO", "SB"), col=c("green", "blue", "red"), pch=20, bty="n")
dev.off()
