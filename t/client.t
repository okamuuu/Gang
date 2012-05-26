#!/usr/bin/env perl
use strict;
use warnings;
use t::TestUtils;
use Test::More;
use Test::Exception;
use Data::Dumper;

BEGIN { use_ok 'Gang::Client' }
   
my ($grn, $client); 

subtest 'prepare' => sub {
    $grn = t::TestUtils->create_test_grn_with_20articles;
    $client =
      Gang::Client->new( host => 'localhost', port => $grn->port );
    isa_ok( $client, 'Gang::Client' );
};

subtest 'is supported cmd version' => sub {
    ok $client->is_supported_cmd_version;
};

subtest 'request groonga server status' => sub {
    my $data = $client->get_status;
    ok ( $data->[1]->{"version"} ge "1.2.4" ), 'version check.';
};

subtest 'lookup article' => sub {
    my $data = $client->lookup('Article', 20110401000000);
    is $data->{_id}, 1;
};

subtest 'list article' => sub {
    
    my $data = $client->list('Article');

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
   
    warn Dumper $info->[1];  

    is_deeply $info->[1]->[0]->[1],
      [
        [ '_id',        'UInt32' ],
        [ '_key',       'ShortText' ],
        [ 'display_fg', 'Bool' ],
        [ 'name',       'ShortText' ]
      ];
};

subtest 'load ' => sub {

    my $info = $client->load(
        'Keyword',
        {
            '_key'       => 'hoge',
            'name'       => 'fuga',
            'display_fg' => '1',
        }
    );

    is $info->[0]->[0], 0;
};

subtest 'update' => sub {

    my $info = $client->update(
        'Keyword',
        {
            '_key'       => 'hoge',
            'name'       => 'fuga',
            'display_fg' => '0',
        }
    );

    is $info->[0]->[0], 0;

    my $info2 = $client->update(
        'Keyword',
        {
            '_key'       => 'hoge',
            'name'       => 'fuga2',
            'display_fg' => '0',
        }
    );

    is $info2->[0]->[0], 0;
};

subtest 'create new row when updating not exists row.' => sub {

    my $info = $client->update(
        'Keyword',
        {
            '_key'       => 'hogeeeeeeeeeee',
            'name'       => 'fuga',
            'display_fg' => '0',
        }
    );

    is $info->[1], 1;
};

subtest 'create' => sub {

    $client->create( 'Article', { _key => 'hogehogehoge', title => 'hoge' } );
    
    my $data = $client->lookup( 'Article', 'hogehogehoge' );

    is_deeply $data,
      {
        'published_at' => '0',
        '_id'          => 21,
        '_key'         => 'hogehogehoge',
        'display_fg'   => bless( do { \( my $o = 0 ) }, 'JSON::XS::Boolean' ),
        'content'      => '',
        'keywords'     => [],
        'created_at'   => '0',
        'updated_at'   => '0',
        'title'        => 'hoge'
      };
};

subtest 'thorws_ok when creating exists row.' => sub {

    throws_ok(
        sub { $client->create(
            'Article', { _key => 'hogehogehoge', title => 'hoge' }
        ) },
        qr/\.\.\./,
    );
};

done_testing;

