package Gang::Web::Handler;
use strict;
use warnings;
use Gang::Unit::TX;
use Gang::Web::Router;
use Gang::Web::Context;
use Plack::Request;
use Try::Tiny qw/try catch/;
use Carp ();

sub app {
    my $class = shift;
  
    my $router = Gang::Web::Router->router;

    return sub {
        my $env = shift;

        my $route = $router->match($env) or return $class->handle_404;

        my $req = Plack::Request->new($env);
        
        my $context = Gang::Web::Context->new(
            base_class => 'Gang::Web::Controller',
            root_controller => 'Gang::Web::Controller::Root',
            renderer => Gang::Unit::TX->new,
            request  => $req,
            response => $req->new_response(200),
            stash    => {},
        );

        try {    
            $context->run_through( $route->{code}->() );
        }
        catch {
            warn $_;
            return $class->handle_500;
        };
    
        return $context->response->finalize;
    }
}

sub handle_404 {
    my $class = shift;
    return [
        404, [ "Content-Type" => "text/plain", "Content-Length" => 13 ],
        ["404 Not Found"]
    ];
}

sub handle_500 {
    my $class = shift;
    return [
        500, [ "Content-Type" => "text/plain", "Content-Length" => 21 ],
        ["Internal Server Error"]
    ];
}

1;

