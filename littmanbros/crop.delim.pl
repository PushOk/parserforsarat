#!/usr/bin/perl -w
my $writedata="N";
my $alldata="";
my $key;
my $val;
my $null;
#main:$product;
while ( my $str = <STDIN> ) {


if ( index($str,"-----") > -1 ) {
         $writedata="Y";
#         print $alldata;
#         sleep(1);
         $alldata="";
         }


    if ( $writedata eq "Y" ) {
    if (index($str,"-----") == -1){
         $alldata.=$str;
        # if ($str =~ /(.*)/) {
            ($key,$val,$null) = split("=",$str);
            chomp($key);
            chomp($val);
        #    $product{'$key'} = $val;
            print $key." = ".$val."\n";
#            sleep(1);
         #}
     }
    }
}
