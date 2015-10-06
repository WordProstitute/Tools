!#/usr/bin/perl

if($ARGV[0] eq ""){

	print "The program requires parameters";
	print "The paramaters are the manuscript name: $ARGV[0]";
	print "...And the ORDERED BY CHAPTER comma deliminated list of files for manuscript: $ARGV[1]";

	exit;
}




# The manuscript name 
print "\nThe manuscript name $ARGV[0]\n" 

# The commma deliminated files
print "\nThe ORDERED BY CHAPTER comma deliminated files: $ARGV[1]\n";


my $svn = "/usr/local/bin/svn";
my @files;
my @filearray;
my @infoarray;
my $file;
my $timestamp;
my $manifest = "$ARGV[0].$timestamp.manifest";
my $manuscript = "$ARGV[0].$timestamp.txt";
my $tmpfile = "tmp.txt";


# Create timestamp
($second,$minute,$hour,$monthday,$month,$year,$weekday,$yearday,$isdst)=localtime(time);
$timestamp = $year.$month.$monthday.$hour.$minute;


#clean
delete("$manifest");
delete("$manuscript");
delete("$tmpfile");

#create array of files.
@files = split(',',$ARGV[1])

foreach $file (@files){

	system("$svn up $file");

	system("$svn info --targets $file >> $tmpfile");


	open(THEFILE, "$file");

	while(<THEFILE>){

        	push(@filearray,"$_");

	}              

	close(THEFILE);

}

open(THEINFO, $tmpfile);


while(<THEINFO>){

        push(@infoarray,"$_");

}

close(THEINFO);  



%labelhash = (
path = "Path",
name = "Name",
url = "URL",
revision = "Revision",
node_kind = "Node Kind",
last_change_date = "Last Changed Date",
checksum = "Checksum",
);



open (INFO, "< info.txt");

@thearray = "";

while(<INFO>){

	if($_ eq "<info>"){

		push(@thearray,"<file>");
			
	}

	

	($label,$data) = split(':',$_);
	
	foreach $key (sort keys %localhash){

		if($localhash{$key} eq $label){

				push(@thearray,"<$key>");
				push(@thearray,"$data");
				push(@thearray,"<$key>");

		}

	}

	$label = "";
	$data = "";

	if($_ eq "</info>"){
		
		push(@thearray,"<file>");				

	}
	
}

close (INFO);



open(MANUSCRIPT, "> $manuscript");


print MANUSCRIPT "<manuscript>\n"

foreach $file (@filearray){

        print MANUSCRIPT $file;

}


print MANUSCRIPT "</manuscript>\n"

print MANUSCRIPT "<manifest>\n"

foreach $file (@infoarray){

        print MANUSCRIPT $file;


}  

print MANUSCRIPT "</manifest>\n" 

close(MANUSCRIPT)

open(MANIFEST, "> $manifest");

print MANIFEST "<manifest>\n"

foreach $file (@infoarray){

        print MANIFEST $file;


}  

print MANIFEST "</manifest>\n"  

close(MANIFEST)
