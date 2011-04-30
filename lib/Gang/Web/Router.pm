package Gang::Web::Router;
use strict;
use warnings;
use Gang::Web::Controller::Root;
use Gang::Web::Controller::Article;
use Router::Simple::Sinatraish;

get '/' => sub { 'Root#get_index' }; 

post '/' => sub { 'Root#post_index' };

get '/article/list' => sub { 'Article#get_list' }; 

get '/article/show' => sub { 'Article#get_show' }; 

post '/article/create' => sub { 'Article#post_create' }; 

post '/article/update' => sub { 'Article#post_update' }; 

post '/article/delete' => sub { 'Article#post_delete' }; 

1;
