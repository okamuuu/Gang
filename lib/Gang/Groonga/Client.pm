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

sub get_status { return $_[0]->_cmd("status"); }

sub _cmd {
    my ( $self, $cmd ) = @_;

    my $res =
      $self->ua->get("http://@{[ $self->host ]}:@{[ $self->port ]}/d/$cmd");

    Carp::croak("Groonga server has gone...") unless $res->is_success;

    return JSON::decode_json($res->content);
}

1;

