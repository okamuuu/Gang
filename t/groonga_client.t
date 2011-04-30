#!/usr/bin/env perl
use strict;
use warnings;
use t::TestUtils;
use Test::More;

BEGIN { use_ok 'Gang::Groonga::Client' }
    
my $grn = t::TestUtils->create_test_grn;

subtest 'request groonga server status' => sub {

    my $client =
      Gang::Groonga::Client->new( host => 'localhost', port => $grn->port );

    isa_ok($client, 'Gang::Groonga::Client' );

    my $data = $client->get_status;

    use Data::Dumper;
    warn Dumper $data;

    ok ( $data->[1]->{"version"} ge "1.0.6" ), 'version check.';
};

done_testing;
