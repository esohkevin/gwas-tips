##################################################################
## Finestructure R Example
## Author: Daniel Lawson (dan.lawson@bristol.ac.uk)
## For more details see www.paintmychromosomes.com ("R Library" page)
## Date: 14/02/2012
## Notes:
##    These functions are provided for help working with fineSTRUCTURE output files
## but are not a fully fledged R package for a reason: they are not robust
## and may be expected to work only in some very specific cases! USE WITH CAUTION!
## SEE FinestrictureLibrary.R FOR DETAILS OF THE FUNCTIONS
##
## Licence: GPL V3
## 
##    This program is free software: you can redistribute it and/or modify
##    it under the terms of the GNU General Public License as published by
##    the Free Software Foundation, either version 3 of the License, or
##    (at your option) any later version.

##    This program is distributed in the hope that it will be useful,
##    but WITHOUT ANY WARRANTY; without even the implied warranty of
##    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
##    GNU General Public License for more details.

##    You should have received a copy of the GNU General Public License
##    along with this program.  If not, see <http://www.gnu.org/licenses/>.

source("FinestructureLibrary.R") # read in the R functions, which also calls the needed packages

## make some colours
some.colors<-MakeColorYRP() # these are yellow-red-purple
some.colorsEnd<-MakeColorYRP(final=c(0.2,0.2,0.2)) # as above, but with a dark grey final for capped values

### Define our input files
chunkfile<-"camgwas_linked.chunkcounts.out" ## chromopainter chunkcounts file
mcmcfile<-"camgwas_linked_mcmc.xml" ## finestructure mcmc file
treefile<-"camgwas_linked_tree.xml" ## finestructure tree file
treefile_wh<-"camgwas_linked_tree_wh.xml" ## finestructure tree file

###### READ IN THE CHUNKCOUNT FILE
dataraw<-as.matrix(read.table(chunkfile,row.names=1,header=T,skip=1)) # read in the pairwise coincidence 

###### READ IN THE MCMC FILES
mcmcxml<-xmlTreeParse(mcmcfile) ## read into xml format
mcmcdata<-as.data.frame.myres(mcmcxml) ## convert this into a data frame

###### DO A 'LIKELIHOOD-BASED' TREE EXTRACTION, SO THAT CUTTING THE TREE IS MEANINGFUL
## (This is similar to that done in the Leslie 2015 Peopling of the British Isles paper)
system("fs fs -X -Y -m T -k 2 camgwas_linked.chunkcounts.out camgwas_linked_mcmc.xml camgwas_linked_tree_wh.xml")

###### READ IN THE TREE FILES

## The whole likelihood version:
treexml_wh<-xmlTreeParse(treefile_wh) ## read the tree as xml format
ttree_wh<-extractTree(treexml_wh) ## extract the tree into ape's phylo format

ttree_wh$node.label[ttree_wh$node.label=="1"] <-""
ttree_wh$node.label[ttree_wh$node.label!=""] <-format(as.numeric(ttree_wh$node.label[ttree_wh$node.label!=""]),digits=2)
tdend_wh<-myapetodend(ttree_wh,factor=1) # convert to dendrogram format

## Cut the tree at the height of 200 log-likelihood units
tdend2<-cutdend(tdend_wh,200)

## And the normal version
treexml<-xmlTreeParse(treefile) ## read the tree as xml format
ttree<-extractTree(treexml) ## extract the tree into ape's phylo format
## If you dont want to plot internal node labels (i.e. MCMC posterior assignment probabilities)
## now is a good time to remove them via:
#     ttree$node.label<-NULL
## Will will instead remove "perfect" node labels
ttree$node.label[ttree$node.label=="1"] <-""
## And reduce the amount of significant digits printed:
ttree$node.label[ttree$node.label!=""] <-format(as.numeric(ttree$node.label[ttree$node.label!=""]),digits=2)

tdend<-myapetodend(ttree,factor=1) # convert to dendrogram format

####################################
## PLOT 1: RAW DENDROGRAM PLOT
pdf(file="CuttingDendrograms.pdf",height=10,width=10)
par(mfrow=c(3,1))
fs.plot.dendrogram(tdend,main="Basic Tree",nodePar=list(cex=0,lab.cex=1),edgePar=list(p.lwd=0,t.srt=0,t.off=-0.5))
fs.plot.dendrogram(tdend_wh,main="Marginal Likelihood Tree",nodePar=list(cex=0,lab.cex=1),
                   edgePar=list(p.lwd=0,t.srt=0,t.off=c(-0.5,1)))
