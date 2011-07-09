package Gang::Config;
use strict;
use warnings;
use Carp ();

my %CONFIG_OF = (
    mode => undef,
    grn_host => undef, # 必須にするか、どうしようか
    grn_port => undef, # 同上  
);

sub init {
    my $class = shift;
    my %args = @_ == 1 ? %{ $_[0] } : @_;

    ### 素直にSmart::Argsを使うか否か...
    my $mode = delete $args{mode}
      or Carp::croak("missing mandatory parameter named '\$mode'...");

    my $grn_host = delete $args{grn_host}
      or Carp::croak("missing mandatory parameter named '\$grn_host'...");

    my $grn_port = delete $args{grn_port}
      or Carp::croak("missing mandatory parameter named '\$grn_port'...");

    Carp::croak("initialized already...") if $CONFIG_OF{mode};

    ### deleteしないでそのまま%argsを渡せば良い気もするけど
    %CONFIG_OF =
      ( mode => $mode, grn_host => $grn_host, grn_port => $grn_port );
}

sub grn_host {
    _check_initilized();
    $CONFIG_OF{grn_host};
}

sub grn_port {
    _check_initilized();
    $CONFIG_OF{grn_port};
}

sub _check_initilized {
    Carp::croak('you must implement init function at first...')
      if not $CONFIG_OF{mode};
}

1;

