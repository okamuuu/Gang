package Gang::Web::Controller::Root;
use strict;
use warnings;

sub auto {}

sub get_index {
    my ( $class, $c ) = @_;

    $c->res->body('get_index');
}

sub post_index {
    my ( $class, $c ) = @_;

    $c->res->body('post_index');
}

sub end {
    my ( $class, $c ) = @_;

    if ( $c->res->status == 301 ) { return; }

    if ( $c->stash->{template} ) {
        ### XXX: Template内部で$c->req->uri_withとかする為なのだがイマイチかも...
        my $content = $c->renderer->render( $c->stash->{template},
            { %{ $c->stash }, c => $c } );

        $c->res->body($content);
    }
}

1;

