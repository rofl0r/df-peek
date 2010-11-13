#!/usr/bin/env perl

use strict;
use warnings;

my $default = "\033[98m";
my $white = "\033[97m";
my $cyan = "\033[96m";
my $magenta = "\033[95m";
my $blue = "\033[94m";
my $yellow = "\033[93m";
my $green = "\033[92m";
my $red = "\033[91m";
my $gray = "\033[90m";
my $cend = "\033[0m";

my $colsel = shift(@ARGV);
	
my $color = $default;
if ($colsel eq "blue") {
	$color = $blue;
} elsif ($colsel eq "yellow") {
	$color = $yellow;	
} elsif ($colsel eq "green") {
	$color = $green;
} elsif ($colsel eq "red") {
	$color = $red;
} elsif ($colsel eq "white") {
	$color = $white;
} elsif ($colsel eq "cyan") {
	$color = $cyan;
} elsif ($colsel eq "magenta") {
	$color = $magenta;
} elsif ($colsel eq "gray") {
	$color = $gray;
}

print $color;
print join(" ", @ARGV);
print $cend;
