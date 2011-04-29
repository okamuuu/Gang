package main;
use strict;
use warnings;
use Test::Most;
use Plack::Test;
use Router::Simple;
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

done_testing();

