#!/bin/bash

# Generate LD report for qc-camgwas-updated
## Outputting binary matrix format
#plink \
#	--bfile ../../analysis/qc-camgwas-updated \
#	--allow-no-sex \
#	--r2 bin triangle yes-really \
#	--autosome \
#	--out qc-camgwas-r2bin

## Outputting squared table format with D' and MAfs
#plink \
#        --bfile ../../analysis/qc-camgwas-updated \
#        --allow-no-sex \
#	--chr 6 \
#	--from-bp 28477797 \
#	--to-bp 33448354 \
#        --r2 bin4 square yes-really \
#        --out chr6Mhc-bin

# A Square matrix
#plink \
#        --bfile ../../analysis/qc-camgwas-updated \
#        --allow-no-sex \
#        --chr 6 \
#        --from-bp 28477797 \
#        --to-bp 33448354 \
#        --r2 square yes-really \
#        --out chr6Mhc-ld

## Outputting haplotype frequencies,r2 and D'
#plink \
#        --bfile ../../analysis/qc-camgwas-updated \
#       --allow-no-sex \
#        --autosome \
#        --ld \
#        --parallel \
#        --out qc-camgwas-rld

plink \
	--chr 11 \
	--from-kb 5200 \
	--to-kb 5400 \
	--r2 square yes-really \
	--out camhbbregion \
	--bfile ../../assoc_results/phasedWrefImpute2Biallelic

gnuplot -e 'set terminal png; set output "camhbbregion.png"; set autoscale yfix; set autoscale xfix; set title "Pair-wise LD around HBB Region";set pm3d map; plot "camhbbregion.ld" matrix with image'

