package Gang::Web::Router;
use strict;
use warnings;
use Router::Simple::Sinatraish;

get '/' => sub { 'Root#get_index' }; 

post '/' => sub { 'Root#post_index' };

1;
