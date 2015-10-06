!#/usr/bin/perl

my $i;
my @filearray;
my $file;
$i = 0;



print "$ARGV[0] The file.\n";

open(THEFILE, "$ARGV[0]");

push(@filearray,"<p>");

while(<THEFILE>){

	print "The increment: $i $_ \n";

	if($_ =~ /---------------------------------------------/){

		$i++;
		
		push(@filearray,"</p>");
		push(@filearray,"<p>"); 
	
	}

	if($_ eq ""){
	
		push(@filearray,"</br>");
		push(@filearray,"</br>");
	
	}


	push(@filearray,"$_");
	push(@filearray,"</br>"); 

}

close(THEFILE);

open(NEWFILE, "> $ARGV[0].html");

print NEWFILE "<p align=\"center\"><font size=\"48\"><a style=\"text-decoration:none;\"   href=\"http://www.wordprostitute.com/Prostitute/Word.html\"><font color=\"black\">Word</font></a> <a  style=\"text-decoration:none;\" href=\"http://www.wordprostitute.com/Word/Prostitute.html\"><font color=\"black\">Prostitute</font></a></font>&reg;</p>";

print NEWFILE "<p align=\"center\">Subversion Change Log</p>";

print NEWFILE "<div style=\"border-top : 2px solid black ; border-bottom : 2px solid black ; border-right : 2px solid black ; border-left : 2px solid black ; margin: 5% ; padding-top: 20px; padding-bottom: 20px; padding-right: 20px;  padding-left: 20px; \">";

#There is a need to subtract because the log has an addition dash line.
$i = $i - 1;

print NEWFILE "</br>The Revisions: $i</br>";


foreach $file (@filearray){

	print NEWFILE $file;


}


print NEWFILE "<p align=\"center\"><font size=\"-6\">Copyright &#169; 2007 <a href=\"http://www.wordprostitute.com\">Word</a> <a href=\"http://www.wordprostitute.com\">Prostitute</a>&reg;. <a class=\"prostitute\" href=\"http://www.wordprostitute.com/AllRightsReserved.html\"><font color=\"black\">All Rights Reserved.</font></a></font></p>";

print NEWFILE "</div>";

close(NEWFILE);

