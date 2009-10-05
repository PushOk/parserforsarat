#!/usr/bin/perl -w
my $writedata="N";
open FILE, ">clear.data.txt" or die $!;


while ( my $str = <STDIN> ) {


if ( index($str,"sidebar") > -1 ) {$writedata="Y";}

if ( index($str,"sb-foot-2") > -1 ) {$writedata="N";last;}


    if ( $writedata eq "Y" ) {
      print FILE $str;
    }
}

close FILE;