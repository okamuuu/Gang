package Gang::Groonga::Client;
use strict;
use warnings;
use Carp ();
use JSON ();
use Data::Page::Navigation;
use LWP::UserAgent;
use Class::Accessor::Lite 0.05 (
    ro  => [qw/ua port host/]
);

our $PORT = 10041;

sub new {
    my $class = shift;
    my %args = @_ == 1 ? %{ $_[0] } : @_;

    my $ua   = $args{ua}   || LWP::UserAgent->new();
    my $port = $args{port} || $PORT;
    my $host = $args{host} || 'localhost';
    
    return bless {
        ua   => $ua,
        port => $port,
        host => $host,
    }, $class;
}

sub get_status {
    my $self = shift;

    my $uri = $self->_uri("status");
    my $res = $self->_get( $uri );

    Carp::croak("Groonga server has gone...") unless $res->is_success;

    return JSON::decode_json( $res->content );
}

sub list {
    my ($self, $table, $cond, $attr) = @_;

    my $rows = $attr->{rows} || 10;
    my $page = $attr->{page} || 1;

    my $limit = $rows;
    my $offset = $rows * ( $page - 1 );

    my $uri = $self->_uri("select");
    $uri->query_form(
        table          => $table,
        match_columns  => $cond->{match_columns} || undef,
        query          => $cond->{query} || undef,
        output_columns => $cond->{output_columns} || undef,
        sortby         => $cond->{sortby} || undef,
        limit          => $limit,
        offset         => $offset,
        query_cache    => 'no',
    );

    my $data = JSON::decode_json( $self->_get($uri)->content );

    my ($count_ref, $column_infos_ref, @values_list) = @{ $data->[1]->[0] };

    ### countがなんか深いぞ？
    my $count = $count_ref->[0];
    my @column_names = map { $_->[0] } @{ $column_infos_ref };

    ### XXX: 美しくない><
    my @rows;
    for my $values_ref (@values_list) {
        push @rows,
          { map { $column_names[$_] => $values_ref->[$_] }
              ( 0 .. $#column_names ) };
    }

    my $pager = Data::Page->new();
    $pager->total_entries($count);
    $pager->entries_per_page($rows);
    $pager->current_page($page);

    return {
        pager    => $pager,
        rows     => \@rows,
    };
}

sub lookup {
    my ( $self, $table, $key ) = @_;

    my $uri = $self->_uri("select");
    $uri->query_form( table => $table, query => "_key:$key" );

    my $data = JSON::decode_json( $self->_get($uri)->content );

    ### 都度配列展開するので素直にテーブル毎にクラス化?
    my @names  = map { $_->[0] } @{ $data->[1]->[0]->[1] };
    my @values = $data->[1]->[0]->[2] ? @{ $data->[1]->[0]->[2] } : ();

    my %columns = map { $names[$_] => $values[$_] } ( 0 .. $#names );

    return {%columns};
}

sub load {
    my ( $self, $table, $params_ref ) = @_;

    my $uri = $self->_uri("load");
    $uri->query_form(
        table      => $table,
        values     => JSON::encode_json($params_ref),
    );
    
    return JSON::decode_json( $self->_get($uri)->content );
}

sub create {
    my ( $self, $table, $params_ref ) = @_;

    my $uri = $self->_uri("load");
    $uri->query_form(
        table      => $table,
        ifexists   => 0,
        values     => JSON::encode_json($params_ref),
    );
    
    ### insertした件数が0の場合はdie: column _key is not unique   
    my $data = JSON::decode_json( $self->_get($uri)->content );
    
    ### $data->[1] is created row count by this action.  
    Carp::croak("column _key is not unique...") if not $data->[1];
}

sub update { 
    my ( $self, $table, $params_ref ) = @_;

    my $uri = $self->_uri("load");
    $uri->query_form(
        table      => $table,
        values     => JSON::encode_json($params_ref),
    );
   
    return JSON::decode_json( $self->_get($uri)->content );
}

sub delete {
    my ( $self, $table, $key ) = @_;

    my $uri = $self->_uri("delete");
    $uri->query_form(
        table => $table,
        key   => $key,
    );

    return JSON::decode_json( $self->_get($uri)->content );
}

sub info {
    my ( $self, $table ) = @_;

    my $uri = $self->_uri("select");
    $uri->query_form( table => $table );

    my $data = JSON::decode_json( $self->_get($uri)->content );

}

sub _get {
    my ($self, $uri) = @_;

    my $res = $self->ua->get($uri);
    
    if ( not $res->is_success ) {
        Carp::croak(
            "Groonga server return error status\n" . 
            "status code: " . $res->code . "\n" .
            "content: " . $res->content . "\n"
        );
    }

    return $res;
}

sub _uri {
    my ($self, $cmd) = @_;
    
    return URI->new("http://$self->{host}:$self->{port}/d/$cmd");
}

1;

