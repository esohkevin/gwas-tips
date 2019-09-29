#!/usr/bin/env Rscript

args <- commandArgs(TRUE)
png(args[2], height=10, width=18, units="cm", res=100, type = "cairo")
tbl=read.table(args[1])
barplot(t(as.matrix(tbl)), col=rainbow(8), 
	xlab="Individual #", ylab="Ancestry", border=NA, space=0)

#width=500, height=300, units="px"
