#!/usr/bin/perl



require "../../conf/$ARGV[0].conf";

our $chapter;
our $wordfile;
our $bookfile;
our @pagelines;

open(LOG, "> log.txt");

foreach $chapter (@chapters){

	$wordfile = $wordpath . $chapter . $wordsuffix;
	
	open(WORDS, "< $wordfile") or die "\nYOU NEED A FILE FOR A FILE OF WORDS THAT EXISTS: $wordfile\n"; 
		
	while(<WORDS>){
		push(@pagelines,$_) unless ($_ =~ /^\s+$/);
		print "Pageline $chapternoline: $_\n";
	}
	close(WORDS);

	open(PAGE, "> $wordfile") or die "\nTHE PAGE DIDN'T OPEN: $bookfile\n";
	foreach(@pagelines){

	}

	open(PAGE);



}

close(LOG);
