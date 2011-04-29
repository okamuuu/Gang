package Gang::Web::Controller::Root;
use strict;
use warnings;

sub auto {}

sub get_index {
    my ( $class, $c ) = @_;

    $c->res->body('get_index');
}

sub post_index {
    my ( $class, $c ) = @_;

    $c->res->body('post_index');
}

sub end {
    my ( $class, $c ) = @_;
}

1;

