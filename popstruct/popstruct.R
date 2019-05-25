#!/usr/bin/env R

### MDS plot of case-control data and 360 randomly selected individuals from the 1KGP3 ###
# Load the mds data
pca=read.table("mds-data.mds", header=T, as.is=T)
status=read.table("merge.txt", header=T, as.is=T)
pcastat=merge(pca, status, by.x="IID", all.x=T)

### Read in data for pop structure
pca2=read.table("ps-data.mds", header=T, as.is=T)
pcastat2=merge(pca2, status, by.x="IID", all.x=T)

# Plot and produce and image of the mds plot
png(filename = "mds-plot.png", width = 500, height = 500, units = "px", pointsize = 12,
    bg = "white",  res = NA, type = c("quartz"))
par(mfrow=c(1,1))
plot(pcastat[,4], pcastat[,5], xlab="PC1", ylab="PC2", type="n")
for(i in 1:nrow(pcastat)){
 if(pcastat[i,6]=='ACB') points(pcastat[i,4], pcastat[i,5], col=6, pch=16)
 if(pcastat[i,6]=='ASW') points(pcastat[i,4], pcastat[i,5], col=6, pch=16)
 if(pcastat[i,6]=='BEB') points(pcastat[i,4], pcastat[i,5], col=5, pch=16)
 if(pcastat[i,6]=='CDX') points(pcastat[i,4], pcastat[i,5], col=2, pch=16)
 if(pcastat[i,6]=='CEU') points(pcastat[i,4], pcastat[i,5], col=4, pch=16)
 if(pcastat[i,6]=='CHB') points(pcastat[i,4], pcastat[i,5], col=2, pch=16)
 if(pcastat[i,6]=='CHS') points(pcastat[i,4], pcastat[i,5], col=2, pch=16)
 if(pcastat[i,6]=='CLM') points(pcastat[i,4], pcastat[i,5], col=3, pch=16)
 if(pcastat[i,6]=='ESN') points(pcastat[i,4], pcastat[i,5], col=6, pch=16)
 if(pcastat[i,6]=='FIN') points(pcastat[i,4], pcastat[i,5], col=4, pch=16)
 if(pcastat[i,6]=='GBR') points(pcastat[i,4], pcastat[i,5], col=4, pch=16)
 if(pcastat[i,6]=='GIH') points(pcastat[i,4], pcastat[i,5], col=5, pch=16)
 if(pcastat[i,6]=='GWD') points(pcastat[i,4], pcastat[i,5], col=6, pch=16)
 if(pcastat[i,6]=='IBS') points(pcastat[i,4], pcastat[i,5], col=4, pch=16)
 if(pcastat[i,6]=='ITU') points(pcastat[i,4], pcastat[i,5], col=5, pch=16)
 if(pcastat[i,6]=='JPT') points(pcastat[i,4], pcastat[i,5], col=2, pch=16)
 if(pcastat[i,6]=='KHV') points(pcastat[i,4], pcastat[i,5], col=2, pch=16)
 if(pcastat[i,6]=='LWK') points(pcastat[i,4], pcastat[i,5], col=6, pch=16)
 if(pcastat[i,6]=='MSL') points(pcastat[i,4], pcastat[i,5], col=6, pch=16)
 if(pcastat[i,6]=='MXL') points(pcastat[i,4], pcastat[i,5], col=3, pch=16)
 if(pcastat[i,6]=='PEL') points(pcastat[i,4], pcastat[i,5], col=3, pch=16)
 if(pcastat[i,6]=='PJL') points(pcastat[i,4], pcastat[i,5], col=5, pch=16)
 if(pcastat[i,6]=='PUR') points(pcastat[i,4], pcastat[i,5], col=3, pch=16)
 if(pcastat[i,6]=='STU') points(pcastat[i,4], pcastat[i,5], col=5, pch=16)
 if(pcastat[i,6]=='TSI') points(pcastat[i,4], pcastat[i,5], col=4, pch=16)
 if(pcastat[i,6]=='YRI') points(pcastat[i,4], pcastat[i,5], col=6, pch=16)
 if(pcastat[i,6]=='CASE') points(pcastat[i,4], pcastat[i,5], col=1, pch=16)
 if(pcastat[i,6]=='CONTROL') points(pcastat[i,4], pcastat[i,5], col=1, pch=16)
 }
legend("topleft", c("AFR","SAS","EAS","AMR","EUR","CASECON"), pch = 16, 
       col = c(6,5,2,3,4,1), horiz=F, bty="n")
dev.off()
#identify(pcastat[,4], pcastat[,5], labels=pcastat[,2])

# From the above plot, there is mild clustering of similar populations into different clusters. Check these
png(filename = "mds-plot2.png", width = 500, height = 500, units = "px", pointsize = 12,
    bg = "white",  res = NA, type = c("quartz"))
