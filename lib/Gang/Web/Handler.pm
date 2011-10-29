package Gang::Web::Handler;
use strict;
use warnings;
use Gang::Unit::TX;
use Gang::Web::Request;
use Gang::Web::Router;
use Gang::Web::Context;
use Plack::Request;
use Try::Tiny qw/try catch/;
use Carp ();

sub admin {
    my $class = shift;
  
    my $router = Gang::Web::Router->create;
    my $tx     = Gang::Unit::TX->new;

    return sub {
        my $env = shift;
        
        my $matched_route = $router->match($env) or return $class->_handle_404;

        my $req = Gang::Web::Request->new($env);
       
        my $context = Gang::Web::Context->new(
            renderer        => $tx,
            request         => $req,
            response        => $req->new_response(200),
            stash           => {},
        );

        try {
            ### XXX: add get_splats to Route?
            my @splats = $matched_route->{splat} ? @{ $matched_route->{splat} } : ();
            
            ### context run through in suited controllers with splats.
            $_->($context,@splats) for @{ $matched_route->{codes} }; 
        }
        catch {
            warn $_;
            return $class->_handle_500;
        };

        return $context->response->finalize;
    }
}

### TODO: Plack::Middleware::ErrorDocument
sub _handle_404 {
    my $class = shift;
    return [
        404, [ "Content-Type" => "text/plain", "Content-Length" => 13 ],
        ["404 Not Found"]
    ];
}

### TODO: Plack::Middleware::ErrorDocument
sub _handle_500 {
    my $class = shift;
    return [
        500, [ "Content-Type" => "text/plain", "Content-Length" => 21 ],
        ["Internal Server Error"]
    ];
}

1;

