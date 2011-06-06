#!/usr/bin/env perl
use strict;
use warnings;
use t::TestUtils;
use Test::More;

BEGIN { use_ok 'Gang::Groonga::Client' }
   
my ($grn, $client); 

subtest 'prepare' => sub {
    $grn = t::TestUtils->create_test_grn_with_20articles;
    $client =
      Gang::Groonga::Client->new( host => 'localhost', port => $grn->port );
    isa_ok( $client, 'Gang::Groonga::Client' );
};

subtest 'request groonga server status' => sub {
    my $data = $client->get_status;
    ok ( $data->[1]->{"version"} ge "1.0.6" ), 'version check.';
};

subtest 'lookup article' => sub {
    my $data = $client->lookup('Article', 20110401000000);
    is $data->{_id}, 1;
};

subtest 'list article' => sub {
    
    my $data = $client->list('Article');

    use Data::Dumper;
    warn Dumper $data->{pager}->total_entries;

    isa_ok( $data->{pager}, 'Data::Page' );
    is( $data->{pager}->total_entries, 20 );
    is(scalar @{ $data->{rows} } , 10 );

};

subtest 'match search in title' => sub {
    
    my $data = $client->list('Article', { match_columns=>'title', query => 'はじまります' });

    isa_ok( $data->{pager}, 'Data::Page' );
    is( $data->{pager}->total_entries, 2 );
    is(scalar @{ $data->{rows} } , 2 );

};

subtest 'match search in keywords' => sub {
    
    my $data = $client->list('Article', { match_columns=>'keywords', query => 'Basic' });

    isa_ok( $data->{pager}, 'Data::Page' );
    is( $data->{pager}->total_entries, 10 );
    is(scalar @{ $data->{rows} } , 10 );

};

subtest 'match search in content' => sub {
    
    my $data = $client->list('Article', { match_columns=>'content', query => 'ぐる' });

    isa_ok( $data->{pager}, 'Data::Page' );
    is( $data->{pager}->total_entries, 11 );
    is(scalar @{ $data->{rows} } , 10 );

};


subtest 'match search in title and content' => sub {
    
    my $data = $client->list('Article', { match_columns=> 'title || content', query => 'Groonga1' });

    isa_ok( $data->{pager}, 'Data::Page' );
    is( $data->{pager}->total_entries, 2 );
    is(scalar @{ $data->{rows} } , 2 );

};

subtest 'get keyword schema info' => sub {

    my $info = $client->info('Keyword'); 

    ok(1);
};


done_testing;

