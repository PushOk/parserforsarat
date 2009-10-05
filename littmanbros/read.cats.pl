#!/usr/bin/perl -w
my $writedata="N";
open FILE, ">catalogs.txt" or die $!;
open URL, ">urls.txt" or die $!;



while ( my $str = <STDIN> ) {

if  (index($str,"<li>") > -1 ) {
    if ($str =~ /\<li\>\<a href=\"(.*)\"\>(.*)\<\/a\>\<\/li\>/){
        print FILE "\"$1\";\"";
        print FILE $2."\"";
        print FILE "\n";
        print URL $1;
        print URL "\n";
    }
}


}

close FILE;
close URL;