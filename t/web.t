package main;
use strict;
use warnings;
use Test::Most;
use Plack::Test;
use JSON;

use HTTP::Request::Common qw/GET POST/;

use_ok "Gang::Web::Handler";

my $app = Gang::Web::Handler->app;

test_psgi $app, sub {
    my $cb  = shift;
    my $res = $cb->( GET "/" );
    is $res->content, "get_index";
};

test_psgi $app, sub {
    my $cb  = shift;
    my $res = $cb->( POST "/" );
    is $res->content, "post_index";
};

test_psgi $app, sub {
    my $cb  = shift;
    my $res = $cb->( GET "/archive/list" );

    my $data = JSON::decode_json($res->content);
    my $status_code = $data->[0]->[0];
    is $status_code, 0;
};

test_psgi $app, sub {
    my $cb  = shift;
    my $res = $cb->( GET "/archive/show" );

    my $data = JSON::decode_json($res->content);
    my $status_code = $data->[0]->[0];
    is $status_code, 0;
};

test_psgi $app, sub {
    my $cb  = shift;
    my $res = $cb->( POST "/archive/create" );

    my $data = JSON::decode_json($res->content);
    my $status_code = $data->[0]->[0];
    is $status_code, 0;
};

test_psgi $app, sub {
    my $cb  = shift;
    my $res = $cb->( POST "/archive/update" );

    my $data = JSON::decode_json($res->content);
    my $status_code = $data->[0]->[0];
    is $status_code, 0;
};

test_psgi $app, sub {
    my $cb  = shift;
    my $res = $cb->( POST "/archive/delete" );

    my $data = JSON::decode_json($res->content);
    my $status_code = $data->[0]->[0];
    is $status_code, 0;
};






done_testing();

