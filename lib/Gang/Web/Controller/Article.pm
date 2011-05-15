package Gang::Web::Controller::Article;
use strict;
use warnings;

sub auto {
    my ( $class, $c ) = @_;
    $c->stash->{title} = 'Article';
}

sub get_list {
    my ( $class, $c ) = @_;

    $c->stash->{title} .= ' List';
    
    $c->stash->{name} = 'hoge';
    $c->stash->{template} = 'article/list.tx';
}

sub get_show {
    my ( $class, $c ) = @_;

    $c->stash->{title} .= ' Show';
    $c->stash->{template} = 'article/show.tx';
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

