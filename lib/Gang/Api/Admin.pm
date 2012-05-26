package Gang::Api::Admin;
use strict;
use warnings;
use Gang::Api::Log;
use Gang::Model::Article;
use Gang::Client;

my $LOG_PATH = './log/admin_api.log';

sub _start_log {
    my ( $self, $first_msg ) = @_;
    return Gang::Api::Log->new( log_path => $LOG_PATH )
      ->set_debug_msgs($first_msg);
}

sub list_articles {
    my ( $class, %args ) = @_;
    my $log = $class->_start_log('start list article.');

    my $query = $args{query};

    my $page = $args{page} || 1;
    $page = $page =~ m/^\d+$/ ? $page : 1;
    
    my $rows = $args{rows} || 10;

    my $cond;
    if ( $cond->{query} ) {
        $cond->{match_columns} = join ',', Gang::Model::Article->match_columns;
    }
    
    my $result =
      Gang::Client->new->list( 'Article', $cond,
        { page => $page, rows => $rows } );

    return (undef, $result);
}

sub show_article {
    my ( $class, %args ) = @_;
    my $log = $class->_start_log('start show article.');

    my $row = Gang::Client->new->lookup( 'Article', $args{key} );
    my $model = Gang::Model::Article->new( %{$row} );

    return (undef, $model);
}

sub list_keywords {
    my ( $class, %args ) = @_;
    my $log = $class->_start_log('start list keywords.');

    my $query = $args{query};

    my $page = $args{page} || 1;
    $page = $page =~ m/^\d+$/ ? $page : 1;

    my $rows = $args{rows} || 10;

    my $cond;
    if ( $cond->{query} ) {
        $cond->{match_columns} = join ',', Gang::Model::Keyword->match_columns;
    }
    
    my $result =
      Gang::Client->new->list( 'Keyword', $cond,
        { page => $page, rows => $rows } );

    return (undef, $result);
}

sub create_article {
    my ( $class, %args ) = @_;
 
    my $model = Gang::Model::Article->new(%args);

    if ( $model->is_valid ) {
        Gang::Groonga::Client->new->create('Article', \%args);
    }
    else { 
        die('invalid Article data.');
    }
   
    return; 
}

1;