par(mfrow=c(1,1))
plot(pcastat[,4], pcastat[,5], xlab="PC1", ylab="PC2", type="n")
for(i in 1:nrow(pcastat)){
  if(pcastat[i,6]=='ACB') points(pcastat[i,4], pcastat[i,5], col=8, pch=16)
  if(pcastat[i,6]=='ASW') points(pcastat[i,4], pcastat[i,5], col=7, pch=16)
  if(pcastat[i,6]=='BEB') points(pcastat[i,4], pcastat[i,5], col=5, pch=16)
  if(pcastat[i,6]=='CDX') points(pcastat[i,4], pcastat[i,5], col=2, pch=16)
  if(pcastat[i,6]=='CEU') points(pcastat[i,4], pcastat[i,5], col=4, pch=16)
  if(pcastat[i,6]=='CHB') points(pcastat[i,4], pcastat[i,5], col=2, pch=16)
  if(pcastat[i,6]=='CHS') points(pcastat[i,4], pcastat[i,5], col=2, pch=16)
  if(pcastat[i,6]=='CLM') points(pcastat[i,4], pcastat[i,5], col=3, pch=16)
  if(pcastat[i,6]=='ESN') points(pcastat[i,4], pcastat[i,5], col=6, pch=16)
  if(pcastat[i,6]=='FIN') points(pcastat[i,4], pcastat[i,5], col=4, pch=16)
  if(pcastat[i,6]=='GBR') points(pcastat[i,4], pcastat[i,5], col=4, pch=16)
  if(pcastat[i,6]=='GIH') points(pcastat[i,4], pcastat[i,5], col=5, pch=16)
  if(pcastat[i,6]=='GWD') points(pcastat[i,4], pcastat[i,5], col=6, pch=16)
  if(pcastat[i,6]=='IBS') points(pcastat[i,4], pcastat[i,5], col=4, pch=16)
  if(pcastat[i,6]=='ITU') points(pcastat[i,4], pcastat[i,5], col=5, pch=16)
  if(pcastat[i,6]=='JPT') points(pcastat[i,4], pcastat[i,5], col=2, pch=16)
  if(pcastat[i,6]=='KHV') points(pcastat[i,4], pcastat[i,5], col=2, pch=16)
  if(pcastat[i,6]=='LWK') points(pcastat[i,4], pcastat[i,5], col=6, pch=16)
  if(pcastat[i,6]=='MSL') points(pcastat[i,4], pcastat[i,5], col=6, pch=16)
  if(pcastat[i,6]=='MXL') points(pcastat[i,4], pcastat[i,5], col=3, pch=16)
  if(pcastat[i,6]=='PEL') points(pcastat[i,4], pcastat[i,5], col=3, pch=16)
  if(pcastat[i,6]=='PJL') points(pcastat[i,4], pcastat[i,5], col=5, pch=16)
  if(pcastat[i,6]=='PUR') points(pcastat[i,4], pcastat[i,5], col=3, pch=16)
  if(pcastat[i,6]=='STU') points(pcastat[i,4], pcastat[i,5], col=5, pch=16)
  if(pcastat[i,6]=='TSI') points(pcastat[i,4], pcastat[i,5], col=4, pch=16)
  if(pcastat[i,6]=='YRI') points(pcastat[i,4], pcastat[i,5], col=6, pch=16)
  if(pcastat[i,6]=='CASE') points(pcastat[i,4], pcastat[i,5], col=1, pch=16)
  if(pcastat[i,6]=='CONTROL') points(pcastat[i,4], pcastat[i,5], col=1, pch=16)
}
legend("topleft", 
       c("AFR","SAS","EAS","AMR","EUR","ACB","ASW","CASECON"), pch=16, 
       col = c(6,5,2,3,4,7,8,1), horiz=F, bty="n")
dev.off()

# Identify the few case-control points that seem to be outliers
#identify(pcastat[,4], pcastat[,5], labels=pcastat[,2])

# Extract the individuals from the mds data
# NB: After exluding these indivuals, association test did not improve. Therefore they were not actually outliers
#outliers=c(pcastat[219,1], pcastat[875,1], pcastat[884,1], pcastat[1256,1])
#write.table(outliers, file="sample.exclusions", col.names = F, row.names = F, quote = F, sep = "\n")

