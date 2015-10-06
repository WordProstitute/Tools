#!/usr/bin/perl


use File::Path;
use File::Copy;
require "../../conf/$ARGV[0]/common.conf";
require "../../conf/$ARGV[0]/$ARGV[1].template";


our $chapter;
our $wordfile;
our $bookfile;
our @pagelines;
our $int;
our $mod;
our %arraycover;
our $special;
@arraycover{ @chapters } = (0 .. $#chapters);
$delim = $chapterdelim;


open(LOG, "> log.txt");

print LOG "##############\n";
print LOG "Print $ARGV[0] version $ARGV[1]\n";
print LOG "##############\n";

# Clean ouput foldier
if (-d $bookpath){
	my $resultDir = system("rm -dR $bookpath");
	print LOG "\nClean: $resultDir\n";
	print "\nPath: $bookpath\n";
}


#Set name and delete book file.
$bookname = $ARGV[0] if ($ARGV[1] eq "epub");
$bookname = $ARGV[1] if ($ARGV[1] eq "Amazon" or $ARGV[1] eq "Nook");

if(-f "$outputpath$bookname.epub"){

	system("rm $outputpath$bookname.epub");
	print LOG "\nClean: $resultFile\n";
	print "\nPath: $outputpath$bookname.epub\n";
}

if(-e "$outputpath$bookname.mobi"){

	system("rm  $outputpath$bookname.mobi");
	print LOG "\nClean: $resultFile\n";
	print "\nPath: $outputpath$bookname.mobi\n";

}

# Create output folder
mkpath($bookpath);
print LOG "\nMake root dir: $bookpath\n";

# Create sub directories if they exist.
for my $subdir (@subdirectories){
	mkdir($bookpath . $subdir);
	print LOG "Make subdir: $bookpath . $subdir\n";
}


# Print Pages...
foreach $chapter (@chapters){

	$specialflag = "no";
	foreach my $key (keys %uniquepages) {

		foreach (@{$uniquepages{$key}}) {

			if($chapter =~ /\//){

				our ($uniquedir,$uniquechapter) = split /\//,$chapter if($chapter =~ /\//);        	}else{
				$uniquechapter = $chapter;	
			}
	
			if($uniquechapter =~ /$_/){

				$special = $chapter;
				$specialflag = "yes";
			
			}

			if($uniquechapter =~ /$_/ && $ARGV[1] eq "HTML" && $key eq "index"){

				$special = $chapter;
				$index = "yes";
				$chapterdir = $uniquedir;
				$specialflag = "yes";
				#$chapter = $uniquedir . "/index";
			
			}

    		}

	}

	#if($chapter =~ /$special/){next;}

	$int = $arraycover{ $chapter };
        
	if($chapters[$int + 1] =~ /$special/){
                $mod = "1";

        } else {
                $mod = "1";
        }

        if($chapters[$int - 1] =~ /$special/){
		$modprev = "1";
		
	} else {
		$modprev = "1";
	}
	
	$chapternextline = $chapters[$int + $mod];
	if($alwaysprintpreviousandnext eq "yes" && $int eq $chaptersend){

		$chapternextline = $chapters[$chaptersbegin];

	}
        $chapternextnoline = $chapternextline;
	$chapternextline =~ s/ /_/g;
        $chapterpreviousline = $chapters[$int - $modprev];
        $chapterpreviousnoline  = $chapterpreviousline;
        $chapterpreviousline  =~ s/ /_/g;
	if (($int eq 1) && ($alwaysprintpreviousandnext ne "yes")){$chapterpreviousnoline = "";}
	if (($int eq 1) && ($alwaysprintpreviousandnext ne "yes")){$chapterpreviousline = "";}
	$chapterline = $chapter;
	$chapternoline = $chapter;
	$chapterline =~ s/ /_/g;

	
        if($chapterdelim =! ""){$chapternextnoline =~ s/\//$delim/g;}
        if($chapternextnoline =~ /$special/){ 
		($chapternextnoline,$waste) = split /$delim/,$chapternextnoline;
		#print "\nDelim..." .  $chapternextnoline . " " . $delim . " \n";
	}
	
        if($chapterdelim =! ""){$chapterpreviousnoline  =~ s/\//$delim/g;}
       	if($chapterpreviousnoline =~ /$special/){
                ($chapterpreviousnoline,$waste) = split /$delim/,$chapterpreviousnoline;
        }

	if($chapterdelim =! ""){$chapternoline =~ s/\//$delim/g;}
        if($chapternoline =~ /$special/){
                ($chapternoline,$waste) = split /$delim/,$chapternoline;
        }


        if($ispathrelative =~ /yes/){

                ($splitwaste,$chapternextline) = split /\//,$chapternextline if ($chapterline =~ /\//);
                ($splitwaste,$chapterpreviousline) = split /\//,$chapterpreviousline if ($chapterline =~ /\//);
                ($splitwaste,$chapterline) = split /\//,$chapterline if ($chapterline =~ /\//);
        }



	foreach $key (sort keys %findreplaceprintpatterns) {
     		$chapternextline =~ s/$key/$findreplaceprintpatterns{$key}/g;
		$chapterpreviousline =~ s/$key/$findreplaceprintpatterns{$key}/g;
		$chapterline =~ s/$key/$findreplaceprintpatterns{$key}/g;
		$chapternextnoline =~ s/$key/$findreplaceprintpatterns{$key}/g;
		$chapterpreviousnoline =~ s/$key/$findreplaceprintpatterns{$key}/g;		
		$chapternoline =~ s/$key/$findreplaceprintpatterns{$key}/g;

		print LOG "\n#################\n";
		print LOG "$chapternextline =~ s/$key/$findreplaceprintpatterns{$key}/g\n";
		print LOG "$chapternoline\n";
	}


	if($singlefile eq "yes" && $lastchapter eq $chapter)	{

		$footerelementflag = "0";

	}elsif($singlefile eq "yes"){

		$footerelementflag = "1";

	}

	$wordfile = $wordpath . $chapter . $wordsuffix;


	($chapterdir,$chapter) = split /\//,$chapter if ($singledir eq "yes" && $chapter =~ /\//);
	$bookfile = $pagepath . $chapter . $booksuffix;
	$bookfile = $pagepath . $chapterdir . "/index" . $booksuffix if ($index eq "yes");
	$index = "no";
	$bookfile = $pagepath . $ARGV[0] . $booksuffix if ($singlefile eq "yes");	


	$wordfile =~ s/ /_/g;
	$bookfile =~ s/ /_/g;

	open(WORDS, "< $wordfile") or die "\nYOU NEED A FILE FOR A FILE OF WORDS THAT EXISTS: $wordfile\n"; 
		
	while(<WORDS>){
		push(@pagelines,$_) unless ($_ =~ /^\s+$/);
		#print "Pageline $chapternoline: $_\n";
	}
	close(WORDS);

	open(PAGE, "> $bookfile") or die "\nTHE PAGE DIDN'T OPEN: $bookfile\n"  if ($singlefile ne "yes");

	open(PAGE, ">> $bookfile") or die "\nTHE PAGE DIDN'T OPEN THE SINGLE PAGE: $bookfile\n" if ($singlefile eq "yes");
	
	if($headelementflag eq "0"){

		$headelementflag="1" if($singlefile eq "yes");

		foreach $headelement (@htmlhead){
			print PAGE "$headelement";
			
		}
	
	}


	if($specialflag ne "yes"){
		foreach $bodyheader (@htmlbodyheader){
			
			print PAGE "$bodyheader";
				
		}
	}


	
	if($specialflag eq "yes"){

		foreach $pageline (@pagelines){

			$pageline =~ s/onclick=\".*\"//g if($ARGV[1] ne "HTML");
			$pageline =~ s/bgcolor=\".*\"//g if($ARGV[1] ne "HTML");
			$pageline =~ s/text=\".*\"//g if($ARGV[1] ne "HTML");
			$pageline =~ s/class=\".*\"/style=\"$uniquePageStyles{$chapter}\"/g if($ARGV[1] eq "Nook");
			if($ARGV[1] eq "Nook" or $ARGV[1] eq "Amazon"){
				
				foreach $key (sort keys %characterimages) {
					#print "\n/$key/$characterimages{$key} \n";
					$pageline =~ s/$key/$characterimages{$key}/g;

				}

			}
			if(%specialpageneeds ne ""){
				foreach $need (sort keys %specialpageneeds) {
					#print "\n$pageline = /$need/$specialpageneeds{$need} \n";
					$pageline =~ s/$need/$specialpageneeds{$need}/g;

				}
			}



			print PAGE $pageline . "\n";
		}

	}else{


	#This is to reset the array to loop.
	@bodytop =   @htmlbodytop; 

        foreach (@bodytop){
		
	        #Search and replace for previous chapter no underline
        	$_ =~  s/PREVIOUSCHAPTER_NOLINE/$chapterpreviousnoline/g;
        	
		#Search and replace for next chapter no underline
		$_ =~  s/NEXTCHAPTER_NOLINE/$chapternextnoline/g;
        	
		#Search and replace for chapter no underline.
        	$_  =~  s/CHAPTER_NOLINE/$chapternoline/g;
        	
		#Search and replace for previous chapter
                if($chapterpreviousline =~/$special/i){
			($chapterpreviouslineno,$waste) = split /\//,$chapterpreviousline;
        		$_ =~  s/PREVIOUSCHAPTER/$chapterpreviouslineno/g;

		}else{
               		$_ =~  s/PREVIOUSCHAPTER/$chapterpreviousline$booksuffix/g;
		}

		#Search and replace for next chapter
		if($chapternextline =~ /$special/i){
			
			($chapternextlineno,$waste) = split /\//,$chapternextline; 
        		$_ =~  s/NEXTCHAPTER/$chapternextlineno/g;

		}else{
			$_ =~  s/NEXTCHAPTER/$chapternextline$booksuffix/g;
		}	

        	#Search and replace for chapter
		if($chapterline =~ /$special/i){

			($chapterlineno,$waste) = split /\//,$chapterline;
        		$_ =~  s/CHAPTER/$chapterlineno/g;

		}else{

			$_ =~  s/CHAPTER/$chapterline$booksuffix/g;

		}	

		print PAGE $_;
		

        }




	$paragraphcounter = $bookparagraphcounter;

	foreach $pageline (@pagelines){

		chomp($pageline);
		
		if($binarypage =~ /yes/i){
			$binarycounterhold = $paragraphcounter;
			$paragraphcounter = sprintf("%b", $paragraphcounter);								
		}

		$pageline =~ s/</&lt;/g;

		print PAGE "<a name=\"$paragraphcounter\">\n\n" if($anchorparagraph =~ "yes");
		print PAGE "<a style=\"text-decoration: none\" href=\"#" . $paragraphcounter . "\">\n" if($anchorparagraph =~ "yes");
		print PAGE $paragraphtag[0];
		print PAGE "$pageline\n";
		print PAGE $paragraphtag[1];
		print PAGE "</a>\n"  if($anchorparagraph =~ "yes");
		print PAGE "</a>\n\n"  if($anchorparagraph =~ "yes");
		
		if($binarypage =~ /yes/i){
			$paragraphcounter = $binarycounterhold;
		}

		$paragraphcounter++;

	}


	if($restcounter =~ /yes/i){$paragraphcounter = $bookparagraphcounter;}


	#This is to reset the array to loop.
        @bodybottom =   @htmlbodybottom;

        foreach (@bodybottom){

                #Search and replace for previous chapter no underline
                $_ =~  s/PREVIOUSCHAPTER_NOLINE/$chapterpreviousnoline/g;

                #Search and replace for next chapter no underline
                $_ =~  s/NEXTCHAPTER_NOLINE/$chapternextnoline/g;

                #Search and replace for chapter no underline.
                $_  =~  s/CHAPTER_NOLINE/$chapternoline/g;

 		#Search and replace for previous chapter
                if($chapterpreviousline =~/$special/i){

                       ($chapterpreviouslineno,$waste) = split /\//,$chapterpreviousline; 
			$_ =~  s/PREVIOUSCHAPTER/$chapterpreviouslineno/g;

                }else{
                        $_ =~  s/PREVIOUSCHAPTER/$chapterpreviousline$booksuffix/g;
                }

                #Search and replace for next chapter
                if($chapternextline =~ /$special/i){

                        ($chapternextlineno,$waste) = split /\//,$chapternextline;
                        $_ =~  s/NEXTCHAPTER/$chapternextlineno/g;

                }else{
                        $_ =~  s/NEXTCHAPTER/$chapternextline$booksuffix/g;
                }

                #Search and replace for chapter
                if($chapterline =~ /$special/i){

                        ($chapterlineno,$waste) = split /\//,$chapterline;
                        $_ =~  s/CHAPTER/$chapterlineno/g;

                }else{
                        $_ =~  s/CHAPTER/$chapterline$booksuffix/g;
                }

                print PAGE $_;

        }


	}	

	if($footerelementflag eq "0"){

	        foreach $copyelement (@copyright){

                	print PAGE $copyelement if ($specialflag eq "yes" || $ARGV[1] eq "HTML");
        	}

	

        	foreach $footelement (@htmlfooter){
			if(%specialpageneeds ne ""){
				foreach $need (sort keys %specialpageneeds) {
					#print "\n$footelement = /$need/$specialpageneeds{$need} \n";
					$footelement =~ s/$need/$specialpageneeds{$need}/g;

				}
			}
                	print PAGE $footelement;

        	}

	}

	@pagelines = ();

	close(PAGE);



}

if ($ARGV[1] eq "epub" or $ARGV[1] eq "Amazon"  or $ARGV[1] eq "Nook"){

	#If nook or what ever requires files.


	#Make mime
	open(MIME,"> $mimetypefile") or die "\nNO MIME FILE! HERE => $mimetypefile\n";
	foreach $mimeline (@mimetype){

		chomp($mimeline);
		print MIME $mimeline;	

	}
	close(MIME);

	#Print container.xml
	open(CONTAINER, "> $containerxmlfile") or die "NO container.xml at $containerxmlfile created!\n";
	foreach $containline (@containxml){

		print CONTAINER $containline . "\n";

	}
	close(CONTAINER);


	#Print content.opf
	open(CONTENT, "> $contentopf") or die "No content.opf to open at this location $contentopf!\n";
	foreach $content (@contentopf){

		print CONTENT $content;		

	}
	close(CONTENT);

	#Print toc.ncx
	open(TOC, "> $tocncx") or die "No toc.ncx open here => $tocncx.\n";
	foreach $toc (@tocncx){

		print TOC $toc;

	}
	close(TOC);

	#Print style sheet
	open(STYLE, "> $stylesheet") or die "No style open here => $stylesheet.\n";
	foreach $sheet (@stylesheet){

		print STYLE $sheet;

	}
	close(STYLE);

	#print "\n$coverimage, $imagefile\n";
	copy($coverimage, $imagefile);
	#If nook or what ever requires files.
	for $bookimage(@bookimages){
		#print "\n$characterimagedir$bookimage, $imagepath$bookimage\n";
		copy("$characterimagedir$bookimage", "$imagepath$bookimage");

	}


	#The file name is variable depending on the format.
	#If this is Amazon then it still needs to become a mobi file.
	$bookname = $ARGV[0] if ($ARGV[1] eq "epub");
	$bookname = $ARGV[1] if ($ARGV[1] eq "Amazon" or $ARGV[1] eq "Nook");
	#zip
	system("ant -f $zip -Depub=$outputpath$bookname.epub -Dsrc=$bookpath");


	#check file...
	system("java -jar $epubcheck $outputpath$bookname.epub");

}


if ($ARGV[1] eq "Amazon" ){

	system("$kindlegen $outputpath$bookname.epub");
}

close(LOG);
