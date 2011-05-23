package Gang::Model::Keyword;
use strict;
use warnings;

my (@COLUMNS, %TYPE_OF);

BEGIN {
    @COLUMNS = qw/_id _key name display_fg/;

    %TYPE_OF = (
        ### TODO: データ型はHTML5に合わせよう
        _id        => 'UInt32',
        _key       => 'ShortText',
        name       => 'ShortText',
        display_fg => 'Bool',
    );
}

use Class::Accessor::Lite 0.05 (
    new => 1,
    ro  => [@COLUMNS],
);

sub columns { return [@COLUMNS]; }

sub type_of { return {%TYPE_OF}; }

1;

