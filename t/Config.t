#!/usr/bin/env perl
use strict;
use warnings;
use Test::More;
use Test::Exception;

BEGIN { use_ok 'Gang::Config' }

subtest 'initializing Gang::Config' => sub {

    my $missing_qr = qr/missing mandatory parameter/;
    throws_ok { Gang::Config->init() } $missing_qr;
    throws_ok { Gang::Config->init( mode => 'TEST' ) } $missing_qr;
    throws_ok { Gang::Config->init( mode => 'TEST', grn_host => 'localhost' ) }
    $missing_qr;
    
    my $not_initialized_qr = qr/you must implement init function at first/;
    throws_ok { Gang::Config->grn_host } $not_initialized_qr;
    throws_ok { Gang::Config->grn_port } $not_initialized_qr;
 
    lives_ok {
        Gang::Config->init(
            mode     => 'TEST',
            grn_host => 'localhost',
            grn_port => '11211',
        );
    };

    my $initialized_qr = qr/initialized already/;
    throws_ok {
        Gang::Config->init(
            mode     => 'DEV',
            grn_host => 'otherhost',
            grn_port => 'XXXXX'
        );
    }
    $initialized_qr;
};

subtest 'getting config values' => sub {

    is( Gang::Config->grn_host, 'localhost' );
    is( Gang::Config->grn_port, 11211 );

};

done_testing;

