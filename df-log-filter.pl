#!/usr/bin/env perl

use strict;
use warnings;
use Cwd 'abs_path';
use File::Basename;

my $script = dirname(abs_path($0)) . "/print-colored.pl";
my $beep = " albeep";
my @conditions = (
#spam info
	["^x([0-9])+", ""],
	["has created a masterpiece", ""],
	["has engraved a masterpiece", ""],
	["has become a", ""],	
#job cancellation	
	["Drop-off inaccessible", ""],
	["Job item misplaced", ""],
	["Item inaccessible", ""],
	["Equipment mismatch", ""],
	[" Getting something to ", ""],
	["Needs unrotten body part", ""],
	["Seeking Infant", ""],
#deadly strikes
	["tearing the brain", $script . " green"],
	["lower body(.+)and the severed part sails off in an arc", $script . " green"],
	["head(.+)and the severed part sails off in an arc", $script . " green"],	
#sparring/fighting	
	["but the shot is blocked", ""],
	[" lightly tapping ", ""],
	["charges at", ""],
	["latches on firmly", ""],
	[" bites ", ""],
	[" shakes ", ""],
	[" scratches ", ""],
	[" tearing the fat", ""],
	[" bruising the ", ""],
	["looks surprised", ""],
	["counterstrikes", ""],
	["collides", ""],
	["knocked over", ""],
	["stands up", ""],
	[" bounces ", ""],
	["looks sick", ""],
	["even more sick", ""],
	["trouble breathing", ""],
	["falls over", ""],
	["stunned", ""],
	["onslaught", ""],
	[" tangle together", ""],
	[" attacks ", ""],
	[" strikes ", ""],	
	[" misses ", ""],	
	[" regains ", ""],
	[" gives in to pain", ""],
	[" become enraged", ""],
	[" knocked unconscious", ""],
	[" has been opened", ""],
	[" bashes ", ""],
	[" blocks ", ""],
	[" loses hold ", ""],
	[" vomit", ""],
	[" twists", ""],
	[" tendon (.+) torn", ""],
	["lodged firmly", ""],
#danger/death	
	["stolen", $script . " magenta"],
	["Dangerous terrain", $script . $beep . " red"],	
	["^An ambush! ", $script . $beep . " red"],
	["ile force of ", $script . $beep . " red"],
	["Interrupted by", $script . $beep . " red"],
	["drowned", $script . $beep . " red"],
	[" died ", $script . $beep . " red"],
	["^The (.+) struck", $script . " magenta"],	#indicates that an unnamed being has been slaughtered/killed
	["^You have struck", $script . " yellow"],	# some stone has been discovered
	["struck", $script . $beep ." red"],	#indicates that a named being has been struck down, most likely of our population.
#game pausing/important events	
	["Praise the miners", $script . $beep . " green"], #adamantine discovered
	[" has bestowed the name ", $script . $beep . " yellow"], #named a weapon
	#merchants
	["will be leaving soon", $script . $beep . " yellow"],
	["embarked", $script . " yellow"],
	["arrived", $script . $beep . " yellow"],
	#moods
	[" withdraws from society", $script . $beep . " white"],
	[" fey mood", $script . $beep . " white"],
	[" posessed", $script . $beep . " white"],
	[" claimed ", $script . $beep . " white"],
	[" begun a mysterious construction", $script . $beep . " white"],
	[" has created ", $script . $beep . " white"],
	#damn, more dwarfes/pets -> lower fps.
	[" has given birth to a (girl|boy)", $script . $beep . " blue"],
	[" has given birth to a", $script . " blue"],
#other interesting info	
	["has mandated ", $script . $beep . " yellow"],
	["has imposed a ban ", $script . $beep . " yellow"],
	["has grown to", $script . " blue"],
	["has been completed", $script . " cyan"],
	[" suspended the",  $script . $beep . " yellow"]
);

while (<>) {
	#chomp;
	my $matched = 0;
	foreach my $cond(@conditions) {
		my $regex = $cond->[0];
		my $cmd = $cond->[1];
		if ($_ =~ /$regex/) {			
			my @args = split " ", $cmd;
			system @args, $_ if $cmd ne "";
			$matched = 1;
			last;
		}
	}
	if (!$matched) {
		# TODO place code to print when no regex matched
		print;
	}
}
