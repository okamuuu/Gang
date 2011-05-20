package Gang::Model::Keyword;
use strict;
use warnings;

### keys %TYPE_OF を次の配列の並びで取り出せたら...
my @COLUMNS = qw/_id _key name display_fg created_at updated_at/;
my %TYPE_OF = (
    _id        => 'UInt32',
    _key       => 'ShortText',
    name       => 'ShortText',
    display_fg => 'Bool',
    created_at => 'Time',
    updated_at => 'Time',
);

use Class::Accessor::Lite 0.05 (
    new => 1,
    ro  => [@COLUMNS],
);

sub columns { return [@COLUMNS]; }

sub type_of { return {%TYPE_OF}; }

1;