#png("mds-plot.png", res=1200, height=5, width=5, units="in")
#par(xpd = T, mar = par()$mar + c(0,0,0,7))
#plot(pcastat[,4], pcastat[,5], xlab="PC1", ylab="PC2", type="n")
#for(i in 1:nrow(pcastat)){
#if(pcastat[i,6]=='CEU') points(pcastat[i,4], pcastat[i,5], col=2, pch=16)
#if(pcastat[i,6]=='YRI') points(pcastat[i,4], pcastat[i,5], col=3, pch=16)
#if(pcastat[i,6]=='CAJ') points(pcastat[i,4], pcastat[i,5], col=4, pch=16)
#if(pcastat[i,6]=='CASE') points(pcastat[i,4], pcastat[i,5], col=1, pch=16)
#if(pcastat[i,6]=='CONTROL') points(pcastat[i,4], pcastat[i,5], col=1, pch=16)
#}
#legend(0.30,0.00, c("CEU", "YRI", "CAJ", "CASECON"), pch=16, col = c(2, 3, 4, 1))
#par(mar=c(5, 4, 4, 2) + 0.1)
#dev.off()

### Population structure plot for case-control data loaded above as ps2data ###
png(filename = "casecon-pcs.png", width = 780, height = 500, units = "px", pointsize = 12,
    bg = "white",  res = NA, type = c("quartz"))
par(mfrow=c(2,3))

# Pop struct based on PC1 and PC2
plot(pcastat2[,4], pcastat2[,5], xlab = "PC1", ylab = "PC2", type = "n")
for(i in 1:nrow(pcastat2)){
  if(pcastat2[i,14]=='CASE') points(pcastat2[i,4], pcastat2[i,5], col=2, pch=16)
  if(pcastat2[i,14]=='CONTROL') points(pcastat2[i,4], pcastat2[i,5], col=4, pch=16)
}
legend("bottomright", c("CASE","CONTROL"), pch=20, col = c(2,4), horiz=T, bty="n")

# Pop struct based on PC3 and PC4
plot(pcastat2[,6], pcastat2[,7], xlab = "PC3", ylab = "PC4", type = "n")
for(i in 1:nrow(pcastat2)){
  if(pcastat2[i,14]=='CASE') points(pcastat2[i,6], pcastat2[i,7], col=2, pch=16)
  if(pcastat2[i,14]=='CONTROL') points(pcastat2[i,6], pcastat2[i,7], col=4, pch=16)
}
legend("topright", c("CASE","CONTROL"), pch=20, col = c(2,4), horiz=T, bty="n")

# Pop struct based on PC5 and PC6
plot(pcastat2[,8], pcastat2[,9], xlab = "PC5", ylab = "PC6", type = "n")
for(i in 1:nrow(pcastat2)){
  if(pcastat2[i,14]=='CASE') points(pcastat2[i,8], pcastat2[i,9], col=2, pch=16)
  if(pcastat2[i,14]=='CONTROL') points(pcastat2[i,8], pcastat2[i,9], col=4, pch=16)
}
legend("bottomright", c("CASE","CONTROL"), pch=20, col = c(2,4), horiz=T, bty="n")

# Pop struct based on PC7 and PC8
plot(pcastat2[,10], pcastat2[,11], xlab = "PC7", ylab = "PC8", type = "n")
for(i in 1:nrow(pcastat2)){
  if(pcastat2[i,14]=='CASE') points(pcastat2[i,10], pcastat2[i,11], col=2, pch=16)
  if(pcastat2[i,14]=='CONTROL') points(pcastat2[i,10], pcastat2[i,11], col=4, pch=16)
}
legend("topright", c("CASE","CONTROL"), pch=20, col = c(2,4), horiz=T, bty="n")

# Pop struct based on PC9 and PC10
plot(pcastat2[,12], pcastat2[,13], xlab = "PC9", ylab = "PC10", type = "n")
for(i in 1:nrow(pcastat2)){
  if(pcastat2[i,14]=='CASE') points(pcastat2[i,12], pcastat2[i,13], col=2, pch=16)
  if(pcastat2[i,14]=='CONTROL') points(pcastat2[i,12], pcastat2[i,13], col=4, pch=16)
}
legend("topleft", c("CASE","CONTROL"), pch=20, col = c(2,4), horiz=T, bty="n")

# Pop struct based on PC1 and PC7
plot(pcastat2[,8], pcastat2[,9], xlab = "PC5", ylab = "PC6", type = "n")
for(i in 1:nrow(pcastat2)){
  if(pcastat2[i,14]=='CASE') points(pcastat2[i,4], pcastat2[i,10], col=2, pch=16)
  if(pcastat2[i,14]=='CONTROL') points(pcastat2[i,4], pcastat2[i,10], col=4, pch=16)
}
legend("bottomright", c("CASE","CONTROL"), pch=20, col = c(2,4), horiz=T, bty="n")
dev.off()

### Now test for association between disease and the first ten axes of genetic variation ###
summary(glm(as.factor(pcastat2[,14])~pcastat2[,4]+pcastat2[,5]+pcastat2[,6]+pcastat2[,7]+
              pcastat2[,8]+pcastat2[,9]+pcastat2[,10]+pcastat2[,11]+pcastat2[,12]+pcastat2[,13],family = "binomial"))

