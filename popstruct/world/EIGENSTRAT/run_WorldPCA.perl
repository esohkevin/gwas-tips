#!/usr/bin/perl

#$ENV{'PATH'} = "/home/esoh/bioTools/EIG-6.1.4/bin:$ENV{'PATH'}"; 
# MUST put smartpca bin directory in path for smartpca.perl to work

$command = "smartpca.perl";
$command .= " -i ../CONVERTF/qc-world.eigenstratgeno ";
$command .= " -a ../CONVERTF/qc-world.snp ";
$command .= " -b ../CONVERTF/qc-world.ind " ;
$command .= " -k 10 ";
$command .= " -o qc-world.pca ";
$command .= " -p qc-world.plot ";
$command .= " -e qc-world.eval ";
$command .= " -l qc-world-pca.log ";
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

