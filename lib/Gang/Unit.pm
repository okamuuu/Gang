package Gang::Unit;
use strict;
use warnings;
use Gang::Config;
use Gang::Groonga::Client;

my $CACHE;

sub grn {
    return $CACHE->{grn} = Gang::Groonga::Client->new(
            host => Gang::Config->grn_host,
            port => Gang::Config->grn_port,
    );
}

1;

