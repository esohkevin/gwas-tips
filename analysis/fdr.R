#!/us/bin/Rscript

args <- commandArgs(TRUE)

assoc_dat <- args[1]

calc_fdr <- function(assoc.dat = assoc_result) {
	
	out_name <- paste(assoc.dat,".adj.txt",sep="")

	assoc <- read.table(assoc.dat, header=T, as.is=T)
	assoc$P_adj_BH <- p.adjust(as.vector(assoc$P), method="BH")		# Benjamini & Hochberg
	assoc$P_adj_Bonf <- p.adjust(as.vector(assoc$P), method="bonferroni")	# Bonferroni
	assoc$P_adj_BY <- p.adjust(as.vector(assoc$P), method="BY")   		# Benjamini & Yekutieli
	#assoc$P_adj_Holm <- p.adjust(as.vector(assoc$P), method="holm")   	# Holm
	#assoc$P_adj_Hommel <- p.adjust(as.vector(assoc$P), method="hommel")  	# Hommel
	#assoc$P_adj_Hochberg <- p.adjust(as.vector(assoc$P), method="hochberg") # Hochberg
	write.table(assoc, file=out_name, col.names=T, row.names=F, quote=F, sep="\t")
}

calc_fdr(assoc_dat)

