package Gang::Api;
use strict;
use warnings;
use Carp ();
use parent 'Gang::Api::Base';
use Gang::Client;
use Gang::Model::Article;
use Gang::Model::Keyword;

my $LOG_PATH = './log/api.log';

sub list_articles {
    my ( $self, %args ) = @_;
   
    $self->set_debug_msgs('start list article.');

    my $page = $args{page} || 1;
    $page = $page =~ m/^\d+$/ ? $page : 1;
    
    my $rows = $args{rows} || 10;

    my $cond;
    if ( $args{query} ) {
        $cond->{query} = $args{query};
        $cond->{match_columns} = join ',', Gang::Model::Article->match_columns;
    }
    
    Gang::Client->new->list( 'Article', $cond,
        { page => $page, rows => $rows } );
}

sub show_article {
    my ( $self, %args ) = @_;
    
    $self->set_debug_msgs('start show article.');

    my $row = Gang::Client->new->lookup( 'Article', $args{key} );
    
    Gang::Model::Article->new( %{$row} );
}

sub list_keywords {
    my ( $self, %args ) = @_;
    
    $self->set_debug_msgs('start list keywords.');

    my $query = $args{query};

    my $page = $args{page} || 1;
    $page = $page =~ m/^\d+$/ ? $page : 1;

    my $rows = $args{rows} || 10;

    my $cond;
    if ( $cond->{query} ) {
        $cond->{match_columns} = join ',', Gang::Model::Keyword->match_columns;
    }
    
    Gang::Client->new->list( 'Keyword', $cond,
        { page => $page, rows => $rows } );
}

sub create_article {
    my ( $self, %args ) = @_;
    
    $self->set_debug_msgs('start create article.');
 
    my $model = Gang::Model::Article->new(%args);

    if ( !$model->is_valid ) {
        Carp::croak('invalid Article data.');
    }
    
    Gang::Client->new->create('Article', \%args);
}

1;

