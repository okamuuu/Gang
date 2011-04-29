package Gang::Web::Router;
use strict;
use warnings;
use Gang::Web::Controller::Root;
use Gang::Web::Controller::Archive;
use Router::Simple::Sinatraish;

get '/' => sub { 'Root#get_index' }; 

post '/' => sub { 'Root#post_index' };

get '/archive/list' => sub { 'Archive#get_list' }; 

get '/archive/show' => sub { 'Archive#get_show' }; 

post '/archive/create' => sub { 'Archive#post_create' }; 

post '/archive/update' => sub { 'Archive#post_update' }; 

post '/archive/delete' => sub { 'Archive#post_delete' }; 

1;
