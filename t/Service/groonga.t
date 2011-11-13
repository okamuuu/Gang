#!/usr/bin/env perl
use strict;
use warnings;
use Test::More;
use Test::TCP;
use Gang::Groonga::Client;

use_ok('Gang::Service::Groonga');

my ($client, $service);

my $empty_port = Test::TCP::empty_port(); # this is useful method:)

my $client = Gang::Groonga::Client->new(port=>$empty_port);

subtest 'create tcp instance' => sub {
    $service = Gang::Service::Groonga->start(port=>$empty_port);
};

subtest 'groonga server is alive' => sub {
    lives_ok( $client->get_status );
};

subtest 'stop groonga server' => sub {
    $service->stop();
    throws_ok( $client->get_status );
};

done_testing();



