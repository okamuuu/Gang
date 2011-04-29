#!/usr/bin/env perl
use strict;
use warnings;
use Test::More;

BEGIN { use_ok 't::TestUtils' }

subtest 'get test tcp as groonga server' => sub {

    my $grn = t::TestUtils->create_test_grn_with_10articles;

    isa_ok($grn, 'Test::TCP');
};

done_testing;
