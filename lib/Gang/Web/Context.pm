package Gang::Web::Context;
use strict;
use warnings;
use Class::Accessor::Lite 0.05 (
    ro=> [qw/base_controller root_controller renderer request response stash/],
);

sub new {
    my ($class, %args) = @_;
    return bless {%args}, $class;
}

sub res { shift->response(@_); }

sub req { shift->request(@_); }

sub run_through {
    my ( $self, $route ) = @_;

    $route->{code}->() =~ m/([^#]+)\#(.*)/ or return;

    my @namespaces = split '::', $1;
    my $action     = $2;
    my @captures   = @{ $route->{capture} };

    my $controller = $self->base_controller;

    my (@pre_actions, @post_actions); 
    for my $name ( @namespaces ) {
        $controller .= "::$name"; 
        
        push @pre_actions, $controller->can('auto')
          if $controller->can('auto');
        unshift @post_actions, $controller->can('end')
          if $controller->can('end');

    }

    if ( $controller ne $self->root_controller ) {
        push @pre_actions, $self->root_controller->can('auto')
          if $self->root_controller->can('auto');
        unshift @post_actions, $self->root_controller->can('end')
          if $self->root_controller->can('end');
    }

    my $main_action = $controller->can($action);
    
    for my $action ( @pre_actions, $main_action, @post_actions ) {
        $action->( undef, $self);
    }

}

1;

