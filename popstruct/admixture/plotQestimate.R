#!/usr/bin/env Rscript

args <- commandArgs(TRUE)
png(args[2], width=400, height=300, units="px")
tbl=read.table(args[1])
barplot(t(as.matrix(tbl)), col=rainbow(3), 
	xlab="Individual #", ylab="Ancestry", border=NA)
