#!/usr/bin/env perl
use strict;
use warnings;
use Test::More;
use Test::Exception;
use Path::Class::File;
use File::Temp ();

BEGIN { 
    use_ok('Gang::Api'); 
}

subtest 'construction' => sub {

    Gang::Api->list();

    ok(1);   
};

done_testing;

