#!/usr/bin/env perl
use strict;
use warnings;
use t::TestUtils;
use Test::More;

BEGIN { use_ok 'Gang::Groonga::Client' }
   
my ($grn, $client); 

subtest 'prepare' => sub {
    $grn = t::TestUtils->create_test_grn_with_10articles;
    $client =
      Gang::Groonga::Client->new( host => 'localhost', port => $grn->port );
    isa_ok( $client, 'Gang::Groonga::Client' );
};

subtest 'request groonga server status' => sub {
    my $data = $client->get_status;
    ok ( $data->[1]->{"version"} ge "1.0.6" ), 'version check.';
};

subtest 'lookup article by _key' => sub {
    my $data = $client->lookup_by_key('Article', 20110401000000);
#    my $data = $client->lookup_
    use Data::Dumper;
    warn Dumper $data->[1]->[0]->[1];
    warn Dumper $data->[1]->[0]->[2];
    ok(1);
};

done_testing;

