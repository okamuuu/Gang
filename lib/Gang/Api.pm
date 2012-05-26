package Gang::Api;
use strict;
use warnings;
use Gang::Api::Log;
use Gang::Model::Article;
use Gang::Client;
use Data::Dumper;

my $LOG_PATH = './log/api.log';

sub start_log {
    my ( $self, $first_msg ) = @_;
    return Gang::Api::Log->new( log_path => $LOG_PATH )
      ->set_debug_msgs($first_msg);
}

sub list_article {
    my ( $class, %args ) = @_;
    my $log = $class->start_log('start list api.');

    my $query = $args{query};

    my $page = $args{page} || 1;
    $page = $page =~ m/^\d+$/ ? $page : 1;

    my $cond;
    if ( $cond->{query} ) {
        $cond->{match_columns} = join ',', Gang::Model::Article->match_columns;
    }

    my $result =
      Gang::Groonga::Client->new->list( 'Article', $cond,
        { page => $page, rows => 10 } );

    return (undef, $result);
}

sub show_article {
    my ( $class, %args ) = @_;

    my $row = Gang::Groonga::Client->new->lookup( 'Article', $args{key} );
    my $model = Gang::Model::Article->new( %{$row} );

    return (undef, $model);
}

1;

