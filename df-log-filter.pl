#!/usr/bin/env perl

use strict;
use warnings;
use Cwd 'abs_path';
use File::Basename;

my $script = dirname(abs_path($0)) . "/print-colored.pl";
my $beep = dirname(abs_path($0)) . "/beep";
my $unpause = dirname(abs_path($0)) . "/unpause.sh";


#uncommented line below to use pc speaker
#my $beep = dirname(abs_path($0)) . "perl -e 'print \"\\a\"'";

my @conditions = (
#spam info
	["^x([0-9])+", [""]],
	["has created a masterpiece", [""]],
	["has engraved a masterpiece", [""]],
	["has become a", [""]],	
#job cancellation	
	["Drop-off inaccessible", [""]],
	["Job item misplaced", [""]],
	["Item inaccessible", [""]],
	["Equipment mismatch", [""]],
	[" Getting something to ", [""]],
	["Needs unrotten body part", [""]],
	["Needs butcherable unrotten nearby item", [""]],
	["Seeking Infant", [""]],
#deadly strikes
	["tearing the brain", [$script . " green"]],
	["lower body(.+)and the severed part sails off in an arc", [$script . " green"]],
	["head(.+)and the severed part sails off in an arc", [$script . " green"]],	
#sparring/fighting	
	["but the shot is blocked", [""]],
	[" lightly tapping ", [""]],
	["charges at", [""]],
	["latches on firmly", [""]],
	[" bites ", [""]],
	[" shakes ", [""]],
	[" scratches ", [""]],
	[" tearing the fat", [""]],
	[" bruising the ", [""]],
	["looks surprised", [""]],
	["counterstrikes", [""]],
	["collides", [""]],
	["knocked over", [""]],
	["stands up", [""]],
	[" bounces ", [""]],
	["looks sick", [""]],
	["even more sick", [""]],
	["trouble breathing", [""]],
	["falls over", [""]],
	["stunned", [""]],
	["onslaught", [""]],
	[" tangle together", [""]],
	[" attacks ", [""]],
	[" strikes ", [""]],	
	[" misses ", [""]],	
	[" regains ", [""]],
	[" gives in to pain", [""]],
	[" become enraged", [""]],
	[" knocked unconscious", [""]],
	[" has been opened", [""]],
	[" bashes ", [""]],
	[" blocks ", [""]],
	[" loses hold ", [""]],
	[" vomit", [""]],
	[" twists", [""]],
	[" tendon (.+) torn", [""]],
	["lodged firmly", [""]],
#danger/death	
	["stolen", [$script . " magenta"]],
	["Dangerous terrain", [$script . " red", $beep]],	
	["^An ambush! ", [$script . " red", $beep]],
	["^A vile force of ", [$script . " red", $beep]],
	["^The forgotten beast (.+) has come", [$script . " red", $beep]],
	["Interrupted by", [$script . " red", $beep]],
	[" has bled to death.", [$script . " red", $beep]],	
	["drowned", [$script . " red", $beep]],
	[" died ", [$script . " red", $beep]],
	["^The (.+) struck", [$script . " magenta"]],	#indicates that an unnamed being has been slaughtered/killed
	["^You have struck", [$script . " yellow", $beep]],	# some stone has been discovered
	["struck", [$script . " red", $beep]],	#indicates that a named being has been struck down, most likely of our population.
	[" is throwing a tantrum", [$script . " red", $beep]],
	[" has gone berserk", [$script . " red", $beep]],
	[" Went insane", [$script . " red", $beep]],
#game pausing/important events	
	["(D|d)amp (S|s)tone", [$script . " yellow", $beep, $unpause]],
	["Praise the miners", [$script . " green", $beep]], #adamantine discovered
	[" has bestowed the name ", [$script . " yellow", $beep, $unpause]], #named a weapon
	#merchants
	["will be leaving soon", [$script . " yellow", $beep]],
	["embarked", [$script . " yellow"]],
	["arrived", [$script . " yellow", $beep, $unpause]],
	#moods
	[" withdraws from society", [$script . " white", $beep, $unpause]],
	[" fey mood", [$script . " white", $beep]],
	[" posessed", [$script . " white", $beep]],
	[" claimed ", [$script . " white", $beep, $unpause]], #remove the unpause tag in a fresh game, when its likely you dont have everything in stock urist mcmood wants.
	[" begun a mysterious construction", [$script . " white", $beep]], #dont unpause, so you can still forbid stuff
	[" has created ", [$script . " white", $beep]], #dont unpause, so you can look what he created
	#damn, more dwarfes/pets -> lower fps.
	[" has given birth to a (girl|boy)", [$script . " blue", $beep, $unpause]],
	[" has given birth to ", [$script . " blue"]],
#other interesting info	
	["has mandated ", [$script . " yellow", $beep]],
	["has imposed a ban ", [$script . " yellow", $beep]],
	["has grown to", [$script . " blue"]],
	["has been completed", [$script . " cyan"]],
	[" suspended the", [$script . " yellow", $beep]]
);

while (<>) {
	#print; #uncomment to see which line may have caused an error.
	my $matched = 0;
	foreach my $cond(@conditions) {
		my $regex = $cond->[0];
		my $cmds = $cond->[1];
		if ($_ =~ /$regex/) {
			for(my $i = 0; $i <= $#$cmds; $i++) {			
				my $cmd = $cmds->[$i];
				my @args = split " ", $cmd;
				system @args, $_ if $cmd ne "";
				$matched = 1;				
			}
			last if $matched;
		}
	}
	if (!$matched) {
		# TODO place code to print when no regex matched
		print;
	}
}
