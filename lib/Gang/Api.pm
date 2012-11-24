package Gang::Api;
use strict;
use warnings;
use parent 'Gang::Api::Base';
use Gang::Model::Article;
use Gang::Client;

use Data::Dumper;

sub list_article {
    my ( $self, %args ) = @_;
   
    $self->set_debug_msgs('start list article.');
    
    my $query = $args{query};

    my $page = $args{page} || 1;
    $page = $page =~ m/^\d+$/ ? $page : 1;

    my $cond;
    if ( $cond->{query} ) {
        $cond->{match_columns} = join ',', Gang::Model::Article->match_columns;
    }
 
    ### 都度 new しているのであとで考える   
    my $result = Gang::Client->new->list( 'Article', $cond,
        { page => $page, rows => 10 } );
    
    $self->set_debug_msgs('end list article.');

    return $result;
}

sub show_article {
    my ( $self, %args ) = @_;
    
    $self->set_debug_msgs('start list article.');

    my $row = Gang::Client->new->lookup( 'Article', $args{key} );
    my $model = Gang::Model::Article->new( %{$row} );
    
    $self->set_debug_msgs('end show article:', $args{key});

    return $model;
}

1;

