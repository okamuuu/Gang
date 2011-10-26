package Gang::Web::Router;
use strict;
use warnings;
use Carp();
use Gang::Web::Controller::Root;
use Gang::Web::Controller::Keyword;
use Gang::Web::Controller::Article;
use Router::Simple::Sinatraish;

sub base_controller { 'Gang::Web::Controller' }

sub root_controller { 'Gang::Web::Controller::Root' }

sub create {
    my $class = shift;
    my $router = $class->router;
   
    for my $route ( @{ $router->{routes} } ) {

        $route->dest->{code}->() =~ m/([^#]+)\#(.*)/ or Carp::croak("Not Found Controller...");

        my @namespaces = split '::', $1; 
        my $action     = $2; 

        my $controller = $class->base_controller;
        my (@pre_actions, @post_actions); 
    
        for my $name ( @namespaces ) { 
            $controller .= "::$name"; 
    
            push @pre_actions, $controller->can('auto')
                if $controller->can('auto');
            unshift @post_actions, $controller->can('end')
                if $controller->can('end');
        }  

        if ( $controller ne $class->root_controller ) {
        push @pre_actions, $class->root_controller->can('auto')
          if $class->root_controller->can('auto');
        unshift @post_actions, $class->root_controller->can('end')
          if $class->root_controller->can('end');
        }

        my $main_action = $controller->can($action)
        or Carp::croak("Not Found $action...");

        $route->dest->{codes} = [@pre_actions, $main_action, @post_actions];
    }
    return $router;
}

get '/' => sub { 'Root#get_index' }; 

get '/article/' => sub { 'Article#get_index' }; 
get '/article/list' => sub { 'Article#get_list' }; 
get '/article/show/*' => sub { 'Article#get_show' }; 

get '/article/create' => sub { 'Article#get_create' }; 
post '/article/create' => sub { 'Article#post_create' }; 

get '/article/edit/*' => sub { 'Article#get_edit' }; 
post '/article/edit/*' => sub { 'Article#post_edit' }; 

get '/article/delete/*' => sub { 'Article#get_delete' }; 
post '/article/delete/*' => sub { 'Article#post_delete' }; 

get '/keyword/' => sub { 'Keyword#get_index' }; 
get '/keyword/list' => sub { 'Keyword#get_list' }; 
get '/keyword/show/*' => sub { 'Keyword#get_show' }; 

get '/keyword/create'  => sub { 'Keyword#get_create' };
post '/keyword/create' => sub { 'Keyword#post_create' };

get '/keyword/edit/*' => sub { 'Keyword#get_edit' }; 
post '/keyword/edit/*' => sub { 'Keyword#post_edit' }; 

get '/keyword/delete/*' => sub { 'Keyword#get_delete' }; 
post '/keyword/delete/*' => sub { 'Keyword#post_delete' }; 


1;

