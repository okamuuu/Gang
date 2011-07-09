#!/usr/bin/env perl
use strict;
use warnings;
use Gang::Config;
use Test::More;
use Test::Exception;

Gang::Config->init(
    mode     => 'TEST',
    grn_port => '11211',
    grn_host => 'localhost'
);

BEGIN { use_ok 'Gang::Unit' }

subtest 'grn' => sub {
    isa_ok( Gang::Unit->grn, 'Gang::Groonga::Client');
};

done_testing;

