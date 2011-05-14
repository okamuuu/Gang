#!/usr/bin/env perl
use strict;
use warnings;
use Test::More;
use LWP::UserAgent;

BEGIN { use_ok 't::TestUtils' }

subtest 'get test tcp as groonga server' => sub {

    my $grn = t::TestUtils->create_test_grn_with_20articles;

    isa_ok($grn, 'Test::TCP');

    my $ua = LWP::UserAgent->new();
    
    my $res = $ua->get("http://127.0.0.1:@{[ $grn->port ]}/d/status");
    is $res->code, 200;
    diag $res->content;

    $res = $ua->get("http://127.0.0.1:@{[ $grn->port ]}/d/column_list?table=Article");
    is $res->code, 200;
    diag $res->content;
 
    $res = $ua->get("http://127.0.0.1:@{[ $grn->port ]}/d/select?table=Article");
    is $res->code, 200;
    diag $res->content;
   
};



done_testing;
