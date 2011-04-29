package Gang::Web::Controller::Archive;
use strict;
use warnings;

sub auto {}

sub get_list {
    my ( $class, $c ) = @_;

    my $body = '[[0,1294292470.41307,0.000532663],[[[2],[["_key","ShortText"],["name","ShortText"]],["tasukuchan","グニャラくん"],["OffGao","OffGao"]]]]';    

    $c->res->body($body);
}

sub get_show {
    my ( $class, $c ) = @_;

    my $body = '[[0,1294292470.41307,0.000532663],[[[2],[["_key","ShortText"],["name","ShortText"]],["tasukuchan","グニャラくん"],["OffGao","OffGao"]]]]';    

    $c->res->body($body);
}

sub post_create {
    my ( $class, $c ) = @_;

    my $body = '[[0,1294292470.41307,0.000532663],[[[2],[["_key","ShortText"],["name","ShortText"]],["tasukuchan","グニャラくん"],["OffGao","OffGao"]]]]';    

    $c->res->body($body);
}

sub post_update {
    my ( $class, $c ) = @_;

    my $body = '[[0,1294292470.41307,0.000532663],[[[2],[["_key","ShortText"],["name","ShortText"]],["tasukuchan","グニャラくん"],["OffGao","OffGao"]]]]';    

    $c->res->body($body);
}

sub post_delete {
    my ( $class, $c ) = @_;

    my $body = '[[0,1294292470.41307,0.000532663],[[[2],[["_key","ShortText"],["name","ShortText"]],["tasukuchan","グニャラくん"],["OffGao","OffGao"]]]]';    

    $c->res->body($body);
}

sub end {
    my ( $class, $c ) = @_;
}

1;

