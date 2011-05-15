package Gang::Model::Article;
use strict;
use warnings;
use Class::Accessor::Lite 0.05 (
    new => 1,
    ro  => [qw/id _key title keywords_ref content/]
);

sub keywords { @{ $_[0]->{keywords_ref} } } 

1;

