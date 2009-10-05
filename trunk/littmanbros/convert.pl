#!/usr/bin/perl -w

use XML::Writer;
use IO::File;

my $output = new IO::File(">output.xml");
#main:%product = ();
main:$writer = new XML::Writer(OUTPUT => $output,DATA_MODE=>1,DATA_INDENT=>4);
main:$writer->xmlDecl("UTF-8");


#Метод Пишет тэг с данными и закрывает его
sub tag{
    my ($element,$data,@params)=@_;
    main:$writer->cdataElement(@_);
}
#Метод Пишет открытый тэг с параметрами
sub opentag{
    my ($element,@params)=@_;
    main:$writer->startTag($element,@params);
}

#Метод Пишет Закрытый Тэг
sub closetag{
    my ($element)=@_;
    main:$writer->endTag($element);
}

sub addElement{
my (%product)=@_;


my $cropname=$product{'name'};
@hash=split(" ",$cropname);
my $cur=0;
while( 1 == 1 ){
$cropname = $hash[$cur];
my $cropnametmp=$cropname;
$cropnametmp=~s/([a-zA-z]+)//g;
#print $cropnametmp."<";
if ( length($cropnametmp) <= 3 ){
$cur++;
if (!defined $hash[$cur]) {last;}
$cropname = $hash[$cur];
$cropnametmp=$cropname;
}
else {
    last;
}
}
#Считаем что какое то гавно в данных и выкидываем их
if (length($cropname) <=3) {return 0;}
#print $cropname."\n";

        opentag("product","external_name"=>$product{'name'});
        tag("name",$cropname);
        tag("price",$product{'price'});
        tag("url",$product{'link'});
        #tag("description","SHOP_TITLE");
        #tag("brand","SHOP_TITLE");
        #tag("mid","SHOP_TITLE");
        #tag("instock","TRUE");
        
        opentag("images");
    	    tag("image",$product{'min_pic'});
    	    tag("image",$product{'big_pic'});
        closetag("images");
        
        #tag("category","SHOP_TITLE");
	#tag("subcategory","{PRODUCT_SUBCATEGORY}");
	#
	#opentag("styles");
    	#    tag("style","SHOP_TITLE");
    	#    tag("style","SHOP_TITLE");
        #closetag("styles");
        #
        #opentag("colors");
    	#    tag("color","SHOP_TITLE");
    	#    tag("color","SHOP_TITLE");
        #closetag("colors");
        #
	#tag("collection","{PRODUCT_COLLECTION}");
	#tag("type","{PRODUCT_TYPE}");
	#tag("bulbs","{PRODUCT_BULBS}");
	#tag("usage","{PRODUCT_USAGE}");
	#
        #opentag("rfinishes");
        #    tag("product","{MANUFACTURER_PRODUCT_ID}","mid"=>"1");
	#closetag("rfinishes");
	#
	#opentag("ritems");
	#    tag("product","{MANUFACTURER_PRODUCT_NAME}","mid"=>"1");
	#closetag("ritems");
	
        ##opentag("reviews");
	#	tag("review","TEXT","title"=>"{REVIEW_TITLE}","rating"=>"{REVIEW_RATING}","name"=>"{REVIEW_AUTHOR_NAME}","location"=>"{REVIEW_AUTHOR_LOCATION}","date"=>"{REVIEW_DATE}");
	#	tag("review","TEXT","title"=>"{REVIEW_TITLE}","rating"=>"{REVIEW_RATING}","name"=>"{REVIEW_AUTHOR_NAME}","location"=>"{REVIEW_AUTHOR_LOCATION}","date"=>"{REVIEW_DATE}");
	#closetag("reviews");
	#
	#opentag("glow_params");
	#	tag("wattage","TEXT");
	#	tag("type","TEXT");
	#	tag("size","TEXT");
	#closetag("glow_params");
	#
	#opentag("dimensions");
	#	tag("height","TEXT");
	#	tag("width","TEXT");
	#	tag("length","TEXT");
	#closetag("dimensions");
	closetag("product");
}


opentag("catalog");
    opentag("shop");
        tag("title","littmanbros");
    closetag("shop");
    opentag("products");

my $writedata="N";
my $alldata="";
my $key;
my $val;
my $null;
my %product = ();
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
            ($key,$val,$null) = split("=",$str);
            chomp($key);
            chomp($val);
            $key=~s/ //g;
            $val=~s/^ //g;
            $val=~s/\"//g;
            $product{$key}=$val;
#             $$key=$val;
#            print $name." -- ".$key." -- ".$product{$key}."\n";

            if ( index($key,'price') > -1){
              addElement(%product);
            }
            #print $key." = ".$val."\n";

     }
    }
}
    closetag("products");
closetag("catalog");
main:$writer->end();
$output->close();
