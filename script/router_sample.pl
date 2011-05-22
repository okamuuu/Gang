use strict;
use warnings;
use Router::Simple;
use Data::Dumper;

my $router = Router::Simple->new();
$router->connect( '/blog/*/*',
    { controller => 'Blog', action => 'monthly' } );

my $env = {
    'PATH_INFO'      => '/blog/2011/05',
    'REQUEST_METHOD' => 'GET',
};

print Dumper my $matched_route = $router->match($env);

=result
$VAR1 = {
          'controller' => 'Blog',
          'month' => '05',
          'action' => 'monthly',
          'year' => '2011'
        };
=cut

1;

