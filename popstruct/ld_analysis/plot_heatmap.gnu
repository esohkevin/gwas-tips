

#set terminal canvas
#set output 'chr6mhcld.html'
#set autoscale yfix
#set autoscale xfix
#set title 'Heat map of r^2 in the human MHC region'
#set palette defined (0 0 0 0.5, 1 0 0 1, 2 0 0.5 1, 3 0 1 1, 4 0.5 1 0.5, 5 1 1 0, 6 1 0.5 0, 7 1 0 0, 8 0.5 0 0)
#set pm3d map
#splot 'chr6Mhc-sq.ld' matrix with image notile


set terminal png
set output 'Chr6Mhc-sas.png'
set title 'Heat Map'
set autoscale yfix
set autoscale xfix
plot 'chr6Mhc-sas-ld.ld' matrix with image
