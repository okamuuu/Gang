package Gang::Api::Admin;
use strict;
use warnings;
use parent 'Gang::Api::Base';
use Gang::Unit;
use Try::Tiny qw/try catch/;

sub create_keyword {1}

sub update_keyword {1}

sub delete_keyword {1}

sub listing_keyword {
    my ( $self, $key ) = @_;

    my $result;
    try { $result = Gang::Unit->grn->list('Keyword') } catch {};
    return $result;
}

sub lookup_keyword {
    my ($self, $key) = @_;

    1;
}

sub create_article {1}

sub update_article {1}

sub delete_article {1}

sub listing_article {1}

sub lookup_article {1}

1;

