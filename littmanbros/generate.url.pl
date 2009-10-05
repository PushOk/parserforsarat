#!/usr/bin/perl

use XML::DOM;
use HTML::Parser;
use Data::Dumper;

sub print_r {
    
    my $level="";
    my @level_index=();
    my @print_r_Recursion=();
    print_rec (@_);
    undef @level_index;
    undef @print_r_Recursion;
    undef $level;
    
    sub print_rec {

        if ( ! defined $level ) { $level = 0 };
        if ( ! defined @level_index ) { $level_index[$level] = 0 };

        for ( @_ ) {

            my $element = $_;
            my $index   = $level_index[$level];
            
            if (ref($element) eq 'ARRAY' || ref($element) eq 'HASH'){
                my $loop=0;
                for (@print_r_Recursion){
                    if (($element."") eq ($_."")){
                        $loop=1;
                        last;
                    }
                }
                if ($loop==1){
                    print "\t" x $level . "[$index] => ". ref($elem
+ent) ." *recursion*\n";
                    next;
                }
                push @print_r_Recursion,$element;
            }
            
            print "\t" x $level . "[$index] =>: ";

            if ( ref($element) eq 'ARRAY' ) {
                my $array = $_;

                $level_index[++$level] = 0;

                print "(Array)\n";

                for ( @$array ) {
                    print_rec( $_ ); 
                }
                --$level if ( $level < 0 );
            } elsif ( ref($element) eq 'HASH' ) {
                my $hash = $_;

                print "(Hash)\n";

                ++$level;

                for ( keys %$hash ) {
                    $level_index[$level] = $_;
                    print_rec( $$hash{$_} );
                }
            } else {
                print "$element\n";
            }

            $level_index[$level]++;
        }
    }
}

my $p = HTML::Parser->new( api_version => 3,
start_h => [\&start, "tagname, attr"],
end_h => [\&end, "tagname"],
marked_sections => 1,
);
$p->parse_file("index.html");

sub start {

my ($tagname, $attr)=@_;
#print Dumper(@_);
if ( $tagname eq "ul" or  $tagname eq "li"){
    print_r @_;
    }
#exit 0;
#print $tagname;

}
sub end {
#print "END: @_\n";
}
