package Gang::Groonga::Client;
use strict;
use warnings;
use Carp ();
use JSON ();
use Data::Page;
use LWP::UserAgent;
use Class::Accessor::Lite 0.05 (
    ro  => [qw/ua port host/]
);

sub new {
    my ($class, %params) = @_;
    $params{ua} ||= LWP::UserAgent->new();
    bless {%params}, $class; 
}

sub get_status {
    my $self = shift;

    my $uri = $self->_uri("status");
    my $res = $self->get( $uri );

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

    warn $uri;
    
    my $data = JSON::decode_json( $self->get($uri)->content );
 
    my ($count, $column_infos_ref, @values_list) = @{ $data->[1]->[0] };
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

sub lookup_by_key {
    my ( $self, $table, $key ) = @_;

    my $uri = $self->_uri("select");
    $uri->query_form( table => $table, query => "_key:$key" );

    my $data = JSON::decode_json( $self->get($uri)->content );

    ### 都度配列展開するので素直にテーブル毎にクラス化?
    my @names  = map { $_->[0] } @{ $data->[1]->[0]->[1] };
    my @values = @{ $data->[1]->[0]->[2] };

    my %columns = map { $names[$_] => $values[$_] } ( 0 .. $#names );

    return {%columns};
}

sub get {
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

### stolen from FrePAN::FTS.pm
sub make_query {
    my ( $self, $query ) = @_;

    my $ret = '';
    for my $part (split /\s+/, $query) {
        if ($part =~ s/^-//) {
            $ret .= qq{ - "$part"} if $ret;
        } else {
            $ret .= qq{ + } if $ret;
            $ret .= qq{"$part"};
        }
    }
    warn "QUERY IS: $ret";
    return $ret;
}

1;

