#!/usr/bin/env perl
use strict;
use warnings;
use Test::More;
use Test::Pretty;
use Test::Exception;
use Path::Class::File;
use File::Temp ();

use Data::Dumper;

BEGIN { 
    use_ok('Gang::Api::Base'); 
}

subtest 'api common interface' => sub {

    my $api = Gang::Api::Base->new();
    $api->set_debug_msgs('test1', 'test2');

    ok($api);
};

#subtest 'show article' => sub {
#    ok(1);
#};
#
#subtest 'list keywords' => sub {
#    ok(1);
#};

done_testing;

