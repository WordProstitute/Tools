







sub findreplace{

	open(LOG, "> $commandandlog");

	open(FILE, "< $chapter")   or die "\nYOU NEED A FILE FOR A FILE OF WORDS THAT EXISTS TO FINDREPLACE: $chapter\n";

	open(EDITFILE, "> $chapter.edit");
	
	while(<FILE>){

        	foreach $key (sort (keys(%findreplacepatterns))){

 			$_ =~ s/$key/$findreplacepatterns{$key}/g;
		

			if ($_ =~ m/$findreplacepatterns{$key}/){

                                print LOG "<replaced_$key" . "_with_$findreplacepatterns{$key}>\n";
                                print LOG "$_";
                                print LOG "</replaced_$key" . "_with_$findreplacepatterns{$key}>\n";

                        }

		}

	       print EDITFILE $_;


	}
        close(EDITFILE);
        close(FILE);
        close(LOG);

}

sub patternerror{

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


sub patterncheck{

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



sub wordcheck{

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



sub dialog{

        open(LOG, "> $commandandlog");

        open(FILE, "< $chapter")  or die "\nYOU NEED A FILE FOR A FILE OF WORDS THAT EXISTS FOR DIALOG: $chapter\n";
 
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




sub internaldialog{

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





sub telepathic{

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




1;
