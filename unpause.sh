#!/usr/bin/env bash
DIR=`dirname $0`
$DIR/print-colored.pl blue 'unpausing the game...\n'
$DIR/libxauto_sendtext `$DIR/libxauto_findwindow "Dwarf Fortress"` " "
