#!/usr/bin/perl -w
my $writedata="N";
my $index=1;
#open FILE, ">clear.data".$index.".txt" or die $!;


while ( my $str = <STDIN> ) {


if ( index($str,"box-778-in") > -1 ) {$writedata="Y"; open FILE, ">clear.data".$index.".txt" or die $!;print "1";}

if ( index($str,"foot-778-sm") > -1 ) {$writedata="N"; close FILE; $index++;last;}


    if ( $writedata eq "Y" ) {
      print FILE $str;
    }
}


