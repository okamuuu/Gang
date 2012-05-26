#!/usr/bin/env perl
use strict;
use warnings;
use Test::More;
use Test::Exception;
use Path::Class::File;
use File::Temp ();

use Data::Dumper;

BEGIN { 
    use_ok('Gang::Api::Admin'); 
}

subtest 'list article' => sub {

    my ($err, $result) = Gang::Api::Admin->list_articles(page=>1, rows=>10);

    ok(!$err);
    ok($result);

};

subtest 'show article' => sub {

    my ($err, $result) = Gang::Api::Admin->show_article(key=>'key1');

    ok(!$err);
    ok($result);
};

subtest 'list keywords' => sub {

    my ($err, $result) = Gang::Api::Admin->list_keywords(page=>1, rows=>100);

    ok(!$err);
    ok($result);

};

#subtest 'create article' => sub {
#
#    my ($err, $result) = Gang::Api::Admin->create_article(page=>1, rows=>100);
#
#    ok(!$err);
#    ok($result);
#
#    warn Dumper $result;
#};

done_testing;

