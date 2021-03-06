package Gang::Web::Controller::Root;
use strict;
use warnings;
use Encode ();

sub get_index {
    my ( $c ) = @_;
    
    $c->res->redirect('/article/list');
}

sub end {
    my ( $c ) = @_;

    if ( $c->res->status == 301 ) { return; }

    if ( $c->stash->{template} ) {
        my $content = $c->renderer->render( $c->stash->{template},
            { %{ $c->stash }, c => $c } );

        $content = utf8::is_utf8($content) ? Encode::encode_utf8($content) : $content; 

        $c->res->body($content);
    }
}

1;

