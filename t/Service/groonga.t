#!/usr/bin/env perl
use strict;
use warnings;
use Test::Most;
use File::Temp ();
use Test::TCP;
use Gang::Groonga::Client;

use_ok('Gang::Service::Groonga');

my $service;

my $db =
      File::Spec->catfile( File::Temp::tempdir( CLEANUP => 1 ), 'test.db' );
      
my $empty_port = Test::TCP::empty_port();    # this is useful method:)
my $client = Gang::Groonga::Client->new( port => $empty_port );

subtest 'create tcp instance' => sub {
    $service = Gang::Service::Groonga->create(port=>$empty_port, db=>$db);
    isa_ok( $service, 'Test::TCP' );
};

subtest 'groonga server is alive' => sub {
    lives_ok { $client->get_status } 'ok';
};

subtest 'stop groonga server' => sub {
    $service->stop();
    throws_ok { $client->get_status } qr//,  'not ok';
};

done_testing();



