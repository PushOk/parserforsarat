#!/usr/bin/perl -w
my $writedata="N";
my $dir="./tmp/products/";
my $counter=1;
#open FILE, ">./tmp/products/clear.data.txt" or die $!;


while ( my $str = <STDIN> ) {


if ( index($str,"generateLink") > -1 ) {
         $writedata="Y";
         open FILE, ">$dir$counter.html.conv" or die $!;
      }

if ( index($str,"div class=\"clear\"") > -1 ) {$writedata="N";print "$counter\n";close FILE;$counter++;}


    if ( $writedata eq "Y" ) {
      print FILE $str;
    }
}
