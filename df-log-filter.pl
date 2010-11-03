#!/usr/bin/env perl

use strict;
use warnings;
use Cwd 'abs_path';
use File::Basename;

my $script = dirname(abs_path($0)) . "/print-colored.pl";
my $beep = " albeep";
my @conditions = (
	["^x([0-9])+", ""],
	["Job item misplaced", ""],
	["Item inaccessible", ""],
	["Equipment mismatch", ""],
	["Needs unrotten body part", ""],
	["has created a masterpiece", ""],
	["but the shot is blocked", ""],
	[" lightly tapping ", ""],
	["charges at", ""],
	["looks surprised", ""],
	["counterstrikes", ""],
	["collides", ""],
	["knocked over", ""],
	["stands up", ""],
	["looks sick", ""],
	["even sick", ""],
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
	["A tendon .+ torn", ""],
	["lodged firmly", ""],
	["has become a", ""],
	["Drop-off inaccessible", ""],
	["^An ambush! ", $script . $beep . " red"],
	["ile force of ", $script . $beep . " albeep red"],
	["Interrupted by", $script . " albeep red"],
	["has grown to", $script . " blue"],
	["drowned", $script . $beep . " red"],
	[" died ", $script . $beep . " red"],
	["stolen", $script . " magenta"],
	["will be leaving soon", $script . $beep . " yellow"],
	["embarked", $script . " yellow"],
	["arrived", $script . $beep . " yellow"],
	["has been completed", $script . " cyan"],
	["tearing the brain", $script . " green"],
	["lower body(.+)and the severed part sails off in an arc", $script . " green"],
	["head(.+)and the severed part sails off in an arc", $script . " green"],
	["^The (.+) struck", ""],
	["struck", $script . " albeep red"],
	[" withdraws from society", $script . $beep . " white"],
	[" fey mood", $script . $beep . " white"],
	[" posessed", $script . $beep . " white"],
	[" claimed ", $script . $beep . " white"],
	[" begun a mysterious construction", $script . $beep . " white"],
	[" has given birth to a (girl|boy)", $script . $beep . " blue"],
	[" has given birth to a", $script . " blue"],
	[" suspended the",  $script . " yellow"]
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
