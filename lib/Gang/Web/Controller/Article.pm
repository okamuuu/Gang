package Gang::Web::Controller::Article;
use strict;
use warnings;
use Gang::Groonga::Client;
use Gang::Model::Article;

my $TABLE = 'Article';

sub auto {
    my ( $c ) = @_;
    $c->stash->{title} = $TABLE;
    $c->stash->{table} = $TABLE;
}

sub get_index {
    my ( $c ) = @_;
    $c->req->redirect('/article/list');
}

sub get_list {
    my ( $c ) = @_;

    ### XXX: 上手に書きたい
    my $page = $c->req->param('page') || 1;
    $page = $page =~ m/^\d+$/ ? $page : 1;
    
    my $result =
      Gang::Groonga::Client->new->list( $TABLE, {}, 
        { page => $page, rows => 10 } );

    $c->stash->{title} .= ' list';
    $c->stash->{columns} = ["Gang::Model::$TABLE"->list_columns];
    $c->stash->{rows}   = $result->{rows};
    $c->stash->{pager}  = $result->{pager};
    $c->stash->{template} = 'admin/article/list.tx';
}

sub get_show {
    my ( $c ) = @_;

    $c->stash->{title} .= ' Show';
    $c->stash->{template} = 'article/show.tx';
}

sub post_create {
    my ( $c ) = @_;

    my $body = '[[0,1294292470.41307,0.000532663],[[[2],[["_key","ShortText"],["name","ShortText"]],["tasukuchan","グニャラくん"],["OffGao","OffGao"]]]]';    

    $c->res->body($body);
}

sub post_update {
    my ( $c ) = @_;

    my $body = '[[0,1294292470.41307,0.000532663],[[[2],[["_key","ShortText"],["name","ShortText"]],["tasukuchan","グニャラくん"],["OffGao","OffGao"]]]]';    

    $c->res->body($body);
}

sub post_delete {
    my ( $c ) = @_;

    my $body = '[[0,1294292470.41307,0.000532663],[[[2],[["_key","ShortText"],["name","ShortText"]],["tasukuchan","グニャラくん"],["OffGao","OffGao"]]]]';    

    $c->res->body($body);
}

sub end {
    my ( $c ) = @_;
}

1;

