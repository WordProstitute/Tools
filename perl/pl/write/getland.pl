#!/usr/bin/perl

open(CSV, "< Temp_Wild.csv") or die "Where the fuck is the file.";

%creature;

while(<CSV>){

	print $_;
	# get position 0 and 3 make 0 the key and 3 the value	


}


close(CSV);
