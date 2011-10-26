package Gang::Web::Controller::Article;
use strict;
use warnings;
use Gang::Groonga::Client;
use Gang::Model::Article;

my $TABLE = 'Article';

sub auto {
    my ( $c ) = @_;
    ### XXX: urlから取得すればよくね？
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
    my ( $c, $key ) = @_; 

    my $row = Gang::Groonga::Client->new->lookup( $TABLE, $key );
    my $model = "Gang::Model::$TABLE"->new( %{$row} );

    $c->stash->{model} = $model;
    $c->stash->{columns} = [ "Gang::Model::$TABLE"->columns ];
    $c->stash->{title} .= ' show';
    $c->stash->{template} = 'admin/article/show.tx';
}

sub get_create {
    my ( $c ) = @_; 

    $c->stash->{title} .= 'create';
    $c->stash->{action} = 'create';
    $c->stash->{columns} = [ grep { $_ ne '_id' } "Gang::Model::$TABLE"->columns ];
    $c->stash->{type_of} = { "Gang::Model::$TABLE"->type_of };
    $c->stash->{template} = 'admin/article/create.tx';
}

sub post_create {
    my ( $c ) = @_;

    my %params = %{ $c->req->parameters };

    my $model = "Gang::Model::$TABLE"->new(%params);

    if ( $model->is_valid ) { 
        Gang::Groonga::Client->new->create($TABLE, {%params});
    } 

    $c->res->redirect( '/article/list' );
}

sub get_edit {
    my ( $c, $key ) = @_;

    my $row = Gang::Groonga::Client->new->lookup( $TABLE, $key );
    my $model = "Gang::Model::$TABLE"->new( %{$row} );

    $c->stash->{title} .= 'edit';
    $c->stash->{action} = 'edit';
    $c->stash->{model} = $model;
    $c->stash->{columns} = ["Gang::Model::$TABLE"->columns];
    $c->stash->{type_of} = {"Gang::Model::$TABLE"->type_of};
    $c->stash->{template} = 'admin/article/edit.tx';

}

sub post_edit {
    my ( $c, $key ) = @_;

    my %params = %{ $c->req->parameters };

    my $model = "Gang::Model::$TABLE"->new(%params);

    if ( not $params{display_fg} ) {
        $params{display_fg} = 0;
    }

    if ( $model->is_valid ) {
        Gang::Groonga::Client->new->update($TABLE, {%params});
    }

    $c->res->redirect( '/article/list' );
}

sub get_delete {
    my ( $c, $key ) = @_;
    my $row = Gang::Groonga::Client->new->lookup( $TABLE, $key );
    my $model = "Gang::Model::$TABLE"->new( %{$row} );

    $c->stash->{title} .= 'delete';
    $c->stash->{action} = 'delete';
    $c->stash->{model} = $model;
    $c->stash->{columns} = [ grep { $_ ne '_id' } "Gang::Model::$TABLE"->columns ];
    $c->stash->{template} = 'admin/article/delete.tx';

}

sub post_delete {
    my ( $c, $key ) = @_;
    my $result = Gang::Groonga::Client->new->delete( $TABLE, $key );
    $c->res->redirect( '/article/list' );
}

sub end {
    my ( $c ) = @_;
}

1;

