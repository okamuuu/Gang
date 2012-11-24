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
    use_ok('Gang::Api'); 
}

subtest 'list article' => sub {

    my $api = Gang::Api->new();
    my $result = $api->list_article();
    
    isa_ok($result->{pager}, 'Data::Page');
    isa_ok($result->{rows}, 'ARRAY');
};

subtest 'show article' => sub {

    my $api = Gang::Api->new();
    my $result = $api->show_article(key=>'key1');
   
    isa_ok($result, 'Gang::Model::Article');
};

#subtest 'list keywords' => sub {
#    ok(1);
#};

done_testing;

