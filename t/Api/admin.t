#!/usr/bin/env perl
use strict;
use warnings;
use Test::More;
use Test::Exception;
use Path::Class::File;
use File::Temp ();
use Data::Dumper;

BEGIN { 
    use_ok('Gang::Api::Admin'); 
}

subtest 'list Keyword' => sub {

    my $result = Gang::Api::Admin->listing_keyword;
    warn Dumper $result;

    isa_ok( $result->{pager}, 'Data::Page' );
    is( @{ $result->{rows} }, 2 );
};

done_testing();
