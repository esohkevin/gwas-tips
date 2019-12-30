#!/usr/bin/env Rscript

########################### Initialization ########################

library(ggplot2)
library(grid)
library(RColorBrewer)
coul=brewer.pal(4,'Set1')
mypal=c(brewer.pal(10,'RdYlGn'), brewer.pal(10,'RdYlBu')[6:10],brewer.pal(10,'PuOr'), brewer.pal(10,'PiYG')[1:5], brewer.pal(10,'RdGy')[6:10], brewer.pal(10,'BrBG')[6:10] )

clust_smooth=function(dat,nsamp=200) {

### smoothing of cluster probability
### arguments:
### dat : data frame
### nsamp : number of positions for which to compute cluster probabilities
### increase nsamp for increased details

  npop=length(unique(dat$pop))
  nclus=length(unique(dat$cluster))
  nsnp=dim(dat)[1]/(npop*nclus)
  popnames=unique(dat$pop)
  dat$cluster=as.factor(dat$cluster)

  xmin=min(dat$position)
  xmax=max(dat$position)
  xx=seq(xmin,xmax,(xmax-xmin)/nsamp)
  dat.pred=data.frame(pop=c(),locus=c(),position=c(),cluster=c(),prob=c())

  for (pop in popnames) {
    for (cluster in unique(dat$cluster)) {
      subset = dat$pop==pop & dat$cluster==cluster
      ss=smooth.spline(dat$pos[subset],dat$prob[subset])
      newdat=predict(ss,xx)
      dat.pred=rbind(dat.pred,data.frame(pop=pop,cluster=cluster,prob=newdat$y,locus=newdat$x,position=newdat$x))
    }
    ## renormalization sum(p) = 1
    for (pos in xx) {
      subset=dat.pred$position==pos & dat.pred$pop==pop
      dat.pred$prob[subset][dat.pred$prob[subset]<0]=0
      total=sum(dat.pred$prob[subset])
      dat.pred$prob[subset] = dat.pred$prob[subset]/total
    }
  }
  dat.pred$cluster=as.factor(dat.pred$cluster)
  return(dat.pred)
}


switch_cluster_labels=function(dat) {
  ### Switch cluster labels ala CLUMPP
  ### for prettier output
  popcol=c()
  snpcol=c()
  cluscol=c()
  probcol=c()
  poscol=c()
  npop=length(unique(dat$pop))
  nclus=length(unique(dat$cluster))
  nsnp=dim(dat)[1]/(npop*nclus)
  popnames=unique(dat$pop)
  loci=unique(dat$locus)[sort(unique(dat$position),index.return=TRUE)$ix]
  pos=sort(unique(dat$position))
  ## constant columns
  ## pop
  for (i in 1:npop) {
    popcol=c(popcol,rep(as.character(popnames[i]),nclus))
  }
  popcol=rep(popcol,nsnp)
  ## cluster
  cluscol=rep(1:nclus,npop)
  cluscol=rep(cluscol,nsnp)
  ## locus
  snpcol=kronecker(loci,rep(1,npop*nclus))
  ## position
  poscol=kronecker(pos,rep(1,npop*nclus))
  ## cluster probabilities column
  probcol=dat$prob[dat$locus==loci[1]]
  ### matrix (Npop x Nclus) of cluster probabilities at first locus
  prevmat=matrix(dat$prob[dat$locus==loci[1]],nrow=npop,byrow=TRUE)
  sump=apply(prevmat,2,sum)
  correct=which(sump==0)
  if (length(correct)>0) {
    prevmat[,correct]=0.0001
  }

  for (snp in 2:nsnp) {
    nextmat=matrix(dat$prob[dat$locus==loci[snp]],nrow=npop,byrow=TRUE)
    sump=apply(nextmat,2,sum)
    correct=which(sump==0)
    if (length(correct)>0) {
      nextmat[,correct]=0.0001
    }
    prevK=c()
    nextK=c()
    D=c()
    for (k1 in 1:nclus) {
      for (k2 in 1:nclus) {
        d=norm(as.matrix(prevmat[,k1]-nextmat[,k2]),type='F')/((norm(as.matrix(prevmat[,k1]), type='F')*norm(as.matrix(nextmat[,k2]), type='F')))
        prevK=c(prevK,k1)
        nextK=c(nextK,k2)
        D=c(D,d)
      }
    }
    ## distance between pairs of clusters
    dist=rbind(prevK,nextK,D)
    aux=sort(D, index.return=TRUE)
    ## sorted according to distance
    dist=dist[,aux$ix]
    ## greedy matching
    pairs=matrix(0,nrow=2, ncol=nclus)
    for (i in 1:(nclus-1)){
      pairs[,i]=dist[c(1,2),1]
      pair=dist[c(1,2),1]
      k1.rm=dist[1,]%in%pair[1]
      dist=dist[,!k1.rm]
      k2.rm=dist[2,]%in%pair[2]
      dist=dist[,!k2.rm]
    }
    pairs[,nclus]=dist[c(1,2)]
    aux.p=sort(pairs[1,], index.return=TRUE)
    prevmat=nextmat[,pairs[2,aux.p$ix]]
    probcol=c(probcol,as.vector(t(prevmat)))
  }
  return(data.frame(pop=popcol,cluster=as.factor(cluscol),prob=probcol,locus=snpcol,position=poscol))
}


cluster_plot=function(dat) {
  ### create ggplot2 object
  my.plot=ggplot(dat,aes(x=position,y=prob,group=cluster))
  my.plot=my.plot+geom_bar(stat="identity",aes(fill=cluster,col=cluster),size=1.5)+facet_grid(pop~.)+scale_fill_manual(values=mypal,guide=FALSE)+scale_colour_manual(values=mypal,guide=FALSE)
  return(my.plot)
}

########################### Main Script ###########################

args <- commandArgs(TRUE)

if (length(args) < 1) {
  print('Usage: hapflk-clusterplot.R file.bz2 [left] [right]')
  quit(save="no")
}

print(paste("Called with arguments:",args))

xl=0
xr=1e9
if (length(args)>1) {
  xl=as.double(args[2])
}
if (length(args)>2) {
  xr=as.double(args[3])
}
print(paste('position range:',xl,'-', xr))
### read in data
print('Reading data')
my_file=bzfile(args[1],open='r')
hapfrq=read.table(my_file,head=T)
hapfrq=hapfrq[hapfrq$position>xl & hapfrq$position<xr,]
close(my_file)

### smoothing : comment out if not wanted
### change nsamp smoothing parameter to control smoothing (see above)
print('Smoothing Data')
hapfrq=clust_smooth(hapfrq)

### switching : comment out if not wanted
print('Switching Data')
hapfrq=switch_cluster_labels(hapfrq)

### produce plot
print('Calculating Plot')
hapfrq.plot=cluster_plot(hapfrq)

print('Writing Plot to file')
png(file=paste(args[1],'-plot.png',sep=''),width=6.83,height=6.83,units='in',res=300)
print(hapfrq.plot+ theme(panel.background = element_blank(),
                         panel.grid.major = element_blank(),
                         ## axis.ticks = element_blank(),
                         ## axis.text.x = element_blank(),
                         legend.position='bottom',
                         legend.key.size=unit(0.1,"in"))
      )
dev.off()
