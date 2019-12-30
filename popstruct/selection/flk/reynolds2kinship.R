library(ape)
library(phangorn)

midpoint= function(tree){
    require(phangorn)
    dm = cophenetic(tree)
    tree = unroot(tree)
    rn = max(tree$edge)+1
    maxdm = max(dm)
    ind =  which(dm==maxdm,arr=TRUE)[1,]
    tmproot = Ancestors(tree, ind[1], "parent")
    tree = phangorn:::reroot(tree, tmproot)
    edge = tree$edge
    el = tree$edge.length
    children = tree$edge[,2]
    left = match(ind[1], children)
    tmp = Ancestors(tree, ind[2], "all")
    tmp= c(ind[2], tmp[-length(tmp)])
    right = match(tmp, children)
    if(el[left]>= (maxdm/2)){
         edge = rbind(edge, c(rn, ind[1]))
         edge[left,2] = rn
         el[left] = el[left] - (maxdm/2)
         el = c(el, maxdm/2)
    }
    else{
        sel = cumsum(el[right])
        i = which(sel>(maxdm/2))[1]
        edge = rbind(edge, c(rn, tmp[i]))
        edge[right[i],2] = rn
        eltmp =  sel[i] - (maxdm/2)
        el = c(el, el[right[i]] - eltmp)
        el[right[i]] = eltmp
    }
    tree$edge.length = el
    tree$edge=edge
    tree$Nnode  = tree$Nnode+1
    phangorn:::reorderPruning(phangorn:::reroot(tree, rn))
}

kinship=function(D,outgroup="",keep_outgroup=FALSE)
  {
    require(ape)
    D=2*as.matrix(D)
    npop=sqrt(length(D))
    PopTree=nj(D)
    if (outgroup=="") {
      PopTree=midpoint(PopTree)
      npop=npop+1
    } else {
      PopTree=root(PopTree,outgroup)
      if (!keep_outgroup) {
       PopTree=drop.tip(PopTree,outgroup)
      } else {
       npop=npop+1
      }
    }
    ## negative branch length are meaningless in our context
    PopTree$edge.length=abs(PopTree$edge.length)
    ## get the tree structure as : [ father, son, length]
    edges=cbind(PopTree$edge,PopTree$edge.length)
    #Identify ancestral node as father node with no father itself
    father.nodes=unique(edges[,1])
    son.nodes=unique(edges[,2])
    ancestral=father.nodes[which(is.na(match(father.nodes,son.nodes)))]
    ## Now compute F matrix
    Fij=matrix(0,nrow=npop-1,ncol=npop-1,
    dimnames=list(PopTree$tip.label,PopTree$tip.label))
    branch.length=dist.nodes(PopTree)
    tips=1:(npop-1)
    route=vector("list",npop-1)
    for (ipop in tips) {
      ## First Fii = distance to the root
      Fij[ipop,ipop]=branch.length[ipop,ancestral]
      ## build route to root
      father=ipop
      while (father!=ancestral) {
        route[[ipop]]=c(route[[ipop]],father)
        edj=which(edges[,2]==father)
        father=edges[edj,1]
      }
      route[[ipop]]=c(route[[ipop]],ancestral)
    }
    ## Now compute the Fij i!= j
    for (ipop in tips[-length(tips)]) {
      for (jpop in (ipop+1):(npop-1)) {
        common.route=intersect(route[[ipop]],route[[jpop]])
        if (length(common.route)>1) {
          for (i in 2:length(common.route)) {
            n1=common.route[i-1]
            n2=common.route[i]
            Fij[ipop,jpop] = Fij[ipop,jpop] + branch.length[n1,n2]
          }
        }
        Fij[jpop,ipop]=Fij[ipop,jpop]
      }
    }
    return(list(matrix=Fij,pops=colnames(Fij),tree=PopTree))
  }

D=read.table("Reynolds.txt",row.names=1)
F=kinship(D,outgroup="YRI")
write.table(F$matrix,"hapmap_kinship.txt",quote=FALSE,col.names=FALSE)
