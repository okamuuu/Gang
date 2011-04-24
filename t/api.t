#!/usr/bin/env perl
use strict;
use warnings;
use Test::More;
use JSON;

BEGIN { use_ok 'Gang::REST' }

subtest 'archive/list' => sub {

    my $rest = Gang::REST->new( v => 1 );
    my $json = $rest->list_archives( {}, {} );
    my $data = JSON::decode_json($json);

    ### similar to Groonga
    my $status_code = $data->[0]->[0];
    my $elapsed     = $data->[0]->[2];
    my $result      = $data->[1];

    is $status_code, 0;
};

subtest 'archive/show' => sub {
    my $rest = Gang::REST->new( v => 1 );
    my $json = $rest->show_archive(1);
    my $data = JSON::decode_json($json);

    ### similar to Groonga
    my $status_code = $data->[0]->[0];
    my $elapsed     = $data->[0]->[2];
    my $result      = $data->[1];

    is $status_code, 0;
};

subtest 'archive/create' => sub {
    my $rest = Gang::REST->new( v => 1 );
    my $json = $rest->create_archive(
        title        => 'title',
        description  => 'description',
        published_at => 'Time::Piece?',
    );
    my $data = JSON::decode_json($json);

    ### similar to Groonga
    my $status_code = $data->[0]->[0];
    my $elapsed     = $data->[0]->[2];
    my $result      = $data->[1];

    is $status_code, 0;
};

subtest 'archive/update' => sub {
    my $rest = Gang::REST->new( v => 1 );
    my $json = $rest->update_archive(
        title        => 'title',
        description  => 'description',
        published_at => 'Time::Piece?',
    );

    my $data = JSON::decode_json($json);

    ### similar to Groonga
    my $status_code = $data->[0]->[0];
    my $elapsed     = $data->[0]->[2];
    my $result      = $data->[1];

    is $status_code, 0;
};

subtest 'archive/delete' => sub {
    my $rest = Gang::REST->new( v => 1 );
    my $json = $rest->delete_archive(1);
    my $data = JSON::decode_json($json);

    ### similar to Groonga
    my $status_code = $data->[0]->[0];
    my $elapsed     = $data->[0]->[2];
    my $result      = $data->[1];

    is $status_code, 0;
};

done_testing;
