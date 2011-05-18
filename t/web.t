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
    my $res = $cb->( GET "/article/list" );

    ok $res->status_line, $res->status_line;
};

test_psgi $app, sub {
    my $cb  = shift;
    my $res = $cb->( GET "/article/show" );

    ok $res->status_line, $res->status_line;
};

test_psgi $app, sub {
    my $cb  = shift;
    my $res = $cb->( POST "/article/create" );

    my $data = JSON::decode_json($res->content);
    my $status_code = $data->[0]->[0];
    is $status_code, 0;
};

test_psgi $app, sub {
    my $cb  = shift;
    my $res = $cb->( POST "/article/update" );

    my $data = JSON::decode_json($res->content);
    my $status_code = $data->[0]->[0];
    is $status_code, 0;
};

test_psgi $app, sub {
    my $cb  = shift;
    my $res = $cb->( POST "/article/delete" );

    my $data = JSON::decode_json($res->content);
    my $status_code = $data->[0]->[0];
    is $status_code, 0;
};

test_psgi $app, sub {
    my $cb  = shift;
    my $res = $cb->( GET "/admin/keyword/list" );

    warn $res->status_line;

    ok ($res->status_line !~ m/404/ ), $res->status_line;
};


done_testing();

