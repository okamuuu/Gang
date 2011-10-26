package Gang::Model::Article;
use strict;
use warnings;
use Class::Accessor::Lite 0.05 (
    new => 1,
    ro  => [qw/_id _key title keywords content display_fg published_at created_at updated_at/]
);

sub columns { return qw/_id _key title keywords content display_fg published_at created_at updated_at/ }

sub list_columns { return qw/_id _key title keywords display_fg published_at created_at updated_at/ }

sub type_of {
    return (
        _id          => 'UInt32',
        _key         => 'ShortText',
        title        => 'ShortText',
        keywords     => 'ShortText',
        content      => 'Text',
        display_fg   => 'Bool',
        published_at => 'Time',
        created_at   => 'Time',
        updated_at   => 'Time',
    );
}

sub is_valid { return 1; }

1;

