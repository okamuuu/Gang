package Gang::Model::Keyword;
use strict;
use warnings;
use Class::Accessor::Lite 0.05 (
    new => 1,
    ro  => [qw/_id _key name display_fg/],
);

sub columns { return [qw/_id _key name display_fg/] }

sub type_of { 
    ### TODO: データ型はHTML5に合わせよう
    return {
        _id        => 'UInt32',
        _key       => 'ShortText',
        name       => 'ShortText',
        display_fg => 'Bool',
    };
}

1;

