package Gang::Unit;
use strict;
use warnings;
use Gang::Groonga::Client;

my $CACHE;

sub grn {
    return $CACHE->{grn} ||= Gang::Groonga::Client->new();
}

1;

