package Gang::Service::Groonga;
use strict;
use warnings;
use Carp ();
use File::Which ();
use Test::TCP 1.10;

sub create {
    my ( $class, %args ) = @_;

    my $port = delete $args{port} || 10041;
    my $protocol = delete $args{protocol} || 'http';
    my $version = delete $args{default_command_version} || 2;
    my $bin = delete $args{bin} || scalar File::Which::which('groonga');
    my $db = delete $args{db} or Carp::croak("Missing db...");

    return Test::TCP->new(
        port => $port,
        code => sub {
            my $port = shift;

            # -s : server mode
            # -n : create a new db
            my @cmd = (
                $bin,                        '-s',
                '--default-command-version', $version,
                '--port',                    $port,
                '--protocol',                $protocol,
                -e $db ? $db : ( '-n', $db )
            );

            exec @cmd;
            die "cannot execute $bin: $!"; },
        );
}

1;