#file="../include_afr.pops ../include_amr.pops ../include_eas.pops ../include_eur.pops ../include_sas.pops ../include_all.pops"
#
#for pop in $file; do
#	plink \
#		--allow-no-sex \
#  		--bfile ../eig/world/qc-rsids-world-pops \
#  		--chr 6 \
#  		--from-bp 28477797 \
#  		--out ${pop/..\/include_/mhc} \
#  		--r2 square yes-really \
#  		--to-bp 28977797 \
#		--keep "${pop}"
#
#done
#gnuplot -e 'set terminal png; set output "mhcsas.png"; set autoscale yfix; set autoscale xfix; set title "SAS LD Heat Map";set pm3d map; plot "mhcsas.pops.ld" matrix with image'
#gnuplot -e 'set terminal png; set output "mhceur.png"; set autoscale yfix; set autoscale xfix; set title "EUR LD Heat Map";set pm3d map; plot "mhceur.pops.ld" matrix with image'
#gnuplot -e 'set terminal png; set output "mhceas.png"; set autoscale yfix; set autoscale xfix; set title "EAS LD Heat Map";set pm3d map; plot "mhceas.pops.ld" matrix with image'
#gnuplot -e 'set terminal png; set output "mhcamr.png"; set autoscale yfix; set autoscale xfix; set title "AMR LD Heat Map";set pm3d map; plot "mhcamr.pops.ld" matrix with image'
#gnuplot -e 'set terminal png; set output "mhcafr.png"; set autoscale yfix; set autoscale xfix; set title "AFR LD Heat Map";set pm3d map; plot "mhcafr.pops.ld" matrix with image'
#gnuplot -e 'set terminal png; set output "mhcall.png"; set autoscale yfix; set autoscale xfix; set title "ALL PopGroups LD Heat Map";set pm3d map; plot "mhcall.pops.ld" matrix with image'
#
#for pop in $file; do
#        plink \
#                --allow-no-sex \
#                --bfile ../eig/world/qc-rsids-world-pops \
#                --chr 6 \
#                --from-bp 28477797 \
#                --out ${pop/..\/include_/mhc2} \
#                --r2 square yes-really \
#                --to-bp 29477797 \
#                --keep "${pop}"
#
#done
#gnuplot -e 'set terminal png; set output "mhc2sas.png"; set autoscale yfix; set autoscale xfix; set title "SAS LD Heat Map";set pm3d map; plot "mhc2sas.pops.ld" matrix with image'
#gnuplot -e 'set terminal png; set output "mhc2eur.png"; set autoscale yfix; set autoscale xfix; set title "EUR LD Heat Map";set pm3d map; plot "mhc2eur.pops.ld" matrix with image'
#gnuplot -e 'set terminal png; set output "mhc2eas.png"; set autoscale yfix; set autoscale xfix; set title "EAS LD Heat Map";set pm3d map; plot "mhc2eas.pops.ld" matrix with image'
#gnuplot -e 'set terminal png; set output "mhc2amr.png"; set autoscale yfix; set autoscale xfix; set title "AMR LD Heat Map";set pm3d map; plot "mhc2amr.pops.ld" matrix with image'
#gnuplot -e 'set terminal png; set output "mhc2afr.png"; set autoscale yfix; set autoscale xfix; set title "AFR LD Heat Map";set pm3d map; plot "mhc2afr.pops.ld" matrix with image'
#gnuplot -e 'set terminal png; set output "mhc2all.png"; set autoscale yfix; set autoscale xfix; set title "ALL PopGroups LD Heat Map";set pm3d map; plot "mhc2all.pops.ld" matrix with image'
#
#for pop in $file; do
#        plink \
#                --allow-no-sex \
#                --bfile ../eig/world/qc-rsids-world-pops \
#                --chr 6 \
#                --from-bp 29477797 \
#                --out ${pop/..\/include_/mhc3} \
#                --r2 square yes-really \
#                --to-bp 30448354 \
#                --keep "${pop}"
#
#done
#gnuplot -e 'set terminal png; set output "mhc3sas.png"; set autoscale yfix; set autoscale xfix; set title "SAS LD Heat Map";set pm3d map; plot "mhc3sas.pops.ld" matrix with image'
#gnuplot -e 'set terminal png; set output "mhc3eur.png"; set autoscale yfix; set autoscale xfix; set title "EUR LD Heat Map";set pm3d map; plot "mhc3eur.pops.ld" matrix with image'
#gnuplot -e 'set terminal png; set output "mhc3eas.png"; set autoscale yfix; set autoscale xfix; set title "EAS LD Heat Map";set pm3d map; plot "mhc3eas.pops.ld" matrix with image'
#gnuplot -e 'set terminal png; set output "mhc3amr.png"; set autoscale yfix; set autoscale xfix; set title "AMR LD Heat Map";set pm3d map; plot "mhc3amr.pops.ld" matrix with image'
#gnuplot -e 'set terminal png; set output "mhc3afr.png"; set autoscale yfix; set autoscale xfix; set title "AFR LD Heat Map";set pm3d map; plot "mhc3afr.pops.ld" matrix with image'
#gnuplot -e 'set terminal png; set output "mhc3all.png"; set autoscale yfix; set autoscale xfix; set title "ALL PopGroups LD Heat Map";set pm3d map; plot "mhc3all.pops.ld" matrix with image'
#
##### LD for African Groups only
#file="../eig/world/acb.ids ../eig/world/gwd.ids ../eig/world/asw.ids ../eig/world/esn.ids ../eig/world/lwk.ids ../eig/world/msl.ids ../eig/world/yri.ids"
#for pop in $file; do
#        plink \
#                --allow-no-sex \
#                --bfile ../eig/world/qc-rsids-world-pops \
#                --chr 6 \
#                --from-bp 29477797 \
#                --out ${pop/..\/eig\/world\//mhc} \
#                --r2 square yes-really \
#                --to-bp 30448354 \
#                --keep "${pop}"
#
#done
#gnuplot -e 'set terminal png; set output "mhcacb.png"; set autoscale yfix; set autoscale xfix; set title "ACB LD Heat Map";set pm3d map; plot "mhcacb.ids.ld" matrix with image'
#gnuplot -e 'set terminal png; set output "mhcgwd.png"; set autoscale yfix; set autoscale xfix; set title "GWB LD Heat Map";set pm3d map; plot "mhcgwd.ids.ld" matrix with image'
#gnuplot -e 'set terminal png; set output "mhcasw.png"; set autoscale yfix; set autoscale xfix; set title "ASW LD Heat Map";set pm3d map; plot "mhcasw.ids.ld" matrix with image'
#gnuplot -e 'set terminal png; set output "mhcesn.png"; set autoscale yfix; set autoscale xfix; set title "ESN LD Heat Map";set pm3d map; plot "mhcesn.ids.ld" matrix with image'
#gnuplot -e 'set terminal png; set output "mhclwk.png"; set autoscale yfix; set autoscale xfix; set title "LWK LD Heat Map";set pm3d map; plot "mhclwk.ids.ld" matrix with image'
#gnuplot -e 'set terminal png; set output "mhcmsl.png"; set autoscale yfix; set autoscale xfix; set title "MSL LD Heat Map";set pm3d map; plot "mhcmsl.ids.ld" matrix with image'
#gnuplot -e 'set terminal png; set output "mhcyri.png"; set autoscale yfix; set autoscale xfix; set title "YRI LD Heat Map";set pm3d map; plot "mhcyri.ids.ld" matrix with image'
#
############ Extract Common SNPs for the next position to run ld on ######################
#plink \
#	--allow-no-sex \
#        --bfile ../eig/world/qc-rsids-world-pops \
#        --chr 11 \
#	--make-bed \
#        --from-bp 4800000 \
#        --out common \
#        --r2 square yes-really \
#        --to-bp 5800000 \
#        --keep ../eig/world/acb.ids
#cut -f2 common.bim > common.ids
#
##### LD for African Groups only Around rs334 locus
#file="../eig/world/acb.ids ../eig/world/gwd.ids ../eig/world/asw.ids ../eig/world/esn.ids ../eig/world/lwk.ids ../eig/world/msl.ids ../eig/world/yri.ids"
#for pop in $file; do
#        plink \
#                --allow-no-sex \
#                --bfile ../eig/world/qc-rsids-world-pops \
#                --chr 11 \
#                --from-bp 4800000 \
#                --out "${pop/..\/eig\/world\//rs334}" \
#                --r2 square yes-really \
#                --to-bp 5800000 \
#                --keep "${pop}"
#
#done
#gnuplot -e 'set terminal png; set output "rs334acb.png"; set autoscale yfix; set autoscale xfix; set title "ACB LD Heat Map rs334 locus";set pm3d map; plot "rs334acb.ids.ld" matrix with image'
#gnuplot -e 'set terminal png; set output "rs334gwd.png"; set autoscale yfix; set autoscale xfix; set title "GWB LD Heat Map rs334 locus";set pm3d map; plot "rs334gwd.ids.ld" matrix with image'
#gnuplot -e 'set terminal png; set output "rs334asw.png"; set autoscale yfix; set autoscale xfix; set title "ASW LD Heat Map rs334 locus";set pm3d map; plot "rs334asw.ids.ld" matrix with image'
#gnuplot -e 'set terminal png; set output "rs334esn.png"; set autoscale yfix; set autoscale xfix; set title "ESN LD Heat Map rs334 locus";set pm3d map; plot "rs334esn.ids.ld" matrix with image'
#gnuplot -e 'set terminal png; set output "rs334lwk.png"; set autoscale yfix; set autoscale xfix; set title "LWK LD Heat Map rs334 locus";set pm3d map; plot "rs334lwk.ids.ld" matrix with image'
#gnuplot -e 'set terminal png; set output "rs334msl.png"; set autoscale yfix; set autoscale xfix; set title "MSL LD Heat Map rs334 locus";set pm3d map; plot "rs334msl.ids.ld" matrix with image'
#gnuplot -e 'set terminal png; set output "rs334yri.png"; set autoscale yfix; set autoscale xfix; set title "YRI LD Heat Map rs334 locus";set pm3d map; plot "rs334yri.ids.ld" matrix with image'
#
## Run rs334 REgion for Cameroon
#plink \
#	--allow-no-sex \
#	--bfile ../../analysis/qc-camgwas-updated \
#	--chr 11 \
#	--from-bp 4800000 \
#	--out rs334cmr \
#	--thin-indiv-count 150 \
#	--r2 square yes-really \
#	--to-bp 5800000 \
#	--extract common.ids
#
#gnuplot -e 'set terminal png; set output "rs334cmr.png"; set autoscale yfix; set autoscale xfix; set title "CMR LD Heat Map at HBB locus";set pm3d map; plot "rs334cmr.ld" matrix with image'

