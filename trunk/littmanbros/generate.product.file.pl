#!/usr/bin/perl -w
use HTML::Strip;
my $writedata="N";
open FILE, ">product.data.csv" or die $!;
main:$product{'name'}="undef";
main:$product{'min_pic_url'}="undef";
main:$product{'big_pic_url'}="undef";
main:$product{'price'}="undef";
main:$product{'link'}="undef";
my $null;
my $go = 'N';
while ( my $str = <STDIN> ) {

if ( index($str,"generateLink") > -1 ) {
$go = 'Y';
main:$product{'name'}="undef";
main:$product{'min_pic_url'}="undef";
main:$product{'big_pic_url'}="undef";
main:$product{'price'}="undef";
main:$product{'link'}="undef";
}

if ( index($str,"div class=\"clear\"") > -1 ){
if ($product{'name'} ne 'undef'){
    print FILE  "name = ".$product{'name'}."\n";
    print FILE "link = ".$product{'link'}."\n";
    print FILE "min_pic = ". $product{'min_pic_url'}."\n";
    print FILE "big_pic = ". $product{'big_pic_url'}."\n";
    print FILE "price = ". $product{'price'}."\n";
    print FILE "-----\n";
}
$go = 'N';
}
if ($go eq 'Y'){
if ( index($str,"generateLink") > -1) {
($null,$product{'link'}) = split("href=\"",$str);
($product{'link'},$null) = split("\"",$product{'link'});
chomp($product{'link'});
$product{'link'}= "http://www.littmanbros.com".$product{'link'};
}
if ( index($str,"<div class=\"prod-img\">") > -1 ) {
($null, $product{'min_pic_url'}, $null ) = split("src='",$str);
($product{'min_pic_url'}, $null ) = split("'",$product{'min_pic_url'});
$product{'min_pic_url'}="http://www.littmanbros.com/mm5/".$product{'min_pic_url'};
$product{'big_pic_url'}=$product{'min_pic_url'};
$product{'big_pic_url'}=~s/-thumb//;
}
if ( index($str,"<span class=\"prod-price\">") > -1 ) {
    my $hs = HTML::Strip->new();
    my $clean_text = $hs->parse( $str );
    $hs->eof;
    chomp($clean_text);
    $clean_text=~s/Only: //;
    $clean_text=~s/\$//;
    main:$product{'price'} = $clean_text;
}
if ( index($str,"<span class=\"prod-name\">") > -1 ) {
    my $hs = HTML::Strip->new();
    my $clean_text = $hs->parse( $str );
    $hs->eof;
    chomp($clean_text);
main:$product{'name'} = $clean_text;
}
#<a href="/2496-6-4.html" class="generateLink">
#<div class="prod-img"><img class="prod-box-img" src='graphics/00000001/9329-6-3-thumb.jpg' alt='Elk Lighting 9329/6+3 Lawrenceville Chandelier' onClick='window.location = '/&mvt:product:code;.html'' /></div>
#<span class="prod-name">Elk Lighting 9329/6+3 Lawrenceville Chandelier</span><br /><br />
#<span class="prod-price">Only: $358.20</span><br />
#<br /><br />
#<span class="view-btn">View Details</span> </div>
#</a>


}
}
#print "name = ".$product{'name'}."\n";
#print "link = ".$product{'link'}."\n";
#print "min_pic = ". $product{'min_pic_url'}."\n";
#print "big_pic = ". $product{'big_pic_url'}."\n";
#print "price = ". $product{'price'}."\n";
#print "\n\n";
close FILE;