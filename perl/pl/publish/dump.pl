#!/usr/bin/perl

my $name;

opendir(DIR, "/var/svn");
my @FILES= readdir(DIR);


open(FILE,"exportLOG.txt");

foreach $name (@FILES){

	if ("." eq $name || ".." eq $name || ".DS_Store" eq $name || $name eq "Word_Prostitute"){

		print "THIS IS NOT A DUMP $name\n";

	}else{
	
		print "DUMP $name\n";
		print LOG "DUMP $name\n";
		system("svnadmin dump /var/svn/$name  > /home/kalab/Desktop/dump/$name.dump");
		

	}

}

close(LOG);
