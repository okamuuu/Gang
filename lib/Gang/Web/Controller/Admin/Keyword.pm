package Gang::Web::Controller::Admin::Keyword;
use strict;
use warnings;
use Gang::Model::Keyword;

sub auto {
    my ( $class, $c ) = @_;
    $c->stash->{title} = 'Keyword';
}

sub get_index {
    my ( $class, $c ) = @_;

    $c->res->redirect( $c->req->request_uri . "list" );
}

sub get_create {
    my ( $class, $c ) = @_;

    $c->stash->{template} = 'admin/keyword/create.tx';
}


sub get_list {
    my ( $class, $c ) = @_;

    $c->stash->{title} .= ' List';
    $c->stash->{name} = 'hoge';
    $c->stash->{template} = 'admin/keyword/list.tx';
}

sub get_create {
    my ( $class, $c ) = @_;

    $c->stash->{title} .= ' Create';
    $c->stash->{table} = 'Keyword';
    $c->stash->{columns} = Gang::Model::Keyword->columns;
    $c->stash->{type_of} = Gang::Model::Keyword->type_of;
    $c->stash->{template} = 'admin/keyword/create.tx';
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

