package Gang::Service::Groonga;
use strict;
use warnings;
use Gang::Path;
use Carp ();
use File::Which ();
use Test::TCP 1.10;

sub create {
    my ( $class, %args ) = @_;

    my $db = delete $args{db} or Carp::croak("Missing db...");

    my $version = delete $args{default_command_version}
      or Carp::croak("Missing default_command_version...");

    my $bin  = delete $args{bin}  || scalar File::Which::which('groonga');
    my $port = delete $args{port} || 10041;

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
                '--protocol',                'http',
                -e $db ? $db : ( '-n', $db )
            );

            exec @cmd;
            die "cannot execute $bin: $!"; },
        );
}

sub _get_groonga_schema {


}

1;
