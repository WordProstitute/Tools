#!/usr/bin/perl

##
# Word Prostitute(R)'s copy-edit script.
# by 
# Kalab J. OsterTM
##
use File::Copy;

if($ARGV[0] eq "" or $ARGV[1] eq "" or $ARGV[2] eq ""){

	print "\n##";
        print "\n# Instructions:";
        print "\n#";
        print "\n# Commandline Input Format:";
        print "\n# 	perl copy-edit.pl <book> <chapter> <command>";
        print "\n#	or an example...";
        print "\n#	copy-edit.pl Portland Rome findreplace";
        print "\n#";
        print "\n#	copy-edit.pl = 	The script using the values ";
        print "\n#		       	for variables to perform a"; 
        print "\n#		 	process";
        print "\n#";
        print "\n#	book = 	This is the file name of the configuration";
        print "\n# 		file found in ../../conf. It is typically"; 
        print "\n#		the name of the book to copy-edit.";
        print "\n#";
        print "\n#	chapter = This is the file name of the book to edit.";
        print "\n#		  It is used to complete the path locally";	
        print "\n#		  to the chapter file to copy-edit";
        print "\n#";
        print "\n#	command = The command to execute."; 
        print "\n##\n\n";
}


require "../../conf/book/" . $ARGV[0] . "/" . "common.conf";
require "../../conf/book/" . $ARGV[0] . "/" . "edit.conf";
my $chapter = $wordpath . $ARGV[1] . $wordsuffix;
my $commandandlog = $ARGV[2];

#print "\nConfiguration path: [../../conf/" . $ARGV[0] . "/" . "common.conf].";
#print "\nChapter path: [$chapter].\n";

# find and replace.
if($commandandlog =~ /findreplace/){

	open(LOG, "> $commandandlog");

	open(FILE, "< $chapter")   or die "\nYOU NEED A FILE FOR A FILE OF WORDS THAT EXISTS TO FINDREPLACE: $chapter\n";

	open(EDITFILE, "> $chapter.edit");
	
	while(<FILE>){

        	foreach $key (sort (keys(%findreplacepatterns))){

 			$_ =~ s/$key/$findreplacepatterns{$key}/g;
		

			if ($_ =~ m/$key/){

                                print LOG "<replaced_$key" . "_with_$findreplacepatterns{$key}>\n";
                                print LOG "$_";
                                print LOG "</replaced_$key" . "_with_$findreplacepatterns{$key}>\n";

                        }

		}

	       print EDITFILE $_;


	}
	print EDITFILE "\n";
        close(EDITFILE);
        close(FILE);
        close(LOG);

	copy("$chapter.edit","$chapter");
}

if($commandandlog =~ /patternerror/){

        open(LOG, "> $commandandlog");

	foreach $patterncheck (@patternerror) {

        	open(FILE, "< $chapter")  or die "\nYOU NEED A FILE FOR A FILE OF WORDS THAT EXISTS TO PATTERCHECK: $chapter\n";

        	while(<FILE>){
			
			if ($_ =~ m/$patterncheck/){

	                	print LOG "<$patterncheck>\n";
                        	print LOG "$_\n"; 
                        	print LOG "</$patterncheck>\n";		
			
			}


		}
		close(FILE);

	}
	close(LOG);

}


if($commandandlog =~ /patterncheck/){

        open(LOG, "> $commandandlog");

        foreach $patterncheck (@patterncheck) {

                open(FILE, "< $chapter")  or die "\nYOU NEED A FILE FOR A FILE OF WORDS THAT EXISTS TO PATTERCHECK: $chapter\n";

                while(<FILE>){

                        if ($_ =~ m/$patterncheck/){

                                print LOG "<$patterncheck>\n";
                                print LOG "$_\n";
                                print LOG "</$patterncheck>\n";   

                        }


                }
                close(FILE);

        }
        close(LOG);

}

if($commandandlog =~ /wordcheck/){

        open(LOG, "> $commandandlog");

        foreach $patterncheck (@wordcheck) {

                open(FILE, "< $chapter")  or die "\nYOU NEED A FILE FOR A FILE OF WORDS THAT EXISTS TO PATTERCHECK: $chapter\n";

                while(<FILE>){

                        if ($_ =~ m/$patterncheck/){

                                print LOG "<$patterncheck>\n";
                                print LOG "$_\n";
                                print LOG "</$patterncheck>\n";

                        }


                }
                close(FILE);

        }
        close(LOG);

}



if($commandandlog =~ /spellcheck/){

        open(LOG, "> $commandandlog");

        open(FILE, "< $chapter")  or die "\nYOU NEED A FILE FOR A FILE OF WORDS THAT EXISTS TO SPELLCHECK: $chapter\n";

	#http://search.cpan.org/~hank/Text-Aspell/Aspell.pm

	# Read paragraph.

	# Set printmisspelledparagraph to 0.

	# Loop through each word of paragraph.

	# In the loop, spellcheck the word.

	# If word not found then return to next word. 

	# If word found push to misspelled array and go to next word and set printmisspelledparagraph flag to 1

	# If last word and printmisspelledparagraph flag to 0 then read the next paragraph and begin again.

	# If last word and  printmisspelledparagraph flag to 1 then print the misspelled array with the paragraph and its details.

        close(FIiE);

        close(LOG);

}


if($commandandlog =~ /dialog/){

        open(LOG, "> $commandandlog");

        open(FILE, "< $chapter")  or die "\nYOU NEED A FILE FOR A FILE OF WORDS THAT EXISTS FOR DIALOG: $chapter\n";
        #print "\n The Chapter $chapter.";
        while(<FILE>){

                if($_ =~ /$dialogbegin/){
			
			print LOG "############################################\n";	
		
		}

                if($_ =~ /$dialogend|$dialogbegin|$dialogcontinue/ ){

			print LOG $_;

                }

        }
        close(FILE);

        close(LOG);

}


if($commandandlog =~ /internaldialog/){

        open(LOG, "> $commandandlog");

        open(FILE, "< $chapter")  or die "\nYOU NEED A FILE FOR A FILE OF WORDS THAT EXISTS FOR INTERNALDIALOG: $chapter\n";
 
        while(<FILE>){

                if($_ =~ /$internaldialogbegin/){

                        print LOG "############################################\n";

                }

                if($_ =~ /$internaldialogend|$internaldialogbegin|$internaldialogcontinue/ ){

                        print LOG $_;

                }

        }
        close(FILE);

        close(LOG);

}

if($commandandlog =~ /telepathic/){

        open(LOG, "> $commandandlog");

        open(FILE, "< $chapter")  or die "\nYOU NEED A FILE FOR A FILE OF WORDS THAT EXISTS FOR TELEPATHIC DIALOG: $chapter\n";
 
        while(<FILE>){

                if($_ =~ /$telepathicdialogbegin/){

                        print LOG "############################################\n";

                }

                if($_ =~ /$telepathicdialogend|$telepathicdialogbegin|$telepathicdialogcontinue/ ){

                        print LOG $_;

                }

        }
        close(FILE);

        close(LOG);

}

