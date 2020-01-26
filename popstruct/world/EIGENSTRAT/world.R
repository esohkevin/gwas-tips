#!/usr/bin/env R

### MDS plot of case-control data and 360 randomly selected individuals from the 1KGP3 ###
# Load the mds data
#pca=read.table("mds-data.mds", header=T, as.is=T)
#status=read.table("merge.txt", header=T, as.is=T)
#pcastat=merge(pca, status, by.x="IID", all.x=T)
#
#### Read in data for pop structure
#pca2=read.table("ps-data.mds", header=T, as.is=T)
#pcastat2=merge(pca2, status, by.x="IID", all.x=T)
#
## Plot and produce and image of the mds plot
#png(filename = "mds-plot.png", width = 500, height = 500, units = "px", pointsize = 12,
#    bg = "white",  res = NA, type = c("quartz"))
#par(mfrow=c(1,1))
#plot(pcastat[,4], pcastat[,5], xlab="PC1", ylab="PC2", type="n")
#for(i in 1:nrow(pcastat)){
# if(pcastat[i,6]=='ACB') points(pcastat[i,4], pcastat[i,5], col=6, pch=16)
# if(pcastat[i,6]=='ASW') points(pcastat[i,4], pcastat[i,5], col=6, pch=16)
# if(pcastat[i,6]=='BEB') points(pcastat[i,4], pcastat[i,5], col=5, pch=16)
# if(pcastat[i,6]=='CDX') points(pcastat[i,4], pcastat[i,5], col=2, pch=16)
# if(pcastat[i,6]=='CEU') points(pcastat[i,4], pcastat[i,5], col=4, pch=16)
# if(pcastat[i,6]=='CHB') points(pcastat[i,4], pcastat[i,5], col=2, pch=16)
# if(pcastat[i,6]=='CHS') points(pcastat[i,4], pcastat[i,5], col=2, pch=16)
# if(pcastat[i,6]=='CLM') points(pcastat[i,4], pcastat[i,5], col=3, pch=16)
# if(pcastat[i,6]=='ESN') points(pcastat[i,4], pcastat[i,5], col=6, pch=16)
# if(pcastat[i,6]=='FIN') points(pcastat[i,4], pcastat[i,5], col=4, pch=16)
# if(pcastat[i,6]=='GBR') points(pcastat[i,4], pcastat[i,5], col=4, pch=16)
# if(pcastat[i,6]=='GIH') points(pcastat[i,4], pcastat[i,5], col=5, pch=16)
# if(pcastat[i,6]=='GWD') points(pcastat[i,4], pcastat[i,5], col=6, pch=16)
# if(pcastat[i,6]=='IBS') points(pcastat[i,4], pcastat[i,5], col=4, pch=16)
# if(pcastat[i,6]=='ITU') points(pcastat[i,4], pcastat[i,5], col=5, pch=16)
# if(pcastat[i,6]=='JPT') points(pcastat[i,4], pcastat[i,5], col=2, pch=16)
# if(pcastat[i,6]=='KHV') points(pcastat[i,4], pcastat[i,5], col=2, pch=16)
# if(pcastat[i,6]=='LWK') points(pcastat[i,4], pcastat[i,5], col=6, pch=16)
# if(pcastat[i,6]=='MSL') points(pcastat[i,4], pcastat[i,5], col=6, pch=16)
# if(pcastat[i,6]=='MXL') points(pcastat[i,4], pcastat[i,5], col=3, pch=16)
# if(pcastat[i,6]=='PEL') points(pcastat[i,4], pcastat[i,5], col=3, pch=16)
# if(pcastat[i,6]=='PJL') points(pcastat[i,4], pcastat[i,5], col=5, pch=16)
# if(pcastat[i,6]=='PUR') points(pcastat[i,4], pcastat[i,5], col=3, pch=16)
# if(pcastat[i,6]=='STU') points(pcastat[i,4], pcastat[i,5], col=5, pch=16)
# if(pcastat[i,6]=='TSI') points(pcastat[i,4], pcastat[i,5], col=4, pch=16)
# if(pcastat[i,6]=='YRI') points(pcastat[i,4], pcastat[i,5], col=6, pch=16)
# if(pcastat[i,6]=='BA') points(pcastat[i,4], pcastat[i,5], col=1, pch=16)
# if(pcastat[i,6]=='SB') points(pcastat[i,4], pcastat[i,5], col=1, pch=16)
# if(pcastat[i,6]=='FO') points(pcastat[i,4], pcastat[i,5], col=1, pch=16)
# }
#legend("topleft", c("AFR","SAS","EAS","AMR","EUR",""), pch = 16, 
#       col = c(6,5,2,3,4,1), horiz=F, bty="n")
#dev.off()
##identify(pcastat[,4], pcastat[,5], labels=pcastat[,2])
#
## From the above plot, there is mild clustering of similar populations into different clusters. Check these
#png(filename = "mds-plot2.png", width = 500, height = 500, units = "px", pointsize = 12,
#    bg = "white",  res = NA, type = c("quartz"))
#par(mfrow=c(1,1))
#plot(pcastat[,4], pcastat[,5], xlab="PC1", ylab="PC2", type="n")
#for(i in 1:nrow(pcastat)){
#  if(pcastat[i,6]=='ACB') points(pcastat[i,4], pcastat[i,5], col=8, pch=16)
#  if(pcastat[i,6]=='ASW') points(pcastat[i,4], pcastat[i,5], col=7, pch=16)
#  if(pcastat[i,6]=='BEB') points(pcastat[i,4], pcastat[i,5], col=5, pch=16)
#  if(pcastat[i,6]=='CDX') points(pcastat[i,4], pcastat[i,5], col=2, pch=16)
#  if(pcastat[i,6]=='CEU') points(pcastat[i,4], pcastat[i,5], col=4, pch=16)
#  if(pcastat[i,6]=='CHB') points(pcastat[i,4], pcastat[i,5], col=2, pch=16)
#  if(pcastat[i,6]=='CHS') points(pcastat[i,4], pcastat[i,5], col=2, pch=16)
#  if(pcastat[i,6]=='CLM') points(pcastat[i,4], pcastat[i,5], col=3, pch=16)
#  if(pcastat[i,6]=='ESN') points(pcastat[i,4], pcastat[i,5], col=6, pch=16)
#  if(pcastat[i,6]=='FIN') points(pcastat[i,4], pcastat[i,5], col=4, pch=16)
#  if(pcastat[i,6]=='GBR') points(pcastat[i,4], pcastat[i,5], col=4, pch=16)
#  if(pcastat[i,6]=='GIH') points(pcastat[i,4], pcastat[i,5], col=5, pch=16)
#  if(pcastat[i,6]=='GWD') points(pcastat[i,4], pcastat[i,5], col=6, pch=16)
#  if(pcastat[i,6]=='IBS') points(pcastat[i,4], pcastat[i,5], col=4, pch=16)
#  if(pcastat[i,6]=='ITU') points(pcastat[i,4], pcastat[i,5], col=5, pch=16)
#  if(pcastat[i,6]=='JPT') points(pcastat[i,4], pcastat[i,5], col=2, pch=16)
#  if(pcastat[i,6]=='KHV') points(pcastat[i,4], pcastat[i,5], col=2, pch=16)
#  if(pcastat[i,6]=='LWK') points(pcastat[i,4], pcastat[i,5], col=6, pch=16)
#  if(pcastat[i,6]=='MSL') points(pcastat[i,4], pcastat[i,5], col=6, pch=16)
#  if(pcastat[i,6]=='MXL') points(pcastat[i,4], pcastat[i,5], col=3, pch=16)
#  if(pcastat[i,6]=='PEL') points(pcastat[i,4], pcastat[i,5], col=3, pch=16)
#  if(pcastat[i,6]=='PJL') points(pcastat[i,4], pcastat[i,5], col=5, pch=16)
#  if(pcastat[i,6]=='PUR') points(pcastat[i,4], pcastat[i,5], col=3, pch=16)
#  if(pcastat[i,6]=='STU') points(pcastat[i,4], pcastat[i,5], col=5, pch=16)
#  if(pcastat[i,6]=='TSI') points(pcastat[i,4], pcastat[i,5], col=4, pch=16)
#  if(pcastat[i,6]=='YRI') points(pcastat[i,4], pcastat[i,5], col=6, pch=16)
#  if(pcastat[i,6]=='CASE') points(pcastat[i,4], pcastat[i,5], col=1, pch=16)
#  if(pcastat[i,6]=='CONTROL') points(pcastat[i,4], pcastat[i,5], col=1, pch=16)
#}
#legend("topleft", 
#       c("AFR","SAS","EAS","AMR","EUR","ACB","ASW","CASECON"), pch=16, 
#       col = c(6,5,2,3,4,7,8,1), horiz=F, bty="n")
#dev.off()

