package Gang::Groonga::Client;
use strict;
use warnings;
use Carp ();
use JSON ();
use LWP::UserAgent;
use Class::Accessor::Lite 0.05 (
    ro  => [qw/ua port host/]
);

sub new {
    my ($class, %params) = @_;
    $params{ua} = LWP::UserAgent->new();
    bless {%params}, $class; 
}

sub get_status {
    my $self = shift;

    my $uri = $self->_base_uri("status");
    my $res = $self->ua->get( $uri );

    Carp::croak("Groonga server has gone...") unless $res->is_success;

    return JSON::decode_json( $res->content );
}

sub lookup_by_key {
    my ($self, $table, $key) = @_;

    my $uri = $self->_base_uri("select");
    $uri->query_form(table => $table, query => "_key:$key" );

    warn $uri;

    my $res = $self->ua->get($uri);
    _croak_if_not_success($res); 

    return JSON::decode_json( $res->content );
}

sub _croak_if_not_success {
    my $res = shift;

    if ( not $res->is_success ) {
        Carp::croak(
            "Groonga server return error status\n" . 
            "status code: " . $res->code . "\n" .
            "content: " . $res->content . "\n"
        );
    }

    return $res;
}

sub _base_uri {
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

