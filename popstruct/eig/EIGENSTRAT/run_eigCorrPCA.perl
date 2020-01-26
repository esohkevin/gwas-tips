#!/usr/bin/perl

#$ENV{'PATH'} = "/home/esoh/bioTools/EIG-6.1.4/bin:$ENV{'PATH'}"; 
# MUST put smartpca bin directory in path for smartpca.perl to work

$command = "smartpca.perl";
$command .= " -i ../CONVERTF/eig-corr-camgwas.eigenstratgeno ";
$command .= " -a ../CONVERTF/eig-corr-camgwas.snp ";
$command .= " -b ../CONVERTF/eig-corr-camgwas.ind " ;
$command .= " -k 20 ";
$command .= " -t 20 ";
$command .= " -o eig-corr-camgwas.pca ";
$command .= " -p eig-corr-camgwas.plot ";
$command .= " -e eig-corr-camgwas.eval ";
$command .= " -l eig-corr-camgwas-pca.log ";
$command .= " -m 5 ";
print("$command\n");
system("$command");

$command = "smarteigenstrat.perl "; 
$command .= " -i ../CONVERTF/eig-corr-camgwas.eigenstratgeno ";
$command .= " -a ../CONVERTF/eig-corr-camgwas.snp ";
$command .= " -b ../CONVERTF/eig-corr-camgwas.ind ";
$command .= " -p eig-corr-camgwas.pca ";
$command .= " -k 10 ";
$command .= " -o eig-corr-camgwas.chisq ";
$command .= " -l eig-corr-camgwas-eig.log ";
print("$command\n");
system("$command");

$command = "gc.perl eig-corr-camgwas.chisq eig-corr-camgwas.chisq.GC";
print("$command\n");
system("$command");

#$command = "evec2pca.perl 30 eig-corr-camgwas.pca.evec ../CONVERTF/eig-corr-camgwas.ind eig-corr-camgwas.pca";
#print("$command\n");
#system("$command");

