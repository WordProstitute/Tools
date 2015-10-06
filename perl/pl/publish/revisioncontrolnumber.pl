!#/usr/bin/perl

require "../../conf/Portland/common.conf";


system("svn log --verbose file:///var/svn/Word/Prostitute/Product/Goods/Words/Por✞land/ Blood.wpml.xml The_Pub.wpml.xml Rome.wpml.xml Last_Call.wpml.xml Night.wpml.xml  ☉/Son.wpml.xml ☉/In_Blood_Cocoon.wpml.xml ☉/Born_Again.wpml.xml ☉/Baptized.wpml.xml ☉/Blood_Burn.wpml.xml  Minister/Prey.wpml.xml Minister/Dad.wpml.xml Minister/You.wpml.xml Minister/Left_Behind.wpml.xml Minister/Day.wpml.xml > revision.log");

open(THEFILE, "revision.log");

while(<THEFILE>){

	push(@thefile,$_);

}
@reverse = reverse(@thefile);
$i = "0";
$flag = "0";

foreach $aline (@reverse){

	#print "The increment: $i $_ \n";

	if($aline =~ /---------------------------------------------/){

		if($aline =~ /---------------------------------------------/ && $flag == "1"){
                	push(@filearray,"<p>"); 
                	push(@filearray,"<center>&lt;$i></center>\n");
			$flag = "0";
			next;
		}
		$flag = "1";
		$i++;

                push(@filearray,"<center>&lt;/$i></center>\n");
                push(@filearray,"</p>");

	}
	
	if($flag eq "1"){

        	$aline =~ s/---------------------------------------------//g;
       		$aline =~ s/---------------------------//g;

	        push(@filearray,"$aline");
        	push(@filearray,"</br>");

	}


}

close(THEFILE);



open(PAGE, "> Por✞land.html") or die "\nTHE PAGE DIDN'T OPEN: $filechapter\n";
	
	print PAGE "<html>\n";
	print PAGE "<head>\n";
	print PAGE "<title>The Detective Store: Revision Log</title>\n\n";

	print PAGE "<meta href=\"#Keywords\"    content=\"$metakeywords\" />\n";
	print PAGE "<meta href=\"#Description\"    content=\"$metadescription\" />\n\n";

	print PAGE "<link rel=\"icon\" href=\"../BookOne3.ico\" type=\"image/x-icon\" />\n";
	print PAGE "<link rel=\"shortcut icon\" href=\"../../BookOne3.ico\" type=\"image/x-icon\" />\n\n";
	
	
	#print meta copy data
	open(META, "<  ../../conf/Portland/common.conf") or die "\n../../conf/Portland/common.conf is not a file\n";
	while(<META>){

		print PAGE $_ . "\n";

	}
	close(META);
	
	print PAGE "\n\n";
	print PAGE "</head>\n";
	print PAGE "<body	color=\"black\"\n";
	print PAGE "		link=\"black\"\n";
	print PAGE "		vlink=\"black\"\n";
	print PAGE "		alink=\"black\">\n";
	print PAGE "\n";
	print PAGE "<div style=\"border-top : 2px solid black ; border-bottom : 2px solid black ; border-right : 2px solid black ; border-left : 2px solid black ; margin: 4%\">\n";
	print PAGE "\n";
	print PAGE "<br />\n";
	print PAGE "\n";
	print PAGE "<center>\n";
	print PAGE "&lt;\n";
	print PAGE "<a style=\"text-align: center; letter-spacing: 2px; font-size: 20px; font-family: Time New Roman; color:black;text-decoration:none\" href=\"http://books.goods.wordprostitute.com/Por✞landl\"> The Detective Store</a>\n";
	print PAGE ">\n";
	print PAGE "</center>\n";

	print PAGE "<br />\n";
	print PAGE "<br />\n";
	print PAGE "\n";
	print PAGE "\n";
	print PAGE "<br />\n";
	print PAGE "\n";
	print PAGE "<center>\n";
	print PAGE "<a style=\"text-align: center; letter-spacing: 2px; font-size: 20px; font-family: Time New Roman; color:black;text-decoration:none\" href=\"http://books.goods.wordprostitute.com/Por✞landl\">&lt;revision_log></a>\n";
	print PAGE "</center>\n";
	print PAGE "\n";
	print PAGE "<div style=\"margin: 3% ; padding-top: 10px; padding-bottom: 10px; padding-right: 10px;  padding-left: 10px; \">\n";
@reversefilearray = reverse(@filearray);
foreach $file (@reversefilearray){

	print PAGE $file;


}


print PAGE "</div>\n";
	print PAGE "\n";
	print PAGE "<center>\n";
	print PAGE "<a style=\"text-align: center; letter-spacing: 2px; font-size: 20px; font-family: Time New Roman; color:black;text-decoration:none\" href=\"http://books.goods.wordprostitute.com/Por✞landl\">&lt;/revision_log>\n";
	print PAGE "</center>\n";
	print PAGE "\n";
	print PAGE "\n";

	print PAGE "<br />\n";
	print PAGE "<br />\n";
	print PAGE "<br />\n";
	print PAGE "<br />\n";

	print PAGE "<center>\n";
	print PAGE "&lt;meta>\n";
	print PAGE "</center>\n";
	print PAGE "<br />\n";

	print PAGE "<p style=\"text-align: center; letter-spacing: 1px; line-height: 12px; font-size: 10px; font-family: Time New Roman; color:black; text-decoration:none\">\n";
	print PAGE "\n";

	
	print PAGE "<p style=\"text-align: center; letter-spacing: 1px; line-height: 12px; font-size: 10px; font-family: Time New Roman; color:black; text-decoration:none\">\n";
	print PAGE "<br /><a style=\"letter-spacing: 1px; line-height: 14px; font-size: 14px; text-decoration:none\" href=\"http://books.goods.wordprostitute.com/Por✞landl\">The Detective Store Revision Log</a>\n";
	print PAGE "<br />\n";
	print PAGE "<br />\n";
	print PAGE "<br />Copyright &#169; 2009 <a href=\"http://wordprostitute.com\">Word Prostitute</a>&reg;. <a href=\"http://wordprostitute.com/AllRightsReserved.html\">All Rights Reserved</a>.\n";
	print PAGE "<br />\n";
	print PAGE "<br />\n";
	print PAGE "</p>\n";
	
	print PAGE "\n";
	print PAGE "</p>\n";
	print PAGE "<br />\n";
	print PAGE "<center>\n";
	print PAGE "&lt;/meta>\n";
	print PAGE "</center>\n";


	print PAGE "<br />\n";
	print PAGE "<br />\n";
	print PAGE "<br />\n";
	print PAGE "\n";
	print PAGE "<center>\n";
	print PAGE "&lt;/\n";
	print PAGE "<a style=\"text-align: center; letter-spacing: 2px; font-size: 20px; font-family: Time New Roman; color:black;text-decoration:none\" href=\"http://books.goods.wordprostitute.com/Por✞landl\"> The Detective Store</a>\n";
	print PAGE ">\n";
	print PAGE "</center>\n";
	print PAGE "\n";
	print PAGE "<br />\n";
	print PAGE "\n";
	print PAGE "</body>\n";
	print PAGE "</html>\n";

close(PAGE);


