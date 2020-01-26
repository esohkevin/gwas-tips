#!/usr/bin/perl

#$ENV{'PATH'} = "/home/esoh/bioTools/EIG-6.1.4/bin:$ENV{'PATH'}"; 
# MUST put smartpca bin directory in path for smartpca.perl to work


$num_args = $#ARGV + 1;

$base=$ARGV[0];
$k_param=$ARGV[1];
$m_param=$ARGV[2];
$t_param=$ARGV[3];
$s_param=$ARGV[4];

if ($num_args == 5) {

	print "\nNB: Argument order matters!\n";

	$command = "smartpca.perl";
	$command .= " -i ../CONVERTF/$base.eigenstratgeno ";
	$command .= " -a ../CONVERTF/$base.snp ";
	$command .= " -b ../CONVERTF/$base.ind " ;
	$command .= " -k $k_param ";
	$command .= " -o $base.pca ";
	$command .= " -p $base.plot ";
	$command .= " -e $base.eval ";
	$command .= " -l $base-pca.log ";
	$command .= " -m $m_param ";
	$command .= " -t $t_param ";
	$command .= " -s $s_param ";
	print("$command\n");
	system("$command");
	
	#$command = "smarteigenstrat.perl "; 
	#$command .= " -i ../CONVERTF/$base.eigenstratgeno ";
	#$command .= " -a ../CONVERTF/$base.snp ";
	#$command .= " -b ../CONVERTF/$base.ind ";
	#$command .= " -p $base.pca ";
	#$command .= " -k $k_param ";
	#$command .= " -o $base.chisq ";
	#$command .= " -l $base-strat.log ";
	#print("$command\n");
	#system("$command");
	#
	#$command = "gc.perl $base.chisq $base.chisq.GC";
	#print("$command\n");
	#system("$command");
	
	#$command = "evec2pca.perl $t_param $base.pca.evec ../CONVERTF/$base.ind $base.pca";
	#print("$command\n");
	#system("$command");
}


else {
        print "\nUsage: ./run_eingenstrat.perl <input_prefix> <k_param> <m_param> <t_param> <s_param>\n\n";
}

