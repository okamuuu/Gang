package Gang::Web::Router;
use strict;
use warnings;
use Carp();
use Gang::Web::Controller::Root;
use Gang::Web::Controller::Admin;
use Gang::Web::Controller::Admin::Keyword;
use Gang::Web::Controller::Article;
use Router::Simple::Sinatraish;

sub base_controller { 'Gang::Web::Controller' }

sub root_controller { 'Gang::Web::Controller::Root' }

sub create {
    my $class = shift;
    my $router = $class->router;
   
    for my $route ( @{ $router->{routes} } ) {

        use Data::Dumper;
        warn Dumper $route;

        $route->dest->{code}->() =~ m/([^#]+)\#(.*)/ or Carp::croak("Not Found Controller...");

        my @namespaces = split '::', $1; 
        my $action     = $2; 
        #my @splats     = $route->{splat} ? @{ $route->{splat} } : (); 

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

#    for my $action ( @pre_actions, $main_action, @post_actions ) {
#        $action->( undef, $class, @splats); ### XXX: main_actionにだけ@splats渡したい
#    }

        $route->dest->{codes} = [@pre_actions, $main_action, @post_actions];
    }
    return $router;
}


get '/' => sub { 'Root#get_index' }; 

post '/' => sub { 'Root#post_index' };

get '/article/list' => sub { 'Article#get_list' }; 

get '/article/show' => sub { 'Article#get_show' }; 

post '/article/create' => sub { 'Article#post_create' }; 

post '/article/update' => sub { 'Article#post_update' }; 

post '/article/delete' => sub { 'Article#post_delete' }; 

get '/admin/keyword/' => sub { 'Admin::Keyword#get_index' }; 

get '/admin/keyword/show/*' => sub { 'Admin::Keyword#get_show' }; 

get '/admin/keyword/create'  => sub { 'Admin::Keyword#get_create' };
post '/admin/keyword/create' => sub { 'Admin::Keyword#post_create' };

get '/admin/keyword/edit/*' => sub { 'Admin::Keyword#get_edit' }; 
post '/admin/keyword/edit/*' => sub { 'Admin::Keyword#post_edit' }; 

get '/admin/keyword/delete/*' => sub { 'Admin::Keyword#get_delete' }; 
post '/admin/keyword/delete/*' => sub { 'Admin::Keyword#post_delete' }; 

get '/admin/keyword/list' => sub { 'Admin::Keyword#get_list' }; 

1;

