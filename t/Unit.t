#!/usr/bin/env perl
use strict;
use warnings;
use Test::More;

BEGIN { use_ok 'Gang::Unit' }

subtest 'grn' => sub {
    isa_ok( Gang::Unit->grn, 'Gang::Groonga::Client');
};

done_testing;

