#!/usr/bin/perl

#$ENV{'PATH'} = "/home/esoh/bioTools/EIG-6.1.4/bin:$ENV{'PATH'}"; 
# MUST put smartpca bin directory in path for smartpca.perl to work

$command = "smartpca.perl";
$command .= " -i ../CONVERTF/afr-data.eigenstratgeno ";
$command .= " -a ../CONVERTF/afr-data.snp ";
$command .= " -b ../CONVERTF/afr-data.ind " ;
$command .= " -k 10 ";
$command .= " -t 10 ";
$command .= " -o afr-data.pca ";
$command .= " -p afr-data.plot ";
$command .= " -e afr-data.eval ";
$command .= " -l afr-data-pca.log ";
$command .= " -m 0 ";
print("$command\n");
system("$command");

#$command = "smarteigenstrat.perl "; 
#$command .= " -i ../CONVERTF/qc-world.eigenstratgeno ";
#$command .= " -a ../CONVERTF/qc-world.snp ";
#$command .= " -b ../CONVERTF/qc-world.ind ";
#$command .= " -p qc-world.pca ";
#$command .= " -k 10 ";
#$command .= " -o qc-world.chisq ";
#$command .= " -l qc-world-eig.log ";
#print("$command\n");
#system("$command");

#$command = "gc.perl qc-world.chisq qc-world.chisq.GC";
#print("$command\n");
#system("$command");

#$command = "evec2pca.perl 30 qc-world.pca.evec ../CONVERTF/qc-world.ind qc-world.pca";
#print("$command\n");
#system("$command");

