#!/usr/bin/env perl
use strict;
use warnings;
use Test::More;
use Test::Exception;
use Path::Class::File;
use File::Temp ();

BEGIN { 
    use_ok('Gang::Api::Public'); 
    use_ok('Gang::Api::Admin'); 
}

subtest 'Public' => sub {

    subtest 'listing article' => sub {
        my $api = Gang::Api::Public->new;
        ok $api->listing_article();
    };

    subtest 'lookup article' => sub {
        my $api = Gang::Api::Public->new;
        ok $api->lookup_article();
    };

    subtest 'listing keyword' => sub {
        my $api = Gang::Api::Public->new;
        ok $api->lookup_keyword();
    };
};

subtest 'Admin' => sub {

    subtest 'create keyword' => sub {
        my $api = Gang::Api::Admin->new;
        ok $api->create_keyword();
    };

    subtest 'update keyword' => sub {
        my $api = Gang::Api::Admin->new;
        ok $api->update_keyword();
    };

    subtest 'delete keyword' => sub {
        my $api = Gang::Api::Admin->new;
        ok $api->delete_keyword();
    };

    subtest 'listing keyword' => sub {
        my $api = Gang::Api::Admin->new;
        ok $api->listing_keyword();
    };

    subtest 'lookup keyword' => sub {
        my $api = Gang::Api::Admin->new;
        ok $api->lookup_keyword();
    };

    subtest 'create article' => sub {
        my $api = Gang::Api::Admin->new;
        ok $api->create_article();
    };

    subtest 'update article' => sub {
        my $api = Gang::Api::Admin->new;
        ok $api->update_article();
    };

    subtest 'delete article' => sub {
        my $api = Gang::Api::Admin->new;
        ok $api->delete_article();
    };

    subtest 'listing article' => sub {
        my $api = Gang::Api::Admin->new;
        ok $api->listing_article();
    };

    subtest 'lookup article' => sub {
        my $api = Gang::Api::Admin->new;
        ok $api->lookup_article();
    };
};

done_testing;

