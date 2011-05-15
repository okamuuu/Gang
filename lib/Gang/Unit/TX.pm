package Gang::Unit::TX;
use strict;
use warnings;
use Text::Xslate ();
use File::Spec ();
use Cwd ();
use Class::Accessor::Lite 0.05 ( ro => [qw/tx template/] );

sub new {
    my ( $class, %args ) = @_;

    my $template = $args{template} || 'template';

    my $tx = Text::Xslate->new(
        path      => [_dir($template)],
        cache_dir => _dir('tmp'),
        function  => {
            html_unescape => sub {
                Text::Xslate::mark_raw(shift);
            },
        },
    );

    return bless {
        template => $template,
        tx       => $tx,
    }, $class;
}

sub render {
    my ($self, $path, $vars) = @_;

    return $self->tx->render($path, $vars);
}

sub _dir { return File::Spec->catdir( Cwd::cwd, @_ ); }

1;
 

