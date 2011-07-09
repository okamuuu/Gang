#!/usr/bin/env perl
use strict;
use warnings;
use t::TestUtils;
use Test::More;
use Test::Exception;
use Path::Class::File;
use File::Temp ();
use Data::Dumper;

BEGIN { 
    use_ok('Gang::Api::Admin'); 
}

my ($grn_server, $api); 

subtest 'prepare' => sub {
    $grn_server = t::TestUtils->create_test_grn_with_20articles;
    isa_ok($grn_server, 'Test::TCP');

    $Gang::Unit::GRN_SERVER = $grn_server;

    $api = Gang::Api::Admin->new();
};

subtest 'list Keyword' => sub {

    my $result = Gang::Api::Admin->list_keyword;
    warn Dumper $result;

    isa_ok( $result->{pager}, 'Data::Page' );
    is( @{ $result->{rows} }, 2 );
};

done_testing();
