#!/usr/bin/perl

open(LOG, "> Giant_Hill_Valley.txt");
$eastTotal = "43";
$southTotalPlusOne = "35";
$southTotal = "34";
$east = "1";
$south = "1";
$hundredsided = "100";
$twentysided = "20";

$chance = "7";
$total = "1";


while($total < "250"){

	open(LOG, "> Giant_Hill_Valley_Greater.txt");
	print LOG "Giant Hill Valley Creature Chart\n";
	print LOG "----------------------------------\n";	

	$east = "1";
	$south = "1";

	for($south; $south < $southTotalPlusOne; $south++){

		$random = int(rand(7)) + 1;
	
		if($random eq "1"){
			$encounter = int(rand($hundredsided)) + 1;
			$amount = int(rand($twentysided)) + 1;
			print LOG "s" . $south . "e" . $east . " = " . "Creature " . $encounter . " Amount " . $amount . "\n";
			$total++;		
		}else{

		}

		if($south eq $southTotal){
			$south = "0";
			$east++;
		}

		if($east eq $eastTotal){
			print LOG "Total = " . $total;
			$east = "1";
			$south = "1";
			close(LOG);
			break;
		}

	}	

	close(LOG);

}



