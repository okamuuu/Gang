use Gang::Web::Handler;
use Plack::Builder;

builder {
    enable 'Plack::Middleware::Static', path => qr{^/static/}, root => 'root/';
    Gang::Web::Handler->app;
};


