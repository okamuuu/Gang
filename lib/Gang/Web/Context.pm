package Gang::Web::Context;
use strict;
use warnings;
use Class::Accessor::Lite 0.05 (
    ro=> [qw/request response stash/],
);

sub new {
    my $class = shift;
    my %args = @_ == 1 ? %{ $_[0] } : @_;

    bless {%args}, $class;
}

sub res { shift->response(@_); }

sub req { shift->request(@_); }

1;

