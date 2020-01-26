#!/usr/bin/env Rscript

## R script to plot LD by CP group, and bootstraps for CI
## Started 5 November 2015
## Christian Parobek
## Modified by Kevin Esoh for Cameroonian Parasites Analysis (2019 - 2020)

####################################
######### DEFINE FUNCTIONS #########
####################################

args <- commandArgs(TRUE)
if (length(args) < 5) {
   print("",quote=F)
   print("Usage: ld_plotter.r [#CHR] [nbins] [binsize] [data-dir] [out-pic-name]",quote=F)
   print("NB: binsize*nbins >= 200,000", quote=F)
   print("",quote=F)
   quit(save="no")
} else if (as.numeric(args[2])*as.numeric(args[3]) < 200000) {
        print("",quote=F)
	print("Usage: ld_plotter.r [#CHR] [binsize] [nbins] [data-dir] [out-pic-name]",quote=F)
	print("Sorry, binsize*nbins must be >= 200,000", quote=F)
	print("",quote=F)
	quit(save="no")
} else {
   if(!require(data.table))
	   install.packages("data.table", repos = "https://cloud.r-project.org", ask=F)
   require(data.table)
   require(colorspace)
   nchr <- as.numeric(args[1])
   nbins <- as.numeric(args[2])
   binsize <- as.numeric(args[3])
   ddir <- args[4]
   outpng <- paste0(gsub(".png","",args[5]),"bin",binsize,".png")

   # Function calculates distance, plots a decay line
   plot.bin <- function(LDdf, nbins, binsize, color) {
     offset <- binsize - 1
     LDdf$diff <- LDdf$POS2-LDdf$POS1 # calculate the distance for each SNP
     #sorted <- LDdf[order(LDdf$diff),] # sort it
     xline <- NULL
     yline <- NULL
     for (window in 1:nbins*binsize) {
       xline <- append(xline, window)
       yline <- append(yline, mean(LDdf[LDdf$diff >= offset & LDdf$diff < window,]$R.2, na.rm = TRUE))
     }
     lines(xline, yline, col = color, lwd = 3)
   }
   
   # Function calculates distance, sorts, fits a regression, and plots
   plot.fit <- function(LDdf, deg_poly, color) {
     LDdf$diff <- LDdf$POS2-LDdf$POS1 # calculate the distance for each SNP
     sorted <- LDdf[order(LDdf$diff),] # sort it
     fit <- lm(sorted$R.2 ~ poly(sorted$diff, deg_poly, raw=TRUE))
     lines(sorted$diff, predict(fit, data.frame(x=sorted$diff)), col=color)
   } 
   
   # Function plots a shaded curve following min and max boot values
   plot.boot <- function(bootstrap_files, nbins, binsize, shadecolor) {
     bootvalues <- unlist(lapply(bootstrap_files, function(x) mean(x$R.2, na.rm = TRUE)))
     the_max <- which.max(bootvalues)
     the_min <- which.min(bootvalues)
     xline <- NULL
     for (window in 1:nbins*binsize) {
       xline <- append(xline, window)
     }
     upper <- boot.outline(bootstrap_files[[the_max]], nbins, binsize)
     lower <- boot.outline(bootstrap_files[[the_min]], nbins, binsize)
     polygon(c(xline, rev(xline)), c(upper, rev(lower)), col = shadecolor, border = NA)
   }
   
   # Function selects biggest and smallest bootstrap rep. Use if entire bootstrap dataset is too big.
   boot.slimmer <- function(bootstrap_files) {
     bootvalues <- unlist(lapply(bootstrap_files, function(x) mean(x$R.2, na.rm = TRUE)))
     the_max <- which.max(bootvalues)
     the_min <- which.min(bootvalues)
     bootstrap_slimmed <- list(bootstrap_files[[the_max]], bootstrap_files[[the_min]])
     return(bootstrap_slimmed)
   } 
   
   # Accessory function to plot.boot - returns a vector of r2 values
   boot.outline <- function(LDdf, nbins, binsize) {
     offset <- binsize - 1
     LDdf$diff <- LDdf$POS2-LDdf$POS1 # calculate the distance for each SNP
     #sorted <- LDdf[order(LDdf$diff),] # sort it
     yline <- NULL
     for (window in 1:nbins*binsize) {
       yline <- append(yline, mean(LDdf[LDdf$diff >= offset & LDdf$diff < window,]$R.2, na.rm = TRUE))
     }
     return(yline)
   }
   
   #############################################
   ############ LOAD DATA & PLOT IT ############
   #############################################
   bootstrap_names <- list.files(paste0(ddir,"/bootstrap/ld"), pattern="*hap.ld", full.names=TRUE)
   bootstrap_files <- lapply(bootstrap_names, read.table, header = TRUE)

   ## Determine miximum LD across all CHR to set ylim
   for (i in 1:nchr) {
      f <- paste0(ddir,"/pointestimates/ld/chr",i,".ld.1-100000.hap.ld")
      ld <- fread(f, header=T, data.table=F, nThread = 10)
      colnames(ld) <- c("CHR", "POS1", "POS2", "N_CHR", "R.2", "D", "Dprime")
      if (i==1) {
	   ld.res <- ld 
      } else {
	   ld.res <- rbind(ld.res,ld)
      }
   }
   ld.max <- as.numeric(max(ld.res$R.2))
   write.table(ld.res, "ld_merged.txt", col.names=T, row.names=F, quote=F, sep="\t")
   #chr.max.ld <- unique(ld[ld$R.2==ld.max]$CHR)

   ## Setup plot coordinates
   png(outpng, height=540, width=560, units='px', points=12, res=NA)
   plot(0,
	#ld$POS2-ld$POS1, ld$R.2,
        type = "n", xlim = c(0,100000), ylim = c(0,ld.max), axes = FALSE, 
	main=paste0("LD bin size: ", binsize),
        xlab = "Pairwise Coordinate Distance", ylab = expression(italic(r^2)))
   axis(1, at = c(0, 25000, 50000, 75000, 100000))
   axis(2, las = 2)

   ## Slim bootstraps
   slimboot <- boot.slimmer(bootstrap_files)
   remove(bootstrap_files)

   ## Plot bootstraps
   plot.boot(slimboot, nbins, binsize, "lightgray") # plot shaded outline of max and min

   ## Plot pointestimates
   for (i in 1:nchr) {
      pcol <- qualitative_hcl(nchr, "Dark2")
      f <- paste0(ddir,"/pointestimates/ld/chr",i,".ld.1-100000.hap.ld")
      print(paste0("Now Loading chromosome ",i), quote=F)
      ld <- fread(f, header=T, data.table=F, nThread = 10)
      colnames(ld) <- c("CHR", "POS1", "POS2", "N_CHR", "R.2", "D", "Dprime")
      if ("nan" %in% ld$R.2) {
          ld$R.2[is.nan(ld$R.2)] <- 1
          print("All 'nan' entries replaced with 1",quote=F)
      } else {
          print("No missing R^2 entries found",quote=F)
      }
      print(paste0("Plotting chromosome ",i), quote=F)
      plot.bin(ld, nbins, binsize, pcol[i])
      print("Done!", quote=F)
      print("", quote=F)
   }
   legend(35000, ld.max-0.01, 
          legend = c("Chr1", "Chr2", "Chr3", "Chr4", "Chr5", 
   		  "Chr6", "Chr7", "Chr8", "Chr9", "Chr10", 
   		  "Chr11", "Chr12", "Chr13", "Chr14", "Bootstraps"),
          col = c(pcol[1], pcol[2], pcol[3], pcol[4], pcol[5], 
   	       pcol[6], pcol[7], pcol[8], pcol[9], pcol[10], 
   	       pcol[11], pcol[12], pcol[13], pcol[14], "lightgray"), 
          #col = c("cadetblue1", "firebrick3", "goldenrod2", "gray"), 
          lty=c(1, 1, 1, 1, 1, 
   	     1, 1, 1, 1, 1, 
   	     1, 1, 1, 1, 1),
          ncol=3,
          lwd = 2, cex = 0.7)
   dev.off()
}
warnings()