# Identify the few case-control points that seem to be outliers
#identify(pcastat[,4], pcastat[,5], labels=pcastat[,2])

library("colorspace") 

evecDat <- read.table("world-evecDat.txt", header=T, as.is=T)
png("WorldPCA.png", height=15, width=14, units="cm", points=14, res=300)
par(mfrow=c(2,1), cex=0.6, cex.axis=0.7, cex.lab=0.7)
par(fig=c(0,1,0.35,1), bty="o", mar=c(1,1,1,1))
plot(evecDat[,2], evecDat[,3], xlab="PC1", ylab="PC2", type="n")
for(i in 1:nrow(evecDat)){                                                                      
if(evecDat[i,13]=='BA') points(evecDat[i,2], evecDat[i,3], col="deeppink", pch=15)
if(evecDat[i,13]=='SB') points(evecDat[i,2], evecDat[i,3], col="deeppink", pch=15)
if(evecDat[i,13]=='FO') points(evecDat[i,2], evecDat[i,3], col="deeppink", pch=15)
if(evecDat[i,13]=='ACB') points(evecDat[i,2], evecDat[i,3], col="deeppink4", pch=15)
if(evecDat[i,13]=='ASW') points(evecDat[i,2], evecDat[i,3], col="deeppink4", pch=15)
if(evecDat[i,13]=='ESN') points(evecDat[i,2], evecDat[i,3], col="deeppink2", pch=15)
if(evecDat[i,13]=='YRI') points(evecDat[i,2], evecDat[i,3], col="deeppink2", pch=15)
if(evecDat[i,13]=='MSL') points(evecDat[i,2], evecDat[i,3], col="deeppink3", pch=15)
if(evecDat[i,13]=='GWD') points(evecDat[i,2], evecDat[i,3], col="deeppink3", pch=15)
if(evecDat[i,13]=='LWK') points(evecDat[i,2], evecDat[i,3], col="deeppink1", pch=15)
if(evecDat[i,13]=='CLM') points(evecDat[i,2], evecDat[i,3], col="aquamarine", pch=16)
if(evecDat[i,13]=='MXL') points(evecDat[i,2], evecDat[i,3], col="aquamarine1", pch=16)
if(evecDat[i,13]=='PEL') points(evecDat[i,2], evecDat[i,3], col="aquamarine2", pch=16)
if(evecDat[i,13]=='PUR') points(evecDat[i,2], evecDat[i,3], col="aquamarine3", pch=16)
if(evecDat[i,13]=='CEU') points(evecDat[i,2], evecDat[i,3], col="chartreuse", pch=17)
if(evecDat[i,13]=='FIN') points(evecDat[i,2], evecDat[i,3], col="chartreuse1", pch=17)
if(evecDat[i,13]=='GBR') points(evecDat[i,2], evecDat[i,3], col="chartreuse2", pch=17)
if(evecDat[i,13]=='IBS') points(evecDat[i,2], evecDat[i,3], col="chartreuse3", pch=17)
if(evecDat[i,13]=='TSI') points(evecDat[i,2], evecDat[i,3], col="chartreuse4", pch=17)
if(evecDat[i,13]=='BEB') points(evecDat[i,2], evecDat[i,3], col="deepskyblue", pch=18)
if(evecDat[i,13]=='GIH') points(evecDat[i,2], evecDat[i,3], col="deepskyblue1", pch=18)
if(evecDat[i,13]=='ITU') points(evecDat[i,2], evecDat[i,3], col="deepskyblue2", pch=18)
if(evecDat[i,13]=='PJL') points(evecDat[i,2], evecDat[i,3], col="deepskyblue3", pch=18)
if(evecDat[i,13]=='STU') points(evecDat[i,2], evecDat[i,3], col="deepskyblue4", pch=18)
if(evecDat[i,13]=='CDX') points(evecDat[i,2], evecDat[i,3], col="goldenrod", pch=20)
if(evecDat[i,13]=='CHB') points(evecDat[i,2], evecDat[i,3], col="goldenrod1", pch=20)
if(evecDat[i,13]=='CHS') points(evecDat[i,2], evecDat[i,3], col="goldenrod2", pch=20)
if(evecDat[i,13]=='JPT') points(evecDat[i,2], evecDat[i,3], col="goldenrod3", pch=20)
if(evecDat[i,13]=='KHV') points(evecDat[i,2], evecDat[i,3], col="goldenrod4", pch=20)
}
par(fig=c(0,1,0,0.45), new=T, bty="o", mar=c(0,1,2,1))
plot.new()
legend("center", c("BA=BANTU","SB=SEMI-BANTU","FO=FULBE","ACB=African Caribbean in Barbados",
		   "ASW=African-American SW","ESN=ESAN in Nigeria","YRI=Yoruba in Ibadan, Nigeria",
		   "MSL=Mende in Sierra Leone", "GWD=Gambian Mandinka", "LWK=Luhya in Webuye, Kenya", 
		   "CLM=Colombian", "MXL=Mexican-American", "PEL=Peruvian", "PUR=Puerto Rican", 
		   "CEU=CEPH", "FIN=Finnish", "GBR=British in England and Scotland", 
		   "IBS=Iberian populations in Spain", "TSI=Toscani in Italy", "BEB=Bengali in Bangladesh", 
		   "GIH=Gujarati Indian in Houston, TX", "ITU=Indian Telugu in the UK", 
		   "PJL=Punjabi in Lahore, Pakistan", "STU=Sri Lankan Tamil in the UK", 
		   "CDX=Dai Chinese", "CHB=Han Chinese", "CHS=Southern Han Chinese", "JPT=Japanese", 
		   "KHV=Kinh Vietnamese"), 
       		col=c("deeppink","deeppink","deeppink", "deeppink4","deeppink4","deeppink2","deeppink2",
		   "deeppink3", "deeppink3","deeppink1","aquamarine","aquamarine1",
		   "aquamarine2","aquamarine3","chartreuse","chartreuse1", "chartreuse2","chartreuse3",
		   "chartreuse4","deepskyblue","deepskyblue1","deepskyblue2","deepskyblue3","deepskyblue4",
		   "goldenrod","goldenrod1", "goldenrod2","goldenrod3","goldenrod4"), 
       		pch=c(15,15,15,15,15,15,15,15,15,15,16,16,16,16,17,17,17,17,17,18,18,18,18,18,20,20,20,20,20), 
		ncol=3, bty="n", cex=0.8)
dev.off()

