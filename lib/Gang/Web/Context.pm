package Gang::Web::Context;
use strict;
use warnings;
use Class::Accessor::Lite 0.05 (
    ro=> [qw/base_class root_class request response stash/],
);

sub new {
    my ($class, %args) = @_;
    return bless {%args}, $class;
}

sub res { shift->response(@_); }

sub req { shift->request(@_); }

sub run_through {
    my ( $self, $route ) = @_;

    $route =~ m/([^#]+)\#(.*)/ or return;

    my $controller = $self->base_class . "::$1";
    my $action     = $2;

    if ( $controller eq $self->root_class ) {

        $controller->auto($self)
          if $controller->can('auto');

        $controller->$action($self);

        $controller->end($self)
          if $controller->can('end');
    }
    else {
        $self->root_class->auto($self)
          if $self->root_class->can('auto');

        $controller->auto($self)
          if $controller->can('auto');

        $controller->$action($self);

        $controller->end($self)
          if $controller->can('end');

        $self->root_class->end($self)
          if $self->root_class->can('end');
    }

}

1;

