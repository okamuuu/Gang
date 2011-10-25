package Gang::Web::Controller::Admin::Keyword;
use strict;
use warnings;
use Gang::Model::Keyword;
use Gang::Groonga::Client;

sub auto {
    my ( $c ) = @_;
    $c->stash->{title} = 'Keyword';
    $c->stash->{table} = 'keyword';
}

sub get_index {
    my ( $c ) = @_;

    $c->res->redirect( $c->req->request_uri . "list" );
}

sub get_list {
    my ( $c ) = @_;

    ### XXX: 上手に書きたい
    my $page = $c->req->param('page');
    $page = $page =~ m/^\d+$/ ? $page : 1;
    
    my $result =
      Gang::Groonga::Client->new->list( 'Keyword', {},
        { page => $page, rows => 10 } );

    $c->stash->{title} .= ' List';
    $c->stash->{columns} = [Gang::Model::Keyword->columns];
    $c->stash->{rows}   = $result->{rows};
    $c->stash->{pager}  = $result->{pager};
    $c->stash->{template} = 'admin/keyword/list.tx';
}

sub get_show {
    my ( $c, $key ) = @_;

    my $row = Gang::Groonga::Client->new->lookup( 'Keyword', $key );
    my $model = Gang::Model::Keyword->new( %{$row} );

    $c->stash->{model} = $model;
    $c->stash->{columns} = [ Gang::Model::Keyword->columns ];
    $c->stash->{template} = 'admin/keyword/show.tx';
}

sub get_create {
    my ( $c ) = @_;

    $c->stash->{title} .= ' Create';
    $c->stash->{action} = 'create';
    $c->stash->{columns} = [ grep { $_ ne '_id' } Gang::Model::Keyword->columns ];
    $c->stash->{type_of} = { Gang::Model::Keyword->type_of };
    $c->stash->{template} = 'admin/keyword/create.tx';
}

sub post_create {
    my ( $c ) = @_;

    my %params = %{ $c->req->parameters };

    my $model = Gang::Model::Keyword->new(%params);

    if ( $model->is_valid ) {
        Gang::Groonga::Client->new->create('Keyword', {%params});
    }

    $c->res->redirect( '/admin/keyword/list' );
}

sub get_edit {
    my ( $c, $key ) = @_;

    my $row = Gang::Groonga::Client->new->lookup( 'Keyword', $key );
    my $model = Gang::Model::Keyword->new( %{$row} );

    $c->stash->{title} .= ' Edit';
    $c->stash->{action} = 'edit';
    $c->stash->{model} = $model;
    $c->stash->{columns} = [Gang::Model::Keyword->columns];
    $c->stash->{type_of} = {Gang::Model::Keyword->type_of};
    $c->stash->{template} = 'admin/keyword/edit.tx';
}

sub post_edit {
    my ( $c ) = @_;

    my %params = %{ $c->req->parameters };

    use Data::Dumper;
    warn Dumper {%params};

    my $model = Gang::Model::Keyword->new(%params);

    if ( not $params{display_fg} ) {
        $params{display_fg} = 0;
    }

    if ( $model->is_valid ) {
        Gang::Groonga::Client->new->update('Keyword', {%params});
    }

    $c->res->redirect( '/admin/keyword/list' );
}

sub get_delete {
    my ( $c, $key ) = @_;

    my $row = Gang::Groonga::Client->new->lookup( 'Keyword', $key );
    my $model = Gang::Model::Keyword->new( %{$row} );

    $c->stash->{template} = 'admin/keyword/show.tx';
    $c->stash->{title} .= ' Delete';
    $c->stash->{action} = 'delete';
    $c->stash->{model} = $model;
    $c->stash->{columns} = [ grep { $_ ne '_id' } Gang::Model::Keyword->columns ];
    $c->stash->{template} = 'admin/keyword/delete.tx';
}

sub post_delete {
    my ( $c, $key ) = @_;

    my $result = Gang::Groonga::Client->new->delete( 'Keyword', $key );

    use Data::Dumper;
    warn Dumper $result;

    $c->res->redirect( '/admin/keyword/list' );
}

sub end {
    my ( $c ) = @_;
}

1;