abline(h=200,col="grey")
fs.plot.dendrogram(tdend2,main="Cut tree",nodePar=list(cex=0,lab.cex=1),edgePar=list(p.lwd=0,t.srt=0,t.off=-0.3))
dev.off()


####################################
## Now we work on the MAP state
mapstateunsorted<-popAsList(extractValue(treexml,"Pop")) # map state as a finestructure clustering

popdend<-makemydend(tdend,mapstateunsorted)
mapstatelist<-lapply(labels(popdend),getIndivsFromSummary)

popnames<-lapply(mapstatelist,NameSummary) # population names IN A REVERSIBLE FORMAT (I.E LOSSLESS)
## NOTE: if your population labels don't correspond to the format we used (NAME<number>) YOU MAY HAVE TROUBLE HERE. YOU MAY NEED TO RENAME THEM INTO THIS FORM AND DEFINE YOUR POPULATION NAMES IN popnamesplot BELOW
popnamesplot<-lapply(mapstatelist,NameMoreSummary) # a nicer summary of the populations
names(popnames)<-popnamesplot # for nicety only
names(popnamesplot)<-popnamesplot # for nicety only

## Same things for our cut state
cutstatelist<-lapply(labels(tdend2),getIndivsFromSummary)
cutnamesplot<-lapply(cutstatelist,NameMoreSummary) # a nicer summary of the populations
names(cutstatelist)<-cutnamesplot # for nicety only
names(cutnamesplot)<-cutnamesplot # for nicety only


popdend<-makemydend(tdend,mapstatelist) # use NameSummary to make popdend
popdendclear<-makemydend(tdend,mapstatelist,"NameMoreSummary")# use NameMoreSummary to make popdend

cutdendclear<-cutdend(tdend_wh,200,"NameMoreSummary")

##################################################
## That is it, now we just plot

popmatrixcut<-getPopMatrix(dataraw,cutstatelist)
popmatrix<-getPopMatrix(dataraw,mapstatelist)

pdf(file="Example2CoancestryCut.pdf",height=12,width=12)
plotFinestructure(popmatrixcut,dimnames(popmatrixcut)[[1]],dend=cutdendclear,cols=some.colorsEnd,cex.axis=2,edgePar=list(p.lwd=0,t.srt=90,t.off=-0.1,t.cex=2),labmargin=15,main="Cut Dendrogram reporting average chunk counts",cex.main=2)
dev.off()

pdf(file="Example2CoancestryPop.pdf",height=12,width=12)
plotFinestructure(popmatrix,popnamesplot,dend=popdendclear,cols=some.colorsEnd,cex.axis=2,edgePar=list(p.lwd=0,t.srt=90,t.off=-0.1,t.cex=0.8),labmargin=15,main="Population Dendrogram reporting average chunk counts",cex.main=2)
dev.off()

########################
## COANCESTRY MATRIX

fullorder<-labels(tdend) # the order according to the tree
datamatrix<-dataraw[fullorder,fullorder] # reorder the data matrix

tmatmax<-500 # cap the heatmap
tmpmat<-datamatrix 
tmpmat[tmpmat>tmatmax]<-tmatmax # 
pdf(file="Example2CoancestryRaw.pdf",height=12,width=12)
plotFinestructure(tmpmat,dimnames(tmpmat)[[1]],dend=tdend,cols=some.colorsEnd,cex.axis=0.8,edgePar=list(p.lwd=0,t.srt=90,t.off=-0.1,t.cex=0.8),main="Raw Coancestry chunk count matrix",cex.main=2)
dev.off()

## Population averages
popmeanmatrix<-getPopMeanMatrix(datamatrix,mapstatelist)

tmatmax<-500 # cap the heatmap
tmpmat<-popmeanmatrix
tmpmat[tmpmat>tmatmax]<-tmatmax # 
pdf(file="Example2CoancestryPopAveFull.pdf",height=12,width=12)
plotFinestructure(tmpmat,dimnames(tmpmat)[[1]],dend=tdend,cols=some.colorsEnd,cex.axis=0.6,edgePar=list(p.lwd=0,t.srt=90,t.off=-0.1,t.cex=0.8))
dev.off()


