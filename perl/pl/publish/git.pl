#!/usr/bin/perl

my $name;

if($ARGV[0] eq ""){
	$dir = ".";
}else{
	$dir = $ARGV[0];
}

opendir(DIR, $dir) or die "\n NO DIR [$dir]!\n";

my @FILES= readdir(DIR);


open(FILE,"> gitLOG.txt");

foreach $name (@FILES){

	print "\n" . $name;

}

close(FILE);



